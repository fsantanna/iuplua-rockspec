#!/bin/bash
# repack-cd.sh: Download CD (Canvas Draw) core + Lua binding
# tarballs from Tecgraf/SourceForge and combine into a single
# tarball for use with the iuplua-cd LuaRocks rockspec.
#
# Usage:
#   bash repack-cd.sh [LUA_VERSION] [KERNEL]
#
# Examples:
#   bash repack-cd.sh 54 Linux515_64
#   bash repack-cd.sh 54 Linux68_64
#
# Output:
#   iuplua-cd-3.32-Lua<LUA>_<KERNEL>.tar.gz

set -e

CD_VERSION="5.14"
IUP_VERSION="3.32"
LUA_VERSION="${1:-54}"
KERNEL="${2:-Linux515_64}"

BASE_URL="https://sourceforge.net/projects/canvasdraw/files"
CORE_URL="${BASE_URL}/${CD_VERSION}/Linux%20Libraries"
LUA_URL="${CORE_URL}/Lua${LUA_VERSION}"

CORE_TAR="cd-${CD_VERSION}_${KERNEL}_lib.tar.gz"
LUA_TAR="cd-${CD_VERSION}-Lua${LUA_VERSION}_${KERNEL}_lib.tar.gz"
OUT_TAR="iuplua-cd-${IUP_VERSION}-Lua${LUA_VERSION}_${KERNEL}.tar.gz"

WORK=$(mktemp -d)
trap "rm -rf $WORK" EXIT

echo "=== Downloading core: ${CORE_TAR}"
wget -q "${CORE_URL}/${CORE_TAR}/download" \
    -O "${WORK}/${CORE_TAR}"

echo "=== Downloading Lua bindings: ${LUA_TAR}"
wget -q "${LUA_URL}/${LUA_TAR}/download" \
    -O "${WORK}/${LUA_TAR}"

OUT_DIR="${WORK}/iuplua-cd-${IUP_VERSION}"
mkdir -p "${OUT_DIR}"

echo "=== Extracting core"
tar xzf "${WORK}/${CORE_TAR}" -C "${OUT_DIR}"

echo "=== Extracting Lua bindings"
tar xzf "${WORK}/${LUA_TAR}" -C "${OUT_DIR}"

echo "=== Adding Makefile"
cat > "${OUT_DIR}/Makefile" << 'MAKEFILE'
# Makefile for iuplua-cd LuaRocks rockspec.
# Installs CD core libs to /usr/local/lib and
# Lua binding .so files to $(LIBDIR).
#
# Variables set by LuaRocks:
#   LIBDIR  - Lua C module directory

LIBDIR ?= /usr/local/lib/lua/5.4

.PHONY: install
install:
	install -d /usr/local/lib
	@# Install all CD core .so files
	for f in libcd*.so libfreetype*.so libpdflib*.so; do \
		if [ -f $$f ]; then \
			install -m 755 $$f /usr/local/lib/; \
		fi; \
	done
	ldconfig /usr/local/lib 2>/dev/null || true
	install -d $(LIBDIR)
	@# Install Lua bindings to LIBDIR, renaming:
	@#   libcdlua54.so -> cdlua.so
	for f in libcdlua*.so; do \
		dst=$$(echo $$f \
			| sed 's/^lib//' \
			| sed 's/[0-9][0-9]\.so$$/.so/'); \
		install -m 755 $$f $(LIBDIR)/$$dst; \
	done
	@# Also keep originals in /usr/local/lib so the
	@# dynamic linker resolves cross-module deps
	for f in libcdlua*.so; do \
		if [ -f $$f ]; then \
			install -m 755 $$f /usr/local/lib/; \
		fi; \
	done
	ldconfig /usr/local/lib 2>/dev/null || true
MAKEFILE

echo "=== Creating ${OUT_TAR}"
tar czf "${OUT_TAR}" -C "${WORK}" \
    "iuplua-cd-${IUP_VERSION}"

echo "=== Done: ${OUT_TAR}"
echo ""
echo "Upload to GitHub releases:"
echo "  gh release upload v${IUP_VERSION} ${OUT_TAR} --clobber"
