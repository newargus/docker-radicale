FROM python:3-alpine as builder
ARG TAG_VERSION
WORKDIR /app


RUN apk add --no-cache alpine-sdk libffi-dev
RUN pip install --upgrade pip
RUN pip install --user radicale[bcrypt]==$TAG_VERSION


FROM python:3-alpine
ARG TAG_VERSION
LABEL build_version="Version:- ${TAG_VERSION}"
LABEL maintainer="newargus"

RUN apk add --no-cache apache2-utils

COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local:$PATH

WORKDIR /app

COPY ./config/config /etc/radicale/config
COPY ./entrypoint.sh .

ENV USER_FILE=/data/users

VOLUME [ "/data" ]

EXPOSE 5232

CMD [ "/app/entrypoint.sh" ]
