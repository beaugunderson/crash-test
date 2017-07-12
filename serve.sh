#!/bin/bash

export LD_PRELOAD=/app/stack-fix.so

./manage.py migrate
./manage.py runserver 0.0.0.0:$PORT
