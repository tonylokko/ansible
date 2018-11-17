#!/bin/bash
# --disable-multipart
for x in $(seq 0 20);do 
( s3cmd --signature-v2 -q put /dev/shm/testfile.img s3://testbucket/$RANDOM )&
pids="$pids $!"
done
wait $pids
