![office logo](https://github.com/malice-plugins/office/blob/master/docs/office.png)

# malice-office (WIP)

[![Circle CI](https://circleci.com/gh/malice-plugins/office.png?style=shield)](https://circleci.com/gh/malice-plugins/office) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org) [![Docker Stars](https://img.shields.io/docker/stars/malice/office.svg)](https://hub.docker.com/r/malice/office/) [![Docker Pulls](https://img.shields.io/docker/pulls/malice/office.svg)](https://hub.docker.com/r/malice/office/) [![Docker Image](https://img.shields.io/badge/docker%20image-77.4MB-blue.svg)](https://hub.docker.com/r/malice/office/)

Malice Office/OLE/RTF Plugin

> This repository contains a **Dockerfile** of the malice plugin **malice/office**.

---

## Dependencies

- [blacktop/yara](https://hub.docker.com/r/blacktop/yara/)

## Installation

1. Install [Docker](https://www.docker.io/).
2. Download [trusted build](https://hub.docker.com/r/malice/office/) from public [DockerHub](https://hub.docker.com): `docker pull malice/office`

## Usage

```
$ docker run --rm -v /path/to/file:/malware:ro malice/office FILE
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

## Sample Output

### [JSON](https://github.com/malice-plugins/office/blob/master/docs/results.json)

```json
{
  "office":
}
```

### [Markdown](https://github.com/malice-plugins/office/blob/master/docs/SAMPLE.md)

---

### office

---

---

## Documentation

- [To write results to ElasticSearch](https://github.com/malice-plugins/office/blob/master/docs/elasticsearch.md)
- [To create a Office scan micro-service](https://github.com/malice-plugins/office/blob/master/docs/web.md)
- [To post results to a webhook](https://github.com/malice-plugins/office/blob/master/docs/callback.md)

## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/malice-plugins/office/issues/new) and I'll get right on it.

## CHANGELOG

See [`CHANGELOG.md`](https://github.com/malice-plugins/office/blob/master/CHANGELOG.md)

## Contributing

[See all contributors on GitHub](https://github.com/malice-plugins/office/graphs/contributors).

Please update the [CHANGELOG.md](https://github.com/malice-plugins/office/blob/master/CHANGELOG)

## Credits

Heavily (if not entirely) influenced by the [viper Office module](https://github.com/viper-framework/viper/blob/master/viper/modules/office.py) and by CSE's [alsvc_oletools](https://bitbucket.org/cse-assemblyline/alsvc_oletools)

## TODO

- [ ] add timeout protection

## License

MIT Copyright (c) 2016 **blacktop**
