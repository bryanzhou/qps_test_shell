#!/bin/bash
thread_id=$1
test_times=$2
upload=$4
#echo $upload
total_thread=$3
echo thread $1 started


for(( i=0 ; i < test_times ;i++ ))
do
        { time ans=`eval $upload` ; } 1>>./tmp_log/out.log 2>> ./tmp_log/time.out 
	ans=$ans""
	echo $ans >> out.log
	#echo >> out.log
done
