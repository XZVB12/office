malice-office (WIP)
===================

[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org) [![Docker Stars](https://img.shields.io/docker/stars/malice/office.svg)](https://hub.docker.com/r/malice/office/) [![Docker Pulls](https://img.shields.io/docker/pulls/malice/office.svg)](https://hub.docker.com/r/malice/office/) [![Docker Image](https://img.shields.io/badge/docker%20image-77.4MB-blue.svg)](https://hub.docker.com/r/malice/office/)

Malice Office/OLE/RTF Plugin

This repository contains a **Dockerfile** of the malice plugin **malice/office**.

### Dependencies

-	[blacktop/yara](https://hub.docker.com/r/blacktop/yara/)

### Installation

1.	Install [Docker](https://www.docker.io/).
2.	Download [trusted build](https://hub.docker.com/r/malice/office/) from public [DockerHub](https://hub.docker.com): `docker pull malice/office`

### Usage

```
docker run --rm -v /path/to/file:/malware:ro malice/office FILE
```

```bash
Usage: office [OPTIONS] COMMAND [arg...]

Malice Office Plugin

Version: v0.1.0, BuildTime: 20160627

Author:
  blacktop - <https://github.com/blacktop>

Options:
  --verbose, -V      verbose output
  --rethinkdb value  rethinkdb address for Malice to store results [$MALICE_RETHINKDB]
  --post, -p         POST results to Malice webhook [$MALICE_ENDPOINT]
  --proxy, -x        proxy settings for Malice webhook endpoint [$MALICE_PROXY]
  --table, -t        output as Markdown table
  --help, -h         show help
  --version, -v      print the version

Commands:
  help  Shows a list of commands or help for one command

Run 'office COMMAND --help' for more information on a command.
```

This will output to stdout and POST to malice results API webhook endpoint.

### Sample Output JSON:

```json
{
  "office": {
  }
}
```

### Sample Output STDOUT (Markdown Table):

---

#### Office

---

### To write results to [RethinkDB](https://rethinkdb.com)

```bash
$ docker volume create --name malice
$ docker run -d -p 28015:28015 -p 8080:8080 -v malice:/data --name rethink rethinkdb
$ docker run --rm -v /path/to/malware:/malware:ro --link rethink:rethink malice/office -t FILE
```

### To Run on OSX

-	Install [Homebrew](http://brew.sh)

```bash
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew install docker
$ brew install docker-machine
$ docker-machine create --driver virtualbox malice
$ eval $(docker-machine env malice)
```

### Documentation

### Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/maliceio/malice-office/issues/new) and I'll get right on it.

### Credits

### TODO

### License

MIT Copyright (c) 2016-2017 **blacktop**
