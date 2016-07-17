FROM gliderlabs/alpine

MAINTAINER blacktop, https://github.com/blacktop

COPY . /go/src/github.com/maliceio/malice-office
RUN apk-install python py-setuptools
RUN apk-install -t build-deps go git mercurial build-base py-pip python-dev \
  && set -x \
  && echo "Install office..." \  
  && pip install https://github.com/decalage2/oletools/zipball/master \
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