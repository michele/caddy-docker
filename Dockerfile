FROM alpine:3.8 as alpine

WORKDIR /builder
RUN apk add -U --no-cache ca-certificates curl tar
RUN curl -L -o doctor.tgz https://github.com/michele/doctor/releases/latest/download/doctor_Linux_x86_64.tar.gz
RUN tar -zxf doctor.tgz

FROM scratch
WORKDIR /
COPY caddy /caddy
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=alpine /builder/doctor /
EXPOSE 443 80
CMD ["/caddy", "-conf", "/config/Caddyfile"]
