FROM hotio/dotnetcore@sha256:ea49e7840b1f17d3fb13050fca806957dc8d5cf32acbdd016f09c6b21beb4012

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8787

ARG READARR_VERSION
ARG PACKAGE_VERSION=${READARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://readarr.servarr.com/v1/update/readarr/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Readarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=readarr" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
