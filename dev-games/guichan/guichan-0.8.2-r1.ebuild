# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portable C++ GUI library designed for games using Allegro, SDL and/or OpenGL"
HOMEPAGE="https://github.com/darkbitsorg/guichan"
SRC_URI="https://github.com/darkbitsorg/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="allegro opengl sdl"

DEPEND="
	allegro? ( media-libs/allegro:0 )
	opengl? ( virtual/opengl )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-image
	)"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-as-needed.patch
	"${FILESDIR}"/${P}-automake-1.13.patch
	"${FILESDIR}"/${P}-slibtool-undefined-references.patch
)

src_prepare() {
	default

	mv configure.in configure.ac || die
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable allegro)
		$(use_enable opengl)
		$(use_enable sdl)
		$(use_enable sdl sdlimage)
	)

	econf "${myeconfargs}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
