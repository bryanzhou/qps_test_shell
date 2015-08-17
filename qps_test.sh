#!/bin/bash
thread_id=$1
test_times=$2
upload=$3
echo $upload

echo thread $1 started

for(( i=0 ; i < test_times ;i++ ))
do
        { time ans=`eval $upload` ; } 1>>out.log 2>> time.out 
	ans=$ans""
	echo $ans >> out.log
	#echo >> out.log
done
