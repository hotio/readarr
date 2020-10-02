# readarr

<img src="https://img.shields.io/badge/WARNING-Updates%20require%20a%20fresh%20database%20until%20further%20notice-orange" alt="WARNING"><br>
<img src="https://img.shields.io/badge/WARNING-There's%20only%20a%20'nightly'%20tag%20for%20the%20moment-orange" alt="WARNING"><br>

<img src="https://hotio.dev/img/readarr.png" alt="Logo" height="130" width="130">

![Base](https://img.shields.io/badge/base-ubuntu-orange)
[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-readarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/readarr)](https://hub.docker.com/r/hotio/readarr)
[![GitHub Registry](https://img.shields.io/badge/registry-ghcr.io-blue)](https://github.com/users/hotio/packages/container/readarr/versions)
[![Discord](https://img.shields.io/discord/610068305893523457?color=738ad6&label=discord&logo=discord&logoColor=white)](https://discord.gg/3SnkuKp)
[![Upstream](https://img.shields.io/badge/upstream-project-yellow)](https://github.com/Readarr/Readarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name readarr -p 8787:8787 -v /<host_folder_config>:/config hotio/readarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=002
-e TZ="Etc/UTC"
-e ARGS=""
-e DEBUG="no"
```

## Tags

| Tag                | Upstream          |
| -------------------|-------------------|
| `release` (latest) | not yet available |
| `testing`          | not yet available |
| `nightly`          | nightly           |

You can also find tags that reference a commit or version number.

## Configuration location

Your readarr configuration inside the container is stored in `/config/app`, to migrate from another container, you'd probably have to move your files from `/config` to `/config/app`.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```

## Troubleshooting a problem

By default all output is redirected to `/dev/null`, so you won't see anything from the application when using `docker logs`. Most applications write everything to a log file too. If you do want to see this output with `docker logs`, you can use `-e DEBUG="yes"` to enable this.
