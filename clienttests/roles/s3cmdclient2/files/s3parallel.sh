#!/bin/bash
for x in $(seq 0 10);do 
( s3cmd --signature-v2 --disable-multipart -q put /dev/shm/testfile.img s3://testbucket/$RANDOM )&
pids="$pids $!"
done
wait $pids
