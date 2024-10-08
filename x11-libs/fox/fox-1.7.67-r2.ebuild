# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="C++ Toolkit for developing Graphical User Interfaces easily and effectively"
HOMEPAGE="http://www.fox-toolkit.org/"
SRC_URI="ftp://ftp.fox-toolkit.org/pub/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.7"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="+bzip2 +jpeg +opengl +png tiff +truetype +zlib debug doc profile tools"

RDEPEND="
	x11-libs/fox-wrapper
	x11-libs/libXcursor
	x11-libs/libXrandr
	bzip2? ( app-arch/bzip2 )
	jpeg? ( media-libs/libjpeg-turbo:= )
	opengl? ( virtual/glu virtual/opengl )
	png? ( media-libs/libpng:= )
	tiff? ( media-libs/tiff:= )
	truetype? (
		media-libs/freetype:2
		x11-libs/libXft
	)
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-libs/libXt"
BDEPEND="doc? ( app-text/doxygen )"

PATCHES=(
	"${FILESDIR}"/"${PN}"-1.7.67-no-truetype.patch
	"${FILESDIR}"/"${PN}"-1.7.67-pthread_rwlock_prefer_writer_np-musl.patch
)

src_prepare() {
	default

	sed -i '/#define REXDEBUG 1/d' lib/FXRex.cpp || die "Unable to remove spurious debug line."
	sed -i -e "s:windows::" Makefile.am || die
	sed -i -e 's/register //g' lib/*.cpp || die "Unable remove register keywords from sources under lib folder"
	sed -i -e 's/register //g' shutterbug/*.cpp || die "Unable remove register keywords from sources under shutterbug folder"
	sed -i -e 's/register //g' calculator/*.cpp || die "Unable remove register keywords from sources under calculator folder"
	sed -i -e 's/register //g' glviewer/*.cpp || die "Unable remove register keywords from sources under glviewer folder"
	sed -i -e 's/register //g' chart/*.cpp || die "Unable remove register keywords from sources under chart folder"
	if ! use tools; then
		local d
		for d in adie calculator pathfinder shutterbug; do
			sed -i -e "s:${d}::" Makefile.am || die
		done
	fi

	# Respect system CXXFLAGS
	sed -i -e 's:CXXFLAGS=""::' configure.ac || die "Unable to force cxxflags."

	# don't strip binaries
	sed -i -e '/LDFLAGS="-s ${LDFLAGS}"/d' configure.ac || die "Unable to prevent stripping."

	eautoreconf
}

src_configure() {
	# -Werror=strict-aliasing
	# https://bugs.gentoo.org/864412
	# Fixed in 1.7.84
	#
	# Do not trust it for LTO either.
	append-flags -fno-strict-aliasing
	filter-lto

	econf \
		--disable-static \
		--enable-$(usex debug debug release) \
		$(use_enable bzip2 bz2lib) \
		$(use_enable jpeg) \
		$(use_with opengl) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_with truetype xft) \
		$(use_enable zlib) \
		$(use_with profile profiling)
}

src_compile() {
	emake
	use doc && emake -C doc docs
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		artdir="${EPREFIX}"/usr/share/doc/${PF}/html/art \
		screenshotsdir="${EPREFIX}"/usr/share/doc/${PF}/html/screenshots

	local CP="${ED}"/usr/bin/ControlPanel
	if [[ -f ${CP} ]]; then
		mv "${CP}" "${ED}"/usr/bin/fox-ControlPanel-${SLOT} || \
			die "Failed to install ControlPanel"
	fi

	dodoc ADDITIONS AUTHORS LICENSE_ADDENDUM README TRACING

	if use doc; then
		# install class reference docs if USE=doc
		docinto html
		dodoc -r doc/ref
	else
		# remove documentation if USE=-doc
		rm -rf "${ED}"/usr/share/doc/${PF}/html || die
	fi

	# slot fox-config
	if [[ -f ${ED}/usr/bin/fox-config ]] ; then
		mv "${ED}"/usr/bin/fox-config "${ED}"/usr/bin/fox-${SLOT}-config \
		|| die "failed to install fox-config"
	fi

	# no static archives
	find "${D}" -name '*.la' -delete || die
}
