# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
aho-corasick-0.6.4
ansi_term-0.11.0
assert_cli-0.5.4
atty-0.2.8
backtrace-0.3.6
backtrace-sys-0.1.16
bitflags-0.9.1
bitflags-1.0.1
bytecount-0.2.0
cargo_metadata-0.3.3
cc-1.0.10
cfg-if-0.1.2
chrono-0.4.2
chrono-english-0.1.2
clap-2.31.2
colored-1.6.0
difference-1.0.0
dtoa-0.4.2
environment-0.1.1
errno-0.2.3
error-chain-0.11.0
failure-0.1.1
failure_derive-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
glob-0.2.11
indoc-0.2.3
indoc-impl-0.2.3
itoa-0.4.1
kernel32-sys-0.2.2
lazy_static-0.2.11
lazy_static-1.0.0
libc-0.2.40
log-0.3.9
log-0.4.1
memchr-2.0.1
num-integer-0.1.36
num-traits-0.2.2
proc-macro-hack-0.4.0
proc-macro-hack-impl-0.4.0
proc-macro2-0.3.6
pulldown-cmark-0.1.2
quote-0.3.15
quote-0.5.1
rand-0.4.2
redox_syscall-0.1.37
redox_termios-0.1.1
regex-0.2.10
regex-syntax-0.5.5
remove_dir_all-0.5.0
rustc-demangle-0.1.7
same-file-0.1.3
scanlex-0.1.2
semver-0.8.0
semver-parser-0.7.0
serde-1.0.38
serde_derive-1.0.38
serde_derive_internals-0.23.1
serde_json-1.0.14
skeptic-0.13.2
stderrlog-0.3.0
strsim-0.7.0
syn-0.11.11
syn-0.13.1
synom-0.11.3
synstructure-0.6.1
sysconf-0.3.1
tabwriter-1.0.4
tempdir-0.3.7
termcolor-0.3.6
termion-1.5.1
textwrap-0.9.0
thread_local-0.3.5
time-0.1.39
ucd-util-0.1.1
unicode-width-0.1.4
unicode-xid-0.0.4
unicode-xid-0.1.0
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
wincolor-0.1.6
"

inherit cargo

DESCRIPTION="A fast, accurate, ergonomic emerge.log parser"
HOMEPAGE="https://github.com/vincentdephily/emlop"
SRC_URI="https://github.com/vincentdephily/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
		 $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=">=virtual/rust-1.25
	 dev-util/cargo"
RDEPEND=""

src_test() {
	cargo test || die "tests failed"
}

src_install() {
	cargo_src_install
	dodoc README.md COMPARISON.md
}
