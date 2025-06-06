# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A generator for Rust/Cargo ebuilds written in Python"
HOMEPAGE="
	https://github.com/projg2/pycargoebuild/
	https://pypi.org/project/pycargoebuild/
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~loong ~ppc64"

RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.10)
"

distutils_enable_tests pytest
