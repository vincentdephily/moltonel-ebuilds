# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="Couchbase C Client Library"
HOMEPAGE="http://www.couchbase.com/communities/c-client-library"
SRC_URI="http://packages.couchbase.com/clients/c/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc static-libs tools"

#FIXME: Building requires an internet connection: the Makefile downloads "Google test framework" during build

# tests fails to build
RESTRICT="test"

RDEPEND="dev-libs/libevent"
DEPEND="${RDEPEND}"

# building in a separate dir fails
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		$(use_enable tools)
	)
	autotools-utils_src_configure
}

src_install() {
	default
	use doc || rm -rf "${D}"/usr/share/doc
	use static-libs || find "${D}" -type f -name "*.la" -delete
	use tools || rm -rf "${D}"/usr/share/man
	rmdir "${D}"/usr/share 2>/dev/null
}
