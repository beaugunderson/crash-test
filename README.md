## crash-test

Python will segfault when run inside a docker image created from this repo like
so:

```sh
$ docker-compose build
$ docker-compose run --service-ports --rm web
```
