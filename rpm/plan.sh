pkg_name=rpm
pkg_origin=core
pkg_version=4.14.2.1
pkg_license=("GPL-2.0" "LGPL-2.0")
pkg_description="RPM Package Manager"
pkg_upstream_url="http://www.rpm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://ftp.rpm.org/releases/${pkg_name}-4.14.x/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="1139c24b7372f89c0a697096bf9809be70ba55e006c23ff47305c1849d98acda"

pkg_deps=(
  core/bzip2
  core/db
  core/file
  core/glibc
  core/libarchive
  core/nspr
  core/nss
  core/openssl
  core/popt
  core/zlib
)

pkg_build_deps=(
  core/gcc
  core/make
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --with-external-db       \
              --without-lua

  make
}
