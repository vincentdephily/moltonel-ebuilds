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
#	find opt/couchbase/var/lib/couchbase/ -type f -delete || die

	# bin install / copy
	dodir /opt/couchbase
	cp -a opt/couchbase/* "${D}"/opt/couchbase/
#	dodir /opt/couchbase/var/lib/couchbase/{data,mnesia,tmp}
	fowners -R couchbase:couchbase /opt/couchbase/

	# Install upstream'd init script but make sure it doesn't delete /dev/null
	sed -i '/start-stop-daemon/s:--pidfile */dev/null::' "${D}opt/couchbase/etc/couchbase_init.d"
	dosym "${D}opt/couchbase/etc/couchbase_init.d" /etc/init.d/couchbase

	# Logs and logrotate
	dosym /opt/couchbase/etc/logrotate.d/couchdb /etc/logrotate.d/couchbase
	dosym /opt/couchbase/var/lib/couchbase/logs /var/log/couchbase

	# Raise open files limit
	insinto /etc/security/limits.d/
	doins "${FILESDIR}"/90-couchbase.conf

	ewarn "The version of erlang bundled with this precompiled package does not support ipv6 addresses in /etc/resolv.conf."
	ewarn "This'll result in warnings at startup/shutdown but should otherwise be harmless."
}
