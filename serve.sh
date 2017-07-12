#!/bin/bash

./manage.py migrate

LD_PRELOAD=./stack-fix.so ./manage.py runserver 0.0.0.0:$PORT
