## crash-test

Python will segfault when run inside a docker image created from this repo like
so:

```sh
$ docker-compose build

...

$ docker-compose run --service-ports --rm web

Starting crash-test-data ...
Starting crash-test-data ... done
Starting crash-test-db ... done
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  No migrations to apply.
Performing system checks...

Fatal Python error: Segmentation fault

Current thread 0x00007f986f029b48 (most recent call first):
  File "/usr/local/lib/python3.6/site-packages/django/utils/autoreload.py", line 305 in python_reloader
  File "/usr/local/lib/python3.6/site-packages/django/utils/autoreload.py", line 332 in main
  File "/usr/local/lib/python3.6/site-packages/django/core/management/commands/runserver.py", line 110 in run
  File "/usr/local/lib/python3.6/site-packages/django/core/management/commands/runserver.py", line 101 in handle
  File "/usr/local/lib/python3.6/site-packages/django/core/management/base.py", line 330 in execute
  File "/usr/local/lib/python3.6/site-packages/django/core/management/commands/runserver.py", line 62 in execute
  File "/usr/local/lib/python3.6/site-packages/django/core/management/base.py", line 283 in run_from_argv
  File "/usr/local/lib/python3.6/site-packages/django/core/management/__init__.py", line 355 in execute
  File "/usr/local/lib/python3.6/site-packages/django/core/management/__init__.py", line 363 in execute_from_command_line
  File "./manage.py", line 22 in <module>
./serve.sh: line 4:    12 Segmentation fault      ./manage.py runserver 0.0.0.0:$PORT
```

The autoreload code seems to be implicated; when run with `--noreload` a
SEGFAULT does not occur. In this specific example `boto3` is also implicated,
even though it's not used (it's only imported). Without importing `boto3` there
is no SEGFAULT.

### Open issues

I think these issues are all the same root cause, which seems to implicate
threading:

- [docker-library/python#211](https://github.com/docker-library/python/issues/211) (the issue I filed)
- [esnme/ultrajson#254](https://github.com/esnme/ultrajson/issues/254)
- [getsentry/raven-python#1003](https://github.com/getsentry/raven-python/issues/1003)

There's a potentially related bug that implicates `boto`:

- https://bugs.alpinelinux.org/issues/5590
