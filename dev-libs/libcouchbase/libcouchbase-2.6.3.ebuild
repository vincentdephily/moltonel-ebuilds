# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Couchbase C Client Library"
HOMEPAGE="http://www.couchbase.com/communities/c-client-library"
SRC_URI="http://packages.couchbase.com/clients/c/${P}.tar.gz
test? ( http://packages.couchbase.com/clients/c/mock/CouchbaseMock-1.4.3.jar )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc static-libs tools test"

# FIXME: tests take forever to run ?
#RESTRICT="test"

RDEPEND="dev-libs/libevent
dev-libs/openssl:*"
DEPEND="${RDEPEND}
dev-util/cmake"

src_configure() {
	use test && cp "${DISTDIR}/CouchbaseMock-1.4.3.jar" "${WORKDIR}/${P}/tests/CouchbaseMock.jar"
	./cmake/configure --prefix "${EPREFIX}" $(use_enable tools) $(use_enable test couchbasemock)
}

src_install() {
	default
	use doc || rm -rf "${D}"/usr/share/doc
	use static-libs || find "${D}" -type f -name "*.la" -delete
	use tools || rm -rf "${D}"/usr/share/man
}
