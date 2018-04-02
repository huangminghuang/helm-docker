FROM golang:1.8

RUN go get go.mozilla.org/sops/cmd/sops
RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-static"' go.mozilla.org/sops/cmd/sops

FROM devth/helm
COPY --from=0 /go/bin/sops /usr/local/bin/sops
RUN apk --update add bind-tools gnupg py-yaml && rm -rf /var/cache/apk/*
RUN helm plugin install https://github.com/futuresimple/helm-secrets
