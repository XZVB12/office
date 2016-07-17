FROM gliderlabs/alpine

MAINTAINER blacktop, https://github.com/blacktop

ENV OLETOOLS_VERSION 0.47

COPY . /go/src/github.com/maliceio/malice-office
RUN apk-install python
RUN apk-install -t build-deps go git mercurial build-base py-pip python-dev py-setuptools \
  && set -x \
  && echo "Install office..." \
  && git clone --branch v${OLETOOLS_VERSION} https://github.com/decalage2/oletools.git /opt/oletools \
  && cd /opt/oletools \
  && python setup.py install \
  && chmod +x /opt/oletools/oletools/*.py \
  && ln -s /opt/oletools/oletools/ezhexviewer.py /usr/local/bin/ezhexviewer \
  && ln -s /opt/oletools/oletools/mraptor.py /usr/local/bin/mraptor \
  && ln -s /opt/oletools/oletools/olebrowse.py /usr/local/bin/olebrowse \
  && ln -s /opt/oletools/oletools/oledir.py /usr/local/bin/oledir \
  && ln -s /opt/oletools/oletools/oleid.py /usr/local/bin/oleid \
  && ln -s /opt/oletools/oletools/olemap.py /usr/local/bin/olemap \
  && ln -s /opt/oletools/oletools/olemeta.py /usr/local/bin/olemeta \
  && ln -s /opt/oletools/oletools/oleobj.py /usr/local/bin/oleobj \
  && ln -s /opt/oletools/oletools/oletimes.py /usr/local/bin/oletimes \
  && ln -s /opt/oletools/oletools/olevba.py /usr/local/bin/olevba \
  && ln -s /opt/oletools/oletools/ppt_parser.py /usr/local/bin/ppt_parser \
  && ln -s /opt/oletools/oletools/pyxswf.py /usr/local/bin/pyxswf \
  && ln -s /opt/oletools/oletools/rtfobj.py /usr/local/bin/rtfobj \
  && echo "Building scan Go binary..." \
  && cd /go/src/github.com/maliceio/malice-office \
  && export GOPATH=/go \
  && go version \
  && go get \
  && go build -ldflags "-X main.Version=$(cat VERSION) -X main.BuildTime=$(date -u +%Y%m%d)" -o /bin/scan \
  && rm -rf /go /tmp/* \
  && apk del --purge build-deps

WORKDIR /malware

ENTRYPOINT ["/bin/scan"]

CMD ["--help"]
