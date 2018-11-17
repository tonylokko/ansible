#!/bin/bash

#set -x
# REQUIRES ROOT !!
cd /root/javaSCSP/
ulimit -n 20000

source ./GLOBALS

date=`date +%Y%m%d%H%M%S`
hostname=`hostname -s`
ff=`basename $0`
log_path=./`echo $ff | cut -d'.' -f1`/$hostname/$date
mkdir -p $log_path

if [ -z $DOMAIN ]; then
	 taskset -c 0-10,15-27 $JAVABIN $JVM -jar castortester-0.6.jar -rampup $rampup -hosts $PAN $DEBUG $ALIAS $WRITES $READS $REDIR $METRICS -httptimeout $httptimeout -httpretries $httpretries -objects $nbrobj -threads $nbrthreads -objectsize $sizeobj -uuidfile $log_path/uuid.txt -maxpool $MAXPOOL -reps $reps 2> $log_path/error.log | tee $log_path/result.log 
else
	 $JAVABIN $JVM -jar castortester-0.6.jar -rampup $rampup -hosts $PAN $DEBUG $ALIAS $WRITES -domain $DOMAIN -bucket $BUCKET $READS $REDIR $METRICS -httptimeout $httptimeout -httpretries $httpretries -objects $nbrobj -threads $nbrthreads -objectsize $sizeobj -uuidfile $log_path/uuid.txt -maxpool $MAXPOOL -reps $reps 2> $log_path/error.log | tee $log_path/result.log
fi

enddate=`date +%Y%m%d%H%M%S`
echo "runtime is `expr $enddate - $date` sec"
