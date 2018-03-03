FROM devth/helm
RUN apk --update add bind-tools && rm -rf /var/cache/apk/*
RUN helm plugin install https://github.com/futuresimple/helm-secrets
