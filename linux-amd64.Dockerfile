FROM hotio/dotnetcore@sha256:961bb073a4cfa0cafb67da366aad286b2bd459129f3fba9c894648f6ef2f29b2

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
