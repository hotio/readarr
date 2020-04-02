FROM hotio/dotnetcore@sha256:6ec33fb600247d366bfd4de347f8d1e0aa85bd908ab2bf052d53112ed3b4d413

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8096

ARG READARR_VERSION=0.1.0.17

# install app
RUN curl -fsSL "https://readarr.servarr.com/v1/update/readarr/updatefile?version=${READARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Readarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
