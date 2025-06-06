# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

EGIT_COMMIT="19d3cc333d35dfd2d17d75c506336c15e5c6685a"
MY_P=python-junit-xml-${EGIT_COMMIT}

DESCRIPTION="Create JUnit XML test result documents"
HOMEPAGE="
	https://github.com/kyrus/python-junit-xml/
	https://pypi.org/project/junit-xml/
"
# upstream fails both at uploading to pypi and making tags
# https://github.com/kyrus/python-junit-xml/issues/69
# https://github.com/kyrus/python-junit-xml/issues/31
SRC_URI="
	https://github.com/kyrus/python-junit-xml/archive/${EGIT_COMMIT}.tar.gz
		-> ${MY_P}.gh.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 ~riscv x86"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
