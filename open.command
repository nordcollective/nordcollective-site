#!/bin/bash

cd "$(dirname "$0")"

(
    sleep 1;
    open http://localhost:8000
) &

python -m SimpleHTTPServer 8000
