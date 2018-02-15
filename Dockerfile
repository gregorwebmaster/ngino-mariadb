FROM alpine:3.7

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


RUN apk update && \
    apk upgrade && \
    apk add mariadb mariadb-client && \
    echo -e "\033[42m\033[31m Database installed successfully. Thank you for using MariaDB. \033[m"

ADD scripts/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/run.sh"]