#!/usr/bin/bash

export PROGRAM="$(basename $0)"

# log: shows porgram message logs
log() {
	echo "[flatpak-gen-shims] $@"
}

# create_shim: creates a small launcher script with the command name from the Flatpak
create_shim() {
	appid="$1"
	cmd="$2"
	shim="$HOME/.flatpak/bin/$cmd"

	cat > $shim <<EOF
#!/usr/bin/env sh
# Flapak shim created by $PROGRAM
exec flatpak run $appid "\$@"
EOF
	chmod +x $shim
}

#
# Main
#

log "Removing old shims from ~/.flatpak/bin "
rm -rvf ~/.flatpak/bin/*

log "Creating new shims at ~/.flatpak/bin for all installed apps ... "
mkdir -p ~/.flatpak/bin
flatpak list --app --columns=application | while read appid ; do
	cmd="$(flatpak info -m $appid | awk -F= '/^command=/ {print $2}')"
	cmd="$(basename $cmd)"
	log "Creating shim for $appid => $cmd"
	create_shim "$appid" "$cmd"
done

