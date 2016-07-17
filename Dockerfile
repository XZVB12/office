FROM gliderlabs/alpine

MAINTAINER blacktop, https://github.com/blacktop

ENV OLEDUMP_URL didierstevens.com/files/software/oledump_V0_0_24.zip

COPY . /go/src/github.com/maliceio/malice-office
RUN apk-install python
RUN apk-install -t build-deps go \
                              git \
                              curl \
                              unzip \
                              py-pip \
                              mercurial \
                              build-base \
                              python-dev \
                              py-setuptools \
  && set -x \
  && echo "Install oletools..." \
  && export PIP_NO_CACHE_DIR=off \
  && export PIP_DISABLE_PIP_VERSION_CHECK=on \
  && pip install --upgrade pip wheel \
  && pip install olefile oletools \
  && echo "Fixing error in oledir.py" \
  && cd /usr/lib/python2.7/site-packages/oletools \
  && sed -i 's/from thirdparty.colorclass import colorclass/from thirdparty.colorclass import color/' oledir.py \
  && chmod +x *.py \
  && ln -s ezhexviewer.py /usr/local/bin/ezhexviewer \
  && ln -s mraptor.py /usr/local/bin/mraptor \
  && ln -s olebrowse.py /usr/local/bin/olebrowse \
  && ln -s oledir.py /usr/local/bin/oledir \
  && ln -s oleid.py /usr/local/bin/oleid \
  && ln -s olemap.py /usr/local/bin/olemap \
  && ln -s olemeta.py /usr/local/bin/olemeta \
  && ln -s oleobj.py /usr/local/bin/oleobj \
  && ln -s oletimes.py /usr/local/bin/oletimes \
  && ln -s olevba.py /usr/local/bin/olevba \
  && ln -s ppt_parser.py /usr/local/bin/ppt_parser \
  && ln -s pyxswf.py /usr/local/bin/pyxswf \
  && ln -s rtfobj.py /usr/local/bin/rtfobj \
  && echo "Install oledump..." \
  && curl -Ls https://${OLEDUMP_URL} > /tmp/oledump.zip \
  && cd /tmp \
  && mkdir -p /opt/oledump \
  && unzip oledump.zip -d /opt/oledump \
  && chmod +x /opt/oledump/oledump.py  \
  && ln -s /opt/oledump/oledump.py /usr/local/bin/oledump \
  && echo "Building scan Go binary..." \
  && cd /go/src/github.com/maliceio/malice-office \
  && export GOPATH=/go \
  && go version \
  && go get \
  && go build -ldflags "-X main.Version=$(cat VERSION) -X main.BuildTime=$(date -u +%Y%m%d)" -o /bin/scan \
  && echo "Clean unnecessary files..." \
  && cd /usr/lib/python2.7/site-packages/oletools \
  && find . ! -name '*.py*' -type f -exec rm -f {} + && rm -rf doc \
  && cd /usr/lib/python2.7/site-packages/olefile \
  && find . ! -name '*.py*' -type f -exec rm -f {} + && rm -rf doc \
  && rm -rf /go /tmp/* \
  && apk del --purge build-deps

WORKDIR /malware

ENTRYPOINT ["/bin/scan"]

CMD ["--help"]
