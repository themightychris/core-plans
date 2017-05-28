pkg_name=nginx
pkg_origin=core
pkg_version=1.11.10
pkg_description="NGINX web server."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd')
pkg_source=https://nginx.org/download/nginx-${pkg_version}.tar.gz
pkg_upstream_url=https://nginx.org/
pkg_shasum=778b3cabb07633f754cd9dee32fc8e22582bce22bfa407be76a806abd935533d
pkg_deps=(core/glibc core/libedit core/ncurses core/zlib core/bzip2 core/openssl core/pcre)
pkg_build_deps=(core/gcc core/make core/coreutils)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(sbin)
pkg_include_dirs=(include)
pkg_svc_user="root"
pkg_exports=(
  [port]=http.listen.port
)
pkg_exposes=(port)

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --sbin-path="$pkg_prefix/bin/nginx" \
    --user=hab \
    --group=hab \
    --http-log-path=/dev/stdout \
    --error-log-path=stderr \
    --with-ipv6 \
    --with-pcre \
    --with-pcre-jit \
    --with-file-aio \
    --with-stream=dynamic \
    --with-mail=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_degradation_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_secure_link_module \
    --with-http_sub_module \
    --with-http_slice_module \
    --with-cc-opt="$CFLAGS" \
    --with-ld-opt="$LDFLAGS"

  make
}

do_install() {
  make install
  mkdir -p "$pkg_prefix/sbin"
  cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/objs/nginx" "$pkg_prefix/sbin"
}
