# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="backend library for the maitretarot games"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="https://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="virtual/pkgconfig"
RDEPEND="dev-libs/glib:2
	dev-libs/libxml2:="
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.1.98-libdir.patch
)

src_configure() {
	econf --disable-static
}

src_install() {
	default

	# Needed for consumers like dev-games/libmt_client
	# bug #729734
	insinto /usr/share/aclocal
	doins libmaitretarot.m4

	find "${ED}" -name '*.la' -delete || die
}
