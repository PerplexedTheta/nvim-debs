#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)" # get current script dir portibly


## check we are sudo
if [[ "${EUID}" -ne 0 ]]; then
	echo "Please run as root (or sudo)."
	exit 1
fi


## source .env if we can
if [[ -f "${SCRIPT_DIR}/.env" ]]; then
	source ${SCRIPT_DIR}/.env
fi


## ensure version & arch are set
if [ -z "${ARCH}" ]; then
	ARCH=$(arch)""
fi
if [ -z "${VERSION}" ]; then
	echo -ne "Please export or set VERSION variable\n"
	exit 1
fi
EPOCH=$(date +%s)""
if [ "${ARCH}" == "amd64" ]; then
    URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/nvim-linux-x86_64.tar.gz"
elif [ "${ARCH}" == "arm64" ]; then
    URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/nvim-linux-arm64.tar.gz"
else
    echo "CPU arch not supported!"
    exit 1
fi

export ARCH="${ARCH}"
export VERSION="${VERSION}"
export EPOCH="${EPOCH}"
export URL="${URL}"

## install deps
apt update 2>/dev/null
apt install build-essential file checkinstall wget rsync -y 2>/dev/null


## run make
cd "${SCRIPT_DIR}"
make


## run makeinstall
checkinstall --install=no \
	--pkgname=neovim \
	--pkgversion=${VERSION} \
	--pkgrelease=${EPOCH} \
	--pkgarch=${ARCH} \
	--maintainer="hosting@ptfs-europe.com" \
	--conflicts="neovim-runtime" \
	--review-control \
	--strip=no \
	--stripso=no \
	-d2 \
	make install


## tidyup
make clean
git checkout -- .

mkdir -pv ./dist
mv -v ./*.deb ./dist
mv -v ./checkinstall-debug.*.tgz ./dist
