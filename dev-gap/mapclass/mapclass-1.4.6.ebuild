# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gap-pkg

DESCRIPTION="A GAP package to compute mapping-class group orbits"
SRC_URI="https://github.com/gap-packages/${PN}/releases/download/v${PV}/${P}.tar.gz"
S="${WORKDIR}/MapClass-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

gap-pkg_enable_tests
