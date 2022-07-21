#!/bin/bash

python3 manage.py collectstatic --noinput
python3 manage.py migrate || echo "Database not available"
gunicorn -b 0.0.0.0:8000 accservermanager.wsgi
