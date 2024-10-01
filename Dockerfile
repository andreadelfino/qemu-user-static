FROM debian:testing AS base

RUN apt update -y && apt install -yf qemu-user-static
ADD https://raw.githubusercontent.com/qemu/qemu/v9.1.0/scripts/qemu-binfmt-conf.sh /qemu-binfmt-conf.sh
RUN chmod +x /qemu-binfmt-conf.sh

####

FROM busybox:latest

ENV QEMU_BIN_DIR=/usr/bin

COPY ./register.sh /register
COPY --from=base /qemu-binfmt-conf.sh /
COPY --from=base /usr/bin/qemu-*-static /usr/bin/

ENTRYPOINT ["/register"]
