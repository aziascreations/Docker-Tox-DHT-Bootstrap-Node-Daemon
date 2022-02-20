# -===- Compiling stage -===-
# Preparing the temporary compilier container
FROM alpine:latest AS build
ARG TOXCORE_DESIRED_VERSION=0.2.16

# Installing required build packages
# * Optional packages: bash
# * Note: The "g++" package is required even tho it isn't explicitly used anywhere...
RUN apk add --no-cache wget check git libtool libsodium-dev unzip yasm gcc cmake libconfig-dev make g++ msgpack-c-dev

# Installing the x86 linux-headers
RUN cat /etc/apk/arch > /arch-original.txt && \
    echo "x86" > /etc/apk/archcat && \
    apk add --no-cache linux-headers && \
    cat /arch-original.txt > /etc/apk/arch

# Downloading and extracting the source files...
WORKDIR /build/tox
RUN wget -O "/build/c-toxcore.tar.gz" https://github.com/TokTok/c-toxcore/archive/refs/tags/v$TOXCORE_DESIRED_VERSION.tar.gz && \
    tar -xvf "/build/c-toxcore.tar.gz" && \
    rm "/build/c-toxcore.tar.gz" && \
    mkdir "/build/output"

# Building the application
# Please refer to "https://github.com/TokTok/c-toxcore/blob/master/INSTALL.md#main" for more info on the
#  compiled components.
# * Output directory: /build/tox/output/ => bin|include|lib
WORKDIR /build/tox/c-toxcore-$TOXCORE_DESIRED_VERSION/_build
RUN cmake \
    -D CMAKE_C_COMPILER=/usr/bin/gcc \
    -D CMAKE_CXX_COMPILER=/usr/bin/gcc \
    -D AUTOTEST=OFF \
    -D BOOTSTRAP_DAEMON=ON \
    -D BUILD_MISC_TESTS=OFF \
    -D BUILD_TOXAV=OFF \
    -D CMAKE_INSTALL_PREFIX=/build/tox/output \
    -D DHT_BOOTSTRAP=OFF \
    -D ENABLE_SHARED=OFF \
    -D ENABLE_STATIC=OFF \
    -D MIN_LOGGER_LEVEL=DEBUG \
    -D STRICT_ABI=OFF \
    -D TEST_TIMEOUT_SECONDS=120 \
    -D USE_IPV6=OFF \
    .. && \
    make && \
    make install

# -===- Final stage -===-
# Preparing the final container
FROM alpine:latest AS final
ARG TOXCORE_DESIRED_VERSION=0.2.16

# Setting up the labels
LABEL org.opencontainers.image.authors="Herwin Bozet <herwin.bozet@gmail.com>"
#LABEL org.opencontainers.image.created="TODO"
LABEL org.opencontainers.image.description="Dockerized Tox DHT bootstrap node daemon."
#LABEL org.opencontainers.image.url="TODO"
LABEL org.opencontainers.image.version=$TOXCORE_DESIRED_VERSION
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.title="tox-bootstrapd"
LABEL maintainer="Herwin Bozet <herwin.bozet@gmail.com>"

# Installing required libraries
# Missing packages for toxcore: libm libpthread librt
RUN apk add --no-cache libsodium libconfig msgpack-c

# Copying compile things from the previous container.
COPY --from="build" /build/tox/output/bin/* /usr/bin/
COPY --from="build" /build/tox/output/include/* /usr/include/
COPY --from="build" /build/tox/output/lib/* /usr/lib/
COPY --from="build" /build/tox/c-toxcore-$TOXCORE_DESIRED_VERSION/other/bootstrap_daemon/tox-bootstrapd.conf /etc/tox-bootstrapd.conf

# Exposing the required ports for a bootstrap node
EXPOSE 8080/tcp 8080/udp 33445/tcp 33445/udp

# Preparing keys folder and changing to the final UID and GID
ARG PUID=1000
ARG PGID=1000
RUN mkdir /var/lib/tox-bootstrapd && chown $PUID:$PGID /var/lib/tox-bootstrapd
USER $PUID:$PGID

# Starting the bootstrap daemon as a foreground task
CMD ["tox-bootstrapd", "--log-backend=stdout", "--foreground", "--config=/etc/tox-bootstrapd.conf"]

# Command for manual testing and debugging
#CMD ["tail", "-f", "/dev/null"]
