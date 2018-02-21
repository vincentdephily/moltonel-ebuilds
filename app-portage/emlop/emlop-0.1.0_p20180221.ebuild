# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
aho-corasick-0.6.4
ansi_term-0.10.2
atty-0.2.6
bitflags-1.0.1
chrono-0.4.0
clap-2.29.2
errno-0.2.3
kernel32-sys-0.2.2
lazy_static-1.0.0
libc-0.2.36
memchr-2.0.1
num-0.1.41
num-integer-0.1.35
num-iter-0.1.34
num-traits-0.1.42
redox_syscall-0.1.37
redox_termios-0.1.1
regex-0.2.5
regex-syntax-0.4.2
strsim-0.6.0
sysconf-0.3.1
tabwriter-1.0.3
termion-1.5.1
textwrap-0.9.0
thread_local-0.3.5
time-0.1.39
unicode-width-0.1.4
unreachable-1.0.0
utf8-ranges-1.0.0
vec_map-0.8.0
void-1.0.2
winapi-0.2.8
winapi-0.3.4
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A fast, accurate, ergonomic emerge.log parser"
HOMEPAGE="https://github.com/vincentdephily/emlop"
COMMIT="9c7f1ea4be23a82bf65b58153e892dda93dbf873"
SRC_URI="https://github.com/vincentdephily/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
		 $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/rust-1.23
	 dev-util/cargo"
RDEPEND=""

src_unpack() {
	cargo_src_unpack
	cd "${WORKDIR}"
	rmdir "${PF}"
	mv "${PN}-${COMMIT}" "${PF}"
}

src_test() {
	cargo test || die "tests failed"
}

src_install() {
	cargo_src_install

	dodoc README.md COMPARISON.md
}
