FROM gliderlabs/alpine

MAINTAINER blacktop, https://github.com/blacktop

COPY . /go/src/github.com/maliceio/malice-office
RUN apk-install python
RUN apk-install -t build-deps go git mercurial build-base py-pip python-dev py-setuptools \
  && set -x \
  && echo "Install office..." \  
  && pip install https://github.com/decalage2/oletools/zipball/master \
  && chmod +x /usr/lib/python2.7/site-packages/oletools/*.py \
  && ln -s /usr/lib/python2.7/site-packages/oletools/ezhexviewer.py /usr/local/bin/ezhexviewer \
  && ln -s /usr/lib/python2.7/site-packages/oletools/mraptor.py /usr/local/bin/mraptor \
  && ln -s /usr/lib/python2.7/site-packages/oletools/olebrowse.py /usr/local/bin/olebrowse \
  && ln -s /usr/lib/python2.7/site-packages/oletools/oledir.py /usr/local/bin/oledir \
  && ln -s /usr/lib/python2.7/site-packages/oletools/oleid.py /usr/local/bin/oleid \
  && ln -s /usr/lib/python2.7/site-packages/oletools/olemap.py /usr/local/bin/olemap \
  && ln -s /usr/lib/python2.7/site-packages/oletools/olemeta.py /usr/local/bin/olemeta \
  && ln -s /usr/lib/python2.7/site-packages/oletools/oleobj.py /usr/local/bin/oleobj \
  && ln -s /usr/lib/python2.7/site-packages/oletools/oletimes.py /usr/local/bin/oletimes \
  && ln -s /usr/lib/python2.7/site-packages/oletools/olevba.py /usr/local/bin/olevba \
  && ln -s /usr/lib/python2.7/site-packages/oletools/ppt_parser.py /usr/local/bin/ppt_parser \
  && ln -s /usr/lib/python2.7/site-packages/oletools/pyxswf.py /usr/local/bin/pyxswf \
  && ln -s /usr/lib/python2.7/site-packages/oletools/rtfobj.py /usr/local/bin/rtfobj \
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