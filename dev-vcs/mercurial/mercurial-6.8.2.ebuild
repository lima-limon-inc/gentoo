# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
PYTHON_REQ_USE="threads(+)"

CRATES="
	adler@1.0.2
	ahash@0.8.2
	aho-corasick@0.7.19
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.6.0
	bitmaps@2.1.0
	bitvec@1.0.1
	block-buffer@0.10.3
	block-buffer@0.9.0
	bstr@1.6.0
	bumpalo@3.11.1
	byteorder@1.4.3
	bytes-cast-derive@0.2.0
	bytes-cast@0.3.0
	cc@1.0.76
	cfg-if@1.0.0
	chrono@0.4.34
	clap@4.0.24
	clap_derive@4.0.21
	clap_lex@0.3.0
	codespan-reporting@0.11.1
	convert_case@0.4.0
	core-foundation-sys@0.8.3
	cpufeatures@0.2.5
	cpython@0.7.2
	crc32fast@1.3.2
	crossbeam-channel@0.5.6
	crossbeam-deque@0.8.2
	crossbeam-epoch@0.9.11
	crossbeam-utils@0.8.12
	crypto-common@0.1.6
	ctor@0.1.26
	cxx-build@1.0.81
	cxx@1.0.81
	cxxbridge-flags@1.0.81
	cxxbridge-macro@1.0.81
	derive_more@0.99.17
	diff@0.1.13
	digest@0.10.5
	digest@0.9.0
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.8.0
	env_logger@0.9.3
	fastrand@1.8.0
	flate2@1.0.24
	format-bytes-macros@0.4.0
	format-bytes@0.3.0
	funty@2.0.0
	generic-array@0.14.6
	getrandom@0.1.16
	getrandom@0.2.8
	hashbrown@0.12.3
	hashbrown@0.13.1
	heck@0.4.0
	hermit-abi@0.1.19
	hex@0.4.3
	home@0.5.4
	humantime@2.1.0
	iana-time-zone-haiku@0.1.1
	iana-time-zone@0.1.53
	im-rc@15.1.0
	indexmap@1.9.2
	instant@0.1.12
	itertools@0.10.5
	jobserver@0.1.25
	js-sys@0.3.60
	lazy_static@1.4.0
	libc@0.2.155
	libm@0.2.6
	libredox@0.1.3
	libz-sys@1.1.8
	link-cplusplus@1.0.7
	log@0.4.17
	logging_timer@1.1.0
	logging_timer_proc_macros@1.1.0
	memchr@2.5.0
	memmap2@0.5.8
	memoffset@0.6.5
	miniz_oxide@0.5.4
	nom8@0.2.0
	num-traits@0.2.15
	num_cpus@1.14.0
	once_cell@1.16.0
	opaque-debug@0.3.0
	option-ext@0.2.0
	os_str_bytes@6.4.0
	output_vt100@0.1.3
	paste@1.0.9
	pkg-config@0.3.26
	ppv-lite86@0.2.17
	pretty_assertions@1.3.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.47
	python3-sys@0.7.2
	quote@1.0.21
	radium@0.7.0
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_distr@0.4.3
	rand_hc@0.2.0
	rand_pcg@0.3.1
	rand_xoshiro@0.6.0
	rayon-core@1.11.0
	rayon@1.7.0
	redox_syscall@0.2.16
	redox_users@0.4.5
	regex-automata@0.3.9
	regex-syntax@0.6.28
	regex@1.7.0
	remove_dir_all@0.5.3
	rustc_version@0.4.0
	same-file@1.0.6
	scopeguard@1.1.0
	scratch@1.0.2
	self_cell@1.0.0
	semver@1.0.14
	serde@1.0.152
	serde_derive@1.0.152
	serde_spanned@0.6.1
	sha-1@0.10.0
	sha-1@0.9.8
	shellexpand@3.1.0
	sized-chunks@0.6.5
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	tap@1.0.1
	tempfile@3.3.0
	termcolor@1.1.3
	thiserror-impl@1.0.39
	thiserror@1.0.39
	thread_local@1.1.4
	toml@0.6.0
	toml_datetime@0.5.1
	toml_edit@0.18.1
	twox-hash@1.6.3
	typenum@1.15.0
	unicode-ident@1.0.5
	unicode-width@0.1.10
	vcpkg@0.2.15
	vcsgraph@0.2.0
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.83
	wasm-bindgen-macro-support@0.2.83
	wasm-bindgen-macro@0.2.83
	wasm-bindgen-shared@0.2.83
	wasm-bindgen@0.2.83
	web-sys@0.3.60
	which@4.3.0
	whoami@1.4.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	wyz@0.5.1
	yansi@0.5.1
	zstd-safe@6.0.4+zstd.1.5.4
	zstd-sys@2.0.7+zstd.1.5.4
	zstd@0.12.3+zstd.1.5.2
"

inherit bash-completion-r1 cargo elisp-common distutils-r1 flag-o-matic multiprocessing

DESCRIPTION="Scalable distributed SCM"
HOMEPAGE="https://www.mercurial-scm.org/"
SRC_URI="https://www.mercurial-scm.org/release/${P}.tar.gz
	rust? ( ${CARGO_CRATE_URIS} )"

LICENSE="GPL-2+
	rust? (
		Apache-2.0 BSD MIT MPL-2.0 MPL-2.0 PYTHON Unicode-DFS-2016
		 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~m68k ~mips ppc ppc64 ~riscv x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="+chg emacs gpg test tk rust"

BDEPEND="rust? ( ${RUST_DEPEND} )"
RDEPEND="
	app-misc/ca-certificates
	gpg? ( app-crypt/gnupg )
	tk? ( dev-lang/tk )"

DEPEND="emacs? ( >=app-editors/emacs-23.1:* )
	test? (
		app-arch/unzip
		dev-python/pygments[${PYTHON_USEDEP}]
	)"

SITEFILE="70${PN}-gentoo.el"

RESTRICT="!test? ( test )"

pkg_setup() {
	use rust && rust_pkg_setup
}

src_unpack() {
	default_src_unpack
	if use rust; then
		local S="${S}/rust/hg-cpython"
		cargo_src_unpack
	else
		# Needed because distutils-r1 install under cargo_env if cargo is inherited
		cargo_gen_config
	fi
}

python_prepare_all() {
	# fix up logic that won't work in Gentoo Prefix (also won't outside in
	# certain cases), bug #362891
	sed -i -e 's:xcodebuild:nocodebuild:' setup.py || die
	sed -i -e 's/__APPLE__/__NO_APPLE__/g' mercurial/cext/osutil.c || die

	# Build assumes the Rust target directory, which is wrong for us.
	sed -i -r "s:\brust[/,' ]+target[/,' ]+release\b:rust/$(cargo_target_dir):g" \
		Makefile \
		setup.py \
		tests/run-tests.py \
		|| die

	distutils-r1_python_prepare_all
}

src_compile() {
	if use rust; then
		pushd rust/hg-cpython || die
		cargo_src_compile --no-default-features --jobs $(makeopts_jobs)
		popd || die
	fi
	distutils-r1_src_compile
}

python_compile() {
	filter-flags -ftracer -ftree-vectorize
	if use rust; then
		local -x HGWITHRUSTEXT="cpython"
	fi
	distutils-r1_python_compile build_ext
}

python_compile_all() {
	rm -r contrib/win32 || die
	if use chg; then
		emake -C contrib/chg
	fi
	if use rust; then
		pushd rust/rhg || die
		cargo_src_compile --no-default-features --jobs $(makeopts_jobs)
		popd || die
	fi
	if use emacs; then
		cd contrib || die
		elisp-compile mercurial.el || die "elisp-compile failed!"
	fi
}

src_install() {
	distutils-r1_src_install
}

python_install() {
	if use rust; then
		local -x HGWITHRUSTEXT="cpython"
	fi

	distutils-r1_python_install build_ext
	python_doscript contrib/hg-ssh
}

python_install_all() {
	distutils-r1_python_install_all

	newbashcomp contrib/bash_completion hg

	insinto /usr/share/zsh/site-functions
	newins contrib/zsh_completion _hg

	dobin hgeditor
	if use tk; then
		dobin contrib/hgk
	fi

	if use emacs; then
		elisp-install ${PN} contrib/mercurial.el* || die "elisp-install failed!"
		elisp-make-site-file "${SITEFILE}"
	fi

	local RM_CONTRIB=( hgk hg-ssh bash_completion zsh_completion plan9 *.el )

	if use chg; then
		dobin contrib/chg/chg
		doman contrib/chg/chg.1
		RM_CONTRIB+=( chg )
	fi
	if use rust; then
		dobin "rust/$(cargo_target_dir)/rhg"
	fi

	for f in ${RM_CONTRIB[@]}; do
		rm -rf contrib/${f} || die
	done

	dodoc -r contrib
	docompress -x /usr/share/doc/${PF}/contrib
	doman doc/*.?
	dodoc CONTRIBUTORS hgweb.cgi

	insinto /etc/mercurial/hgrc.d
	doins "${FILESDIR}/cacerts.rc"
}

src_test() {
	pushd tests &>/dev/null || die
	rm -rf *svn*			# Subversion tests fail with 1.5
	rm -f test-archive*		# Fails due to verbose tar output changes
	rm -f test-convert-baz*		# GNU Arch baz
	rm -f test-convert-cvs*		# CVS
	rm -f test-convert-darcs*	# Darcs
	rm -f test-convert-git*		# git
	rm -f test-convert-mtn*		# monotone
	rm -f test-convert-tla*		# GNU Arch tla
	rm -f test-largefiles*		# tends to time out
	rm -f test-https*			# requires to support tls1.0
	rm -rf test-removeemptydirs*	# requires access to access parent directories
	if [[ ${EUID} -eq 0 ]]; then
		einfo "Removing tests which require user privileges to succeed"
		rm -f test-convert*
		rm -f test-lock-badness*
		rm -f test-permissions*
		rm -f test-pull-permission*
		rm -f test-journal-exists*
		rm -f test-repair-strip*
	fi

	popd &>/dev/null || die
	distutils-r1_src_test
}

python_test() {
	cd tests || die
	PYTHONWARNINGS=ignore "${PYTHON}" run-tests.py \
		--jobs $(makeopts_jobs) \
		--timeout 0 \
		|| die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	use emacs && elisp-site-regen

	elog "If you want to convert repositories from other tools using convert"
	elog "extension please install correct tool:"
	elog "  dev-vcs/cvs"
	elog "  dev-vcs/darcs"
	elog "  dev-vcs/git"
	elog "  dev-vcs/monotone"
	elog "  dev-vcs/subversion"
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
