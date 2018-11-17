#!/bin/bash


for x in $(seq 0 14);do 
# write
( aws --endpoint-url=http://<insert-your-domain-here> s3 cp --quiet /dev/shm/testfile.img s3://s3testqwer1/$HOSTNAME-object-$x )&
pids="$pids $!"
done
wait $pids

# give a chance for all clients to finish
sleep 60

for x in $(seq 0 14);do
# read
 ( aws --endpoint-url=http://<insert-your-domain-here> s3 cp --quiet s3://s3testqwer1/$HOSTNAME-object-$x /dev/null  )&
 rpids="$rpids $!"
done
wait $rpids
