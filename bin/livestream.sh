#!/usr/bin/bash
set -e
[ x"$DEBUG" = x"true" ] && set -x

install_twitch_cli() {
    URL="https://github.com/twitchdev/twitch-cli/releases/download/v1.1.6/twitch-cli_1.1.6_Linux_x86_64.tar.gz"
    TMP="$(mktemp)"
    curl -sL --fail "${URL}" > /tmp/twitch.tar.gz
    tar -tf /tmp/twitch.tar.gz  | grep 'twitch$' | sudo xargs tar --strip-components 1 -C /usr/local/bin/ -xf /tmp/twitch.tar.gz
}

install_youtube_cli() {
    URL="https://github.com/ronoaldo/ogle/releases/download/v0.1.0-beta2/ogle_0.1.0-beta2_Linux_x86_64.tar.gz"
    TMP="$(mktemp)"
    curl -sL --fail "${URL}" > ${TMP}
    sudo tar -C /usr/local/bin/ -xf "${TMP}" "youtube"
}

login_to_twitch() {
    twitch token --user-token --scopes 'channel:manage:broadcast'
}

login_to_youtube() {
    youtube -cmd logout
    youtube -cmd channels
}

setup_streams() {
    PLATFORM="$1"
    GAME_NAME="$2"
    echo "[ Configuring ${PLATFORM} ]"
    echo "Game title '$GAME_NAME'"

    case $PLATFORM in
        twitch)
            export BROADCASTER_ID="$(twitch api get /users -q "login=${CHANNEL}" | jq -r '.data[0].id')"
            export GAME_ID=$(twitch api get /games -q "name=$GAME_NAME" | jq -r '.data[0].id')
            case $GAME_ID in
                [0-9]*[0-9] ) echo "Found game with ID: ${GAME_ID}" ;;
                *           ) echo "No game found for '${GAME_NAME}': '${GAME_ID}'" ; exit 1 ;;
            esac
            echo "twitch.tv/${CHANNEL} (broadcaster_id=${BROADCASTER_ID})"
            echo "Updating twitch stream with game_id=${GAME_ID}(${GAME_NAME}), title=${TITLE}"
            twitch api patch /channels -q "broadcaster_id=${BROADCASTER_ID}" \
                -b "{\"game_id\": \"${GAME_ID}\", \"title\": \"${TITLE}\"}"
        ;;
        youtube)
            export STREAM_ID="$(youtube -cmd lives | grep ready  | awk '{print $3}')"
            echo "youtube.com/c/${CHANNEL} (video_id=${STREAM_ID})"
            youtube -cmd live-update  -video "${STREAM_ID}" -title "$TITLE" -desc "Playing ${GAME_NAME}"
            case $GAME_NAME in
                *[Dd]evelopment*)
                    youtube -cmd video-update -video "${STREAM_ID}" -tags "${GAME_NAME}"
                ;;
                *)
                    youtube -cmd video-update -video "${STREAM_ID}" -tags "linux,gaming,${GAME_NAME}"
                ;;
            esac
        ;;
    esac
    echo
}

# Based on https://unix.stackexchange.com/a/507474/174769
mask() {
        local n=6                    # number of chars to leave
        local a="${1:0:${#1}-n}"     # take all but the last n chars
        local b="${1:${#1}-n}"       # take the final n chars
        printf "%s%s\n" "${a//?/*}" "$b"   # substitute a with asterisks
}

main() {
    echo "$(basename $0) - version 1.0"
    echo

    # Check enabled configuration for the channel
    CONFIG="$HOME/.config/livestream-${CHANNEL}.env"
    source $CONFIG || {
        echo "Add TWITCH_TOKEN and YOUTUBE_TOKEN to ${CONFIG}"
        exit 1
    }
    echo "[ Configuration loaded ]"
    echo "   TWITCH_TOKEN='$(mask "$TWITCH_TOKEN")'"
    echo "  YOUTUBE_TOKEN='$(mask "$YOUTUBE_TOKEN")'"
    echo

    echo "[ Stream setup ]"
    read -p "Game you are playing: " GAME_NAME
    read -p "Stream title: " TITLE
    echo

    if [ x"${TWITCH_TOKEN}" != x"" ] ; then
        export PUBLISH_TO="rtmp://live.twitch.tv/app/${TWITCH_TOKEN}"
        # Check twitch cli
        twitch version 2>/dev/null >/dev/null || install_twitch_cli
        twitch api get /users -q "login=${CHANNEL}" 2>/dev/null >/dev/null || login_to_twitch
        setup_streams twitch "$GAME_NAME"
    fi

    if [ x"${YOUTUBE_TOKEN}" != x"" ] ; then
        export PUBLISH_TO="${PUBLISH_TO},rtmp://a.rtmp.youtube.com/live2/${YOUTUBE_TOKEN}"
        # Check youtube cli
        youtube --help 2>/dev/null >/dev/null || install_youtube_cli
        youtube -cmd channels 2>/dev/null >/dev/null || login_to_youtube
        setup_streams youtube "$GAME_NAME"
    fi
    
    echo "[ Multi-stream ]"
    echo "Launching multiple streams with Docker jasonrivers/nginx-rmtp ..."
    docker run -it --rm --name multi-streaming \
        -p 1935:1935 \
        -p 8080:8080 \
        -e RTMP_PUSH_URLS="$PUBLISH_TO" \
        jasonrivers/nginx-rtmp:latest 2>&1 | sed -e 's,/live[_2/].*$,/live**************\r,g'
}

export CHANNEL="$1"
case $CHANNEL in
    ""|h|help|-h|-help|--help)
        echo "Missing channel argument. Usage: $(basename $0) CHANNEL_NAME"
        echo "Currently, channel name must be the same for both Twitch.tv and YouTube"
        exit 1
    ;;
esac

main
