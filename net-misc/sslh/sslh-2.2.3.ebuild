# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit flag-o-matic systemd toolchain-funcs

DESCRIPTION="Port multiplexer - accept both HTTPS and SSH connections on the same port"
HOMEPAGE="https://www.rutschle.net/tech/sslh/README.html"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/yrutschle/sslh.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~arm ~m68k ~mips ~s390 ~x86"
	SRC_URI="https://github.com/yrutschle/sslh/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${P}
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="caps libev systemd tcpd"

RDEPEND="caps? ( sys-libs/libcap )
	dev-libs/libpcre2:=
	systemd? ( sys-apps/systemd:= )
	tcpd? ( sys-apps/tcp-wrappers )
	dev-libs/libconfig:=
	libev? ( dev-libs/libev )
	>=dev-libs/libconfig-1.5:="
DEPEND="${RDEPEND}
	dev-lang/perl"

RESTRICT="test"

src_prepare() {
	sed -i \
		-e '/MAN/s:| gzip -9 - >:>:' \
		-e '/MAN=sslh.8.gz/s:.gz::' \
		Makefile.in || die
	default
}

src_compile() {
	append-lfs-flags

	emake \
		CC="$(tc-getCC)" \
		USELIBCAP=$(usev caps) \
		USELIBEV=$(usev libev) \
		USELIBWRAP=$(usev tcpd) \
		USESYSTEMD=$(usev systemd)
}

src_install() {
	dosbin sslh-{fork,select}
	if use libev; then
		dosbin sslh-ev
		dosym sslh-fork /usr/sbin/sslh
	else
		dosym sslh-fork /usr/sbin/sslh
	fi

	doman ${PN}.8

	dodoc ChangeLog README.md

	newinitd "${FILESDIR}"/sslh.init.d-3 sslh
	newconfd "${FILESDIR}"/sslh.conf.d-2 sslh

	if use systemd; then
		# Gentoo puts the binaries in /usr/sbin, but upstream puts them in /usr/bin
		systemd_newunit "${FILESDIR}/sslh.service" sslh.service
		exeinto /usr/lib/systemd/system-generators/
		doexe systemd-sslh-generator
	fi
}
