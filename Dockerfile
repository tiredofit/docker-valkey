ARG DISTRO="alpine"
ARG DISTRO_VARIANT="3.20"

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG VALKEY_VERSION

ENV VALKEY_VERSION=${VALKEY_VERSION:-"7.2.5"} \
    VALKEY_REPO_URL=${VALKEY_REPO_URL:-"https://github.com/valkey-io/valkey"} \
    CONTAINER_ENABLE_MESSAGING=FALSE \
    IMAGE_NAME="tiredofit/valkey" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-valkey/"

RUN source /assets/functions/00-container && \
    set -ex && \
    addgroup -S -g 6379 valkey && \
    adduser -S -D -H -h /dev/null -s /sbin/nologin -G valkey -u 6379 valkey && \
    package update && \
    package upgrade && \
    package install .valkey-build-deps \
				coreutils \
				gcc \
				linux-headers \
				make \
				musl-dev \
				openssl-dev \
				tar \
			    && \
	\
	clone_git_repo "${VALKEY_REPO_URL}" "${VALKEY_VERSION}" && \
	\
	grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' src/config.c && \
	sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' src/config.c && \
	grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' src/config.c && \
	\
	export BUILD_TLS=yes && \
	make -j "$(nproc)" all && \
	make install && \
	\
	serverMd5="$(md5sum /usr/local/bin/valkey-server | cut -d' ' -f1)"; export serverMd5 && \
	find /usr/local/bin/valkey* -maxdepth 0 \
		-type f -not -name valkey-server \
		-exec sh -eux -c ' \
			md5="$(md5sum "$1" | cut -d" " -f1)"; \
			test "$md5" = "$serverMd5"; \
		' -- '{}' ';' \
		-exec ln -svfT 'valkey-server' '{}' ';' \
		&& \
	\
    runDeps="$( \
	scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
		| tr ',' '\n' \
		| sort -u \
		| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" && \
    package install .valkey-rundeps \
                    su-exec \
                    $runDeps \
                    && \
	package remove .valkey-build-deps && \
	rm -rf /usr/src/* && \
    package cleanup && \
    \
    mkdir -p /data && \
    chown valkey:valkey /data

EXPOSE 6379

COPY install /
