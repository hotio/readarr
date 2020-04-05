FROM hotio/dotnetcore@sha256:9c5dee8aca56ca2b1b060315cc09c6ed22df272f0e460e10b9821075cefd22c6

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8787

ARG READARR_VERSION=0.1.0.17
ARG PACKAGE_VERSION=${READARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://readarr.servarr.com/v1/update/readarr/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Readarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=readarr" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
