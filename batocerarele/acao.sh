#!/bin/bash

N=$QUERY_STRING

ARQ="/tmp/www/cgi-bin/t$N.txt"

case `cat $ARQ` in
0)
echo 1 > $ARQ
;;
1)
echo 0 > $ARQ
;;
esac
