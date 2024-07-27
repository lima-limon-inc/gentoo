# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
# Note: greenlet is built-in in pypy
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Lightweight in-process concurrent programming"
HOMEPAGE="
	https://greenlet.readthedocs.io/en/latest/
	https://github.com/python-greenlet/greenlet/
	https://pypi.org/project/greenlet/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 -hppa -ia64 ~m68k ~mips ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos"

BDEPEND="
	test? (
		dev-python/objgraph[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-python/furo
distutils_enable_tests unittest

src_prepare() {
	local PATCHES=(
		# https://github.com/python-greenlet/greenlet/pull/396
		"${FILESDIR}/${P}-py313.patch"
	)

	distutils-r1_src_prepare

	# patch cflag manipulations out
	sed -i -e 's:global_compile_args[.]append.*:pass:' setup.py || die
	# broken assertions on py3.12+
	# https://github.com/python-greenlet/greenlet/issues/368
	sed -e 's:test_trace_events_multiple_greenlets_switching:_&: ' \
		-i src/greenlet/tests/test_tracing.py || die
}

python_test() {
	eunittest greenlet.tests
}
