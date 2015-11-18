# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils user

DESCRIPTION="Distributed key-value database management system, community edition"
HOMEPAGE="http://www.couchbase.com/"
SRC_URI="http://packages.couchbase.com/releases/${PV}/couchbase-server-community_${PV}-debian7_amd64.deb"

LICENSE="Couchbase-Inc-Community-Edition" #http://www.couchbase.com/community
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-libs/ncurses:5/5[tinfo]
		 >=dev-db/sqlite-3.5.9"
DEPEND="${RDEPEND}"

export CONFIG_PROTECT="${CONFIG_PROTECT} /opt/${PN}/var/lib/${PN}/"

S=${WORKDIR}

pkg_setup() {
	enewgroup couchbase
	enewuser couchbase -1 /bin/bash /opt/couchbase couchbase
}

src_unpack() {
	ar x "${DISTDIR}"/${A}
	cd "${WORKDIR}"
	tar xzf data.tar.gz
}

src_install() {
	# basic cleanup
	rm -rf opt/couchbase/etc/{couchbase_init.d,couchbase_init.d.tmpl,init.d}
	find opt/couchbase/var/lib/couchbase/ -type f -delete || die

	# bin install / copy
	dodir /opt/couchbase
	cp -a opt/couchbase/* "${D}"/opt/couchbase/

	dodir /opt/couchbase/var/lib/couchbase/{data,mnesia,tmp}

	fowners -R couchbase:couchbase /opt/couchbase/

	doinitd "${FILESDIR}"/couchbase-server
	dosym /opt/couchbase/etc/logrotate.d/couchdb /etc/logrotate.d/couchbase

	insinto /etc/security/limits.d/
	doins "${FILESDIR}"/90-couchbase.conf
}
