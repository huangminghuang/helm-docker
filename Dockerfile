FROM golang:1.8
RUN go get go.mozilla.org/sops/cmd/sops
RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-static"' go.mozilla.org/sops/cmd/sops

FROM devth/helm
RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    py-yaml
RUN pip install jsonpath-ng ruamel.yaml

FROM devth/helm
COPY --from=0 /go/bin/sops /usr/local/bin/sops
COPY --from=1 /usr/lib/python2.7/site-packages /usr/lib/python2.7/site-packages
RUN apk --update add bind-tools gnupg py-yaml && rm -rf /var/cache/apk/*
RUN helm plugin install https://github.com/futuresimple/helm-secrets
