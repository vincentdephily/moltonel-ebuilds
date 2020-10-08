# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dummy ebuild that takes a long time to install nothing"
HOMEPAGE="https://github.com/vincentdephily/moltonel-ebuilds"
SRC_URI=""

LICENSE="Unlicense"
SLOT="5"
KEYWORDS="*"

RDEPEND=""

delay() {
	for i in $(seq "$SLOT" -1 1); do echo -n "$i "; sleep 1; done
	echo 0
}

src_unpack() {
	delay
	mkdir -p "${S}"
}
src_prepare() {
	delay
	default
}
src_configure() {
	delay
}
src_compile() {
	delay
}
src_install() {
	delay
}
