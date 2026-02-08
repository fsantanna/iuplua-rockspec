#!/bin/bash
# repack.sh: Download IUP core + Lua binding tarballs from
# Tecgraf/SourceForge and combine into a single tarball
# for use with the iuplua LuaRocks rockspec.
#
# Usage:
#   bash repack.sh [LUA_VERSION] [KERNEL]
#
# Examples:
#   bash repack.sh 54 Linux515_64
#   bash repack.sh 51 Linux68_64
#
# Output:
#   iuplua-3.32-<KERNEL>.tar.gz

set -e

IUP_VERSION="3.32"
LUA_VERSION="${1:-54}"
KERNEL="${2:-Linux515_64}"

BASE_URL="https://sourceforge.net/projects/iup/files"
CORE_URL="${BASE_URL}/${IUP_VERSION}/Linux%20Libraries"
LUA_URL="${CORE_URL}/Lua${LUA_VERSION}"

CORE_TAR="iup-${IUP_VERSION}_${KERNEL}_lib.tar.gz"
LUA_TAR="iup-${IUP_VERSION}-Lua${LUA_VERSION}_${KERNEL}_lib.tar.gz"
OUT_TAR="iuplua-${IUP_VERSION}-Lua${LUA_VERSION}_${KERNEL}.tar.gz"

WORK=$(mktemp -d)
trap "rm -rf $WORK" EXIT

echo "=== Downloading core: ${CORE_TAR}"
wget -q "${CORE_URL}/${CORE_TAR}/download" \
    -O "${WORK}/${CORE_TAR}"

echo "=== Downloading Lua bindings: ${LUA_TAR}"
wget -q "${LUA_URL}/${LUA_TAR}/download" \
    -O "${WORK}/${LUA_TAR}"

OUT_DIR="${WORK}/iuplua-${IUP_VERSION}"
mkdir -p "${OUT_DIR}"

echo "=== Extracting core"
tar xzf "${WORK}/${CORE_TAR}" -C "${OUT_DIR}"

echo "=== Extracting Lua bindings"
tar xzf "${WORK}/${LUA_TAR}" -C "${OUT_DIR}"

echo "=== Adding Makefile"
cat > "${OUT_DIR}/Makefile" << 'MAKEFILE'
# Makefile for iuplua LuaRocks rockspec.
# Installs IUP core libs to /usr/local/lib and
# Lua binding .so files to $(LIBDIR).
#
# Variables set by LuaRocks:
#   LIBDIR  - Lua C module directory
#   PREFIX  - install prefix

LIBDIR ?= /usr/local/lib/lua/5.4

CORE_LIBS = \
	libiup.so \
	libiupcd.so \
	libiupcontrols.so \
	libiupgl.so \
	libiupglcontrols.so \
	libiupim.so \
	libiupimglib.so \
	libiup_mglplot.so \
	libiup_plot.so \
	libiup_scintilla.so \
	libiuptuio.so \
	libiupweb.so

install:
	install -d /usr/local/lib
	for f in $(CORE_LIBS); do \
		if [ -f $$f ]; then \
			install -m 755 $$f /usr/local/lib/; \
		fi; \
	done
	@# ftgl (bundled dependency)
	@if [ -d ftgl ]; then \
		find ftgl -name '*.so' \
			-exec install -m 755 {} /usr/local/lib/ \; ; \
	fi
	ldconfig /usr/local/lib 2>/dev/null || true
	install -d $(LIBDIR)
	@# Install Lua bindings, renaming:
	@#   libiuplua54.so -> iuplua.so
	for f in libiuplua*.so; do \
		dst=$$(echo $$f \
			| sed 's/^lib//' \
			| sed 's/[0-9][0-9]\.so$$/.so/'); \
		install -m 755 $$f $(LIBDIR)/$$dst; \
	done
MAKEFILE

echo "=== Creating ${OUT_TAR}"
tar czf "${OUT_TAR}" -C "${WORK}" \
    "iuplua-${IUP_VERSION}"

echo "=== Done: ${OUT_TAR}"
echo ""
echo "Upload to GitHub releases:"
echo "  gh release create v${IUP_VERSION} ${OUT_TAR}"
