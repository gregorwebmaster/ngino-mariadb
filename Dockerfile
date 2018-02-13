FROM alpine:3.7


RUN apk update && \
    apk upgrade && \
    apk add mariadb && \
    echo -e '\033[42m\033[31m Database installed successfully. Thank you for using MariaDB. \033[m"

ADD scripts/run.sh /scripts/run.sh

RUN mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/run.sh"]