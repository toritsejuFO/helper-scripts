#!/bin/bash

date | sed 's/  / /' | sed 's/ /-/g' | awk '{print tolower($1)}'
