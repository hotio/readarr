FROM hotio/dotnetcore@sha256:8c001114eb337abf662c02bd197a79d0371c1b3afb856cb0f9f984add14a9ff8

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8787

ARG READARR_VERSION
ARG PACKAGE_VERSION=${READARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://readarr.servarr.com/v1/update/nightly/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Readarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=nightly" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
