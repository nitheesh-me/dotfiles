#!/bin/env bash

exec docker run --rm --intractive --volumme="${PWD}:/mnt" koalaman/shellcheck:stable "$@"
