# These all exhibit the SEGFAULT behavior
FROM python:3.6-alpine3.6
# FROM python:3.6-alpine
# FROM python:3.6.2rc2-alpine3.6

# logging to the console breaks without this
ENV PYTHONUNBUFFERED 1
ENV PYTHONFAULTHANDLER 1

RUN apk add --no-cache \
        bash \
        build-base \
        gettext \
        linux-headers \
        musl-dev \
        postgresql-client \
        postgresql-dev

RUN mkdir -p /app/

WORKDIR /app/

# so we can cache the installed python modules apart from the app files
COPY *.txt /app/

RUN pip3 install --upgrade pip setuptools
RUN pip3 install -r requirements.txt -r dev-requirements.txt

COPY . /app/

RUN cd /app/ && gcc -shared -fPIC stack-fix.c -o stack-fix.o
