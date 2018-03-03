FROM devth/helm
RUN apk --update add bind-tools && rm -rf /var/cache/apk/*