FROM hotio/base@sha256:4f26fe7bb656f83929e2da7622aed5267975bcf8ee523b6f3068ca024bcc1717

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8787
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

ARG READARR_VERSION
ARG PACKAGE_VERSION=${READARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://readarr.servarr.com/v1/update/nightly/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Readarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=nightly" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
