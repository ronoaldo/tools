#!/bin/bash
#
# Easy way to build a linux kernel on Debian
#
# Copyright (C) 2013 Ronoaldo JLP <ronoaldo@gmail.com>

set -e

# Allows configuration of default 'run as sudo' command.
export SUDO="${SUDO:-sudo}"
export KVER="3.7.10"
export BUILD="1"
export LOG="$PWD/linux-$(date +%Y%d%m-%H%M%S).log"

# Print a information message
info() {
	echo "[ INFO] $*"
}

# Print a warning message
warn() {
	echo "[ WARN] $*"
}

# Print an error message
error() {
	echo "[ERROR] $*"
}

# Prompts the user for a question, and check if 
# the answer is yes.
# 
# returns 0 if yes, 1 if no
confirm() {
	read -p"$* (y|n) " answer
	case "$answer" in
		[yY][eE][sS]|[yY]) return 0 ;;
		*) return 1;;
	esac
}

# Check the package instalation status
# 
# returns 0 if properly installed, 1 otherwise
is_pkg_installed() {
	dpkg --status $1 | grep -q "install ok installed"
}

# Install all build dependencies for the kernel, that aren't
# installed yet.
install_build_dependencies() {
	export to_install=""
	for pkg in kernel-package fakeroot libncurses5-dev ; do
		if ! is_pkg_installed "$pkg" ; then
			export to_install="$to_install $pkg"
		fi
	done
	if [ ! -z "$to_install" ] ; then
		info "Installing build dependencies '$to_install' ..."
		$SUDO apt-get install $pkg
	fi
}

fetch_kernel() {
	if [ ! -f linux-$KVER.tar.bz2 ] ; then
		info "Downloading kernel sources ..."
		wget -c "http://www.kernel.org/pub/linux/kernel/v3.0/linux-$KVER.tar.bz2"
	fi
}

unpack_kernel() {
	if [ -d linux-$KVER ] ; then
		info "Linux kernel already unpacked."
		return 0
	fi
	info "Unpacking kernel sources ..."
	tar xf linux-$KVER.tar.bz2
}

check_current_config() {
	if [ -f .config ] ; then
		if confirm "Overwrite .config ?" ; then
			echo "Backing up current .config as ../config-$(date +%Y%m%d-%H%M%S)"
		else
			exit 2
		fi
	fi
}

# Performs a "safe configuration" for the new kernel, based on the
# current one.
safe_config() {
	check_current_config
	info "Performing safe configuration, based on running kernel config ..."
	cp /boot/config-$( uname -r ) .config -v
	yes "" | make oldconfig > config.new
	info "Configuration done. Review linux-$KVER/config.new to see what was chosen."
	
	if confirm "Do you want to run make menuconfig to do manual settings?" ; then
		make menuconfig
	fi
}

# Configures built-in for current loaded modules using local config,
# then makes all new/optional stuff as modules
optimized_config() {
	check_current_config
	info "Performing an optimized configuration"
	warn "*** Not implemented yet ***"
}

local_version() {
	VERSION="$(grep "CONFIG_LOCALVERSION=" .config | cut -f 2 -d '=' | sed -e 's;-;+;g' |\
		sed -e 's;";;g' | sed -e 's;^+;;g')"
	if [ ! -z "$VERSION" ] ; then
		echo "$VERSION~"
	else
		echo ""
	fi
}

# Starts the kernel build process
build_packages() {
	REV="$KVER~$(local_version)custom$BUILD"
	
	info "Your kernel will be compiled now."
	info "You may want to take one coffee. Or maybe two ..."
	info " Your kernel revision will be $REV"
	
	LOG="linux-image-$REV.build"
	TIME="linux-image-$REV.build.time"

	/usr/bin/time -p --output "$TIME" --append \
		fakeroot make-kpkg --initrd --revision="$REV" \
		$BUILD_ARGS binary 2>&1 | tee $LOG
}

usage() {
	cat <<EOF
Usage $0 [OPTIONS]

Where OPTIONS can be:
	--kernel-version|-k
		Configures the kernel version (default=$KVER)
	--fast
		Enable multiple jobs in parallel. $(grep -c '^processor' /proc/cpuinfo) jobs
	--build-number|-b
		Enables a specific build number after 
		"~custom" on kernel package revision
	--safe-config
		Try to safely configure the kernel
	--help
		Prints this help and ext
EOF
}

### Main ###

install_build_dependencies
fetch_kernel
unpack_kernel

# Parses the CLI options and configurations.
while [ $# -gt 0 ] ; do
	case $1 in
		--kernel-version|-k)
			shift
			export KVER="$1"
		;;

		--fast)
			warn "Building with maximal usage of CPU"
			export BUILD_ARGS="$BUILD_ARGS -j $(grep -c '^processor' /proc/cpuinfo)"
		;;

		--safe-config)
			cd linux-$KVER
			safe_config
			cd ..
		;;

		--build-number|-b)
			shift
			export BUILD="$1"
		;;
		*)
			usage
			exit 1
		;;
	esac
	shift
done

cd linux-$KVER
build_packages
