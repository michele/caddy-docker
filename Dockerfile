FROM alpine:3.8 as alpine

RUN apk add -U --no-cache ca-certificates

FROM scratch
WORKDIR /
COPY caddy /caddy
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
VOLUME /Caddyfile
VOLUME /certs
EXPOSE 443 80
CMD ["/caddy", "-conf", "/Caddyfile"]
