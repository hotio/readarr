FROM hotio/dotnetcore@sha256:6ec33fb600247d366bfd4de347f8d1e0aa85bd908ab2bf052d53112ed3b4d413

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8787

ARG READARR_VERSION
ARG PACKAGE_VERSION=${READARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://readarr.servarr.com/v1/update/readarr/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Readarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=readarr" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
