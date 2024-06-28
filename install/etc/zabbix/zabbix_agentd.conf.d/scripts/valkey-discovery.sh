#!/usr/bin/env bash
# Description:  Get values stored in Valkey keys

getValues=$(valkey-cli --raw $1 $2)

echo -n '{"data":['
for value in $getValues; do echo -n "{\"{#VALUE}\": \"$value\"},"; done |sed -e 's:\},$:\}:'
echo -n ']}'

