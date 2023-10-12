#!/bin/bash
set -e
[[ -n "${DEBUG}" ]] && set -x

# TODO: check dependencies installed: yq

# Helpers
HOME=$(mktemp -d)
export HOME

DOCKER="docker run --rm -v \
	${PWD}:/workspace -v ${HOME}:/home/builder \
	-e HOME=/home/builder --user=$(id -u) --workdir=/workspace"
export DOCKER

YAML="${1:-./cloudbuild.yaml}"
export YAML

fatal() { echo "cloudbuild.sh: fatal error: $*" ; exit 1; }
usage() {
	cmd="$(basename "$0")"
	cat <<EOF
$cmd: parse and execute cloudbuild.yaml steps.

Usage: $cmd [-h|--help] [YAML_FILE]

Where:
	YAML_FILE is an optional alternative to ./cloudbuild.yaml

	-h|--help will print this help and exit.
EOF
}

# Sanity check
[[ -f "${YAML}" ]] || fatal "${YAML} not found"
case "$*" in --help|-h) usage ; exit 1 ;; esac

# Parse cloudbuild.yqml and call docker for each step
STEP=0
DEFAULT_IFS="${IFS}"
while read -r IMAGE ENTRYPOINT ARGS ; do
	STEP=$((STEP + 1))
	IFS="${DEFAULT_IFS}";
	
	echo ">>>>>> STEP #${STEP}"
	echo
	if [[ "${ENTRYPOINT}" == "--entrypoint=" ]] ; then
		# shellcheck disable=SC2086
		${DOCKER} "${IMAGE}" ${ARGS}
		RESULT=$?
	else
		# shellcheck disable=SC2086
		${DOCKER} "${ENTRYPOINT}" "${IMAGE}" ${ARGS}
		RESULT=$?
	fi
	echo
	echo "<<<<<< FINISHED #${STEP} WITH STATUS ${RESULT}"
	echo
done < <(
	paste --delimiters="\t" \
	<(yq -r '.steps[].name' cloudbuild.yaml) \
	<(yq -r '("--entrypoint=" + .steps[].entrypoint)' cloudbuild.yaml) \
	<(yq -r '.steps[].args|join(" ")' cloudbuild.yaml)
)

echo
echo "Execution finished with ${STEP} steps"
echo "Home state preserved at ${HOME}"
echo