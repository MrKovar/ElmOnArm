# ElmOnArm

Since version 19 elm has been releasing pre-built binaries for every major OS and platform except Linux on Arm. This repository will compile a binary for elm 0.19.1 on an ARM64 platform for use in your ARM Docker images or to grab the binary for use on your Raspberry Pi or other ARM device.

Building this Dockerfile will yield a binary for elm version 0.19.1 in the `/usr/local/bin` directory. No need to rtfm and build it yourself.

NOTE: This builds the binary from scratch, so a build time of ~8 minutes is expected.

The image created from the Dockerfile also exists on [Dockerhub](https://hub.docker.com/r/kovarcodes/elmonarm) for easy usage.

## Dockerfile Usage

You can easily add the binary to your Dockerfile by using the `COPY` command with the `--from` flag.

Example:

```Dockerfile
COPY --from=elmonarm:latest --chown=nobody:root /usr/local/bin/elm /usr/local/bin/elm
```

Then you can freely use the `elm` binary in your Dockerfile!

## Get Binary for Local Usage - Pi or Other ARM Device

### Get the image

```bash
docker pull kovarcodes/elmonarm:latest
```

Or if you want to build the image yourself after cloning this repository:

```bash
docker build -t elmonarm:latest .
```

### Get the binary

```bash
docker run --name elmonarm elmonarm:latest && \
docker container cp elmonarm:/usr/local/bin/elm /usr/local/bin/elm
```

Or replace the seconed `/usr/local/bin/elm` with the path you want to copy the binary to.

Your binary is now available for use on your ARM device!

## License and Credits

This project is made available in part to the BSD 3-Clause licensing of the work by the elm-lang team. See [the original repository's license](https://github.com/elm/compiler/blob/master/LICENSE) for more information.
