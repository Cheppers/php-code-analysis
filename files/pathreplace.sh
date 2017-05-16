#!/bin/bash

FILE=$1
FROM=$2
TO=$3

sed -i -e "s=${FROM}=${TO}=g" $FILE
