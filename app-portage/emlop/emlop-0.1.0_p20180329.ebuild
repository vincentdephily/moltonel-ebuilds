# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
aho-corasick-0.6.4
ansi_term-0.11.0
assert_cli-0.5.4
atty-0.2.8
backtrace-0.3.5
backtrace-sys-0.1.16
bitflags-0.9.1
bitflags-1.0.1
bytecount-0.2.0
cargo_metadata-0.3.3
cc-1.0.5
cfg-if-0.1.2
chrono-0.4.0
clap-2.31.1
colored-1.6.0
difference-1.0.0
dtoa-0.4.2
environment-0.1.1
errno-0.2.3
error-chain-0.11.0
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
glob-0.2.11
indoc-0.2.3
indoc-impl-0.2.3
itoa-0.3.4
kernel32-sys-0.2.2
lazy_static-0.2.11
lazy_static-1.0.0
libc-0.2.39
memchr-2.0.1
num-0.1.42
num-integer-0.1.36
num-iter-0.1.35
num-traits-0.2.1
proc-macro-hack-0.4.0
proc-macro-hack-impl-0.4.0
pulldown-cmark-0.1.2
quote-0.3.15
rand-0.4.2
redox_syscall-0.1.37
redox_termios-0.1.1
regex-0.2.6
regex-syntax-0.4.2
remove_dir_all-0.3.0
rustc-demangle-0.1.7
same-file-0.1.3
semver-0.8.0
semver-parser-0.7.0
serde-1.0.27
serde_derive-1.0.27
serde_derive_internals-0.19.0
serde_json-1.0.10
skeptic-0.13.2
strsim-0.7.0
syn-0.11.11
synom-0.11.3
sysconf-0.3.1
tabwriter-1.0.4
tempdir-0.3.6
termion-1.5.1
textwrap-0.9.0
thread_local-0.3.5
time-0.1.39
unicode-width-0.1.4
unicode-xid-0.0.4
unindent-0.1.2
unreachable-1.0.0
utf8-ranges-1.0.0
vec_map-0.8.0
void-1.0.2
walkdir-1.0.7
winapi-0.2.8
winapi-0.3.4
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A fast, accurate, ergonomic emerge.log parser"
HOMEPAGE="https://github.com/vincentdephily/emlop"
COMMIT="bed301cd7e2e67cb5b398e376f95d9c0d597d34c"
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
