#!/bin/bash
# repack-im.sh: Download IM (Image) core + Lua binding
# tarballs from Tecgraf/SourceForge and combine into a single
# tarball for use with the iuplua-im LuaRocks rockspec.
#
# Usage:
#   bash repack-im.sh [LUA_VERSION] [KERNEL]
#
# Examples:
#   bash repack-im.sh 54 Linux515_64
#   bash repack-im.sh 54 Linux68_64
#
# Output:
#   iuplua-im-3.32-Lua<LUA>_<KERNEL>.tar.gz

set -e

IM_VERSION="3.15"
IUP_VERSION="3.32"
LUA_VERSION="${1:-54}"
KERNEL="${2:-Linux515_64}"

BASE_URL="https://sourceforge.net/projects/imtoolkit/files"
CORE_URL="${BASE_URL}/${IM_VERSION}/Linux%20Libraries"
LUA_URL="${CORE_URL}/Lua${LUA_VERSION}"

CORE_TAR="im-${IM_VERSION}_${KERNEL}_lib.tar.gz"
LUA_TAR="im-${IM_VERSION}-Lua${LUA_VERSION}_${KERNEL}_lib.tar.gz"
OUT_TAR="iuplua-im-${IUP_VERSION}-Lua${LUA_VERSION}_${KERNEL}.tar.gz"

WORK=$(mktemp -d)
trap "rm -rf $WORK" EXIT

echo "=== Downloading core: ${CORE_TAR}"
wget -q "${CORE_URL}/${CORE_TAR}/download" \
    -O "${WORK}/${CORE_TAR}"

echo "=== Downloading Lua bindings: ${LUA_TAR}"
wget -q "${LUA_URL}/${LUA_TAR}/download" \
    -O "${WORK}/${LUA_TAR}"

OUT_DIR="${WORK}/iuplua-im-${IUP_VERSION}"
mkdir -p "${OUT_DIR}"

echo "=== Extracting core"
tar xzf "${WORK}/${CORE_TAR}" -C "${OUT_DIR}"

echo "=== Extracting Lua bindings"
tar xzf "${WORK}/${LUA_TAR}" -C "${OUT_DIR}"

echo "=== Adding Makefile"
cat > "${OUT_DIR}/Makefile" << 'MAKEFILE'
# Makefile for iuplua-im LuaRocks rockspec.
# Installs IM core libs to /usr/local/lib and
# Lua binding .so files to $(LIBDIR).
#
# Variables set by LuaRocks:
#   LIBDIR  - Lua C module directory

LIBDIR ?= /usr/local/lib/lua/5.4

.PHONY: install
install:
	install -d /usr/local/lib
	@# Install all IM core .so files
	for f in libim*.so; do \
		if [ -f $$f ]; then \
			install -m 755 $$f /usr/local/lib/; \
		fi; \
	done
	ldconfig /usr/local/lib 2>/dev/null || true
	install -d $(LIBDIR)
	@# Install Lua bindings to LIBDIR, renaming:
	@#   libimlua54.so -> imlua.so
	for f in libimlua*.so; do \
		dst=$$(echo $$f \
			| sed 's/^lib//' \
			| sed 's/[0-9][0-9]\.so$$/.so/'); \
		install -m 755 $$f $(LIBDIR)/$$dst; \
	done
	@# Also keep originals in /usr/local/lib so the
	@# dynamic linker resolves cross-module deps
	for f in libimlua*.so; do \
		if [ -f $$f ]; then \
			install -m 755 $$f /usr/local/lib/; \
		fi; \
	done
	ldconfig /usr/local/lib 2>/dev/null || true
MAKEFILE

echo "=== Creating ${OUT_TAR}"
tar czf "${OUT_TAR}" -C "${WORK}" \
    "iuplua-im-${IUP_VERSION}"

echo "=== Done: ${OUT_TAR}"
echo ""
echo "Upload to GitHub releases:"
echo "  gh release upload v${IUP_VERSION} ${OUT_TAR} --clobber"
