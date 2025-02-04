# github.com/tiredofit/docker-valkey


[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-valkey?style=flat-square)](https://github.com/tiredofit/docker-valkey/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-valkey/build?style=flat-square)](https://github.com/tiredofit/docker-valkey/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/valkey.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/valkey/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/valkey.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/valkey/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker image for [Valkey](https://www.valkey.io) - a highly performant key value store.

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions-1)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions

No prerequisites

## Prerequisites and Assumptions

- This image doesn't do much on it's own, you must use a complemenary service to pass messages or data to it via port 783.

## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/valkey)

```bash
docker pull docker.io/tiredofit/valkey:(imagetag)
```
Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-valkey/pkgs/container/docker-valkey)

```
docker pull ghcr.io/tiredofit/docker-valkey:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Version | Container OS | Tag       |
| ------- | ------------ | --------- |
| latest  | Alpine       | `:latest` |
| 7       | Alpine       | `:7`      |
| 6       | Alpine       | `:6`      |
| 5       | Alpine       | `:5`      |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary
### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Parameter    | Description           |
| ------------ | --------------------- |
| `/data/db`   | Application Directory |
| `/data/logs` | Logfiles              |


* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |

| Parameter     | Description                            | Default  | `_FILE` |
| ------------- | -------------------------------------- | -------- | ------- |
| `ENABLE_LOGS` | Enable Logfiles `TRUE` or `FALSE`      | `TRUE`   |         |
| `LOG_LEVEL`   | Log level                              | `notice` |         |
| `REDIS_PORT`  | Listening Port                         | `6379`   |         |
| `REDIS_PASS`  | (optional) Require password to connect |          | x       |

### Networking

The following ports are exposed.

| Port   | Description |
| ------ | ----------- |
| `6379` | Redis Port  |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- [Sponsor me](https://tiredofit.ca/sponsor) for personalized support
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- [Sponsor me](https://tiredofit.ca/sponsor) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- [Sponsor me](https://tiredofit.ca/sponsor) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* https://valkey.io/


