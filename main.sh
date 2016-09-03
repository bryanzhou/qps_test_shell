#!/bin/bash

#set -x
rm -rf test_output
rm -rf error 

test_case_count=1

while read thread_num test_times curl
do
	echo "test_num $test_case_count"
	echo "get thread_num $thread_num"  
	echo "get test_times $test_times"
	echo "get run_curl $curl"

	sh clear.sh

	echo "starting"

	start_time=`date +%s%N`

	for(( i=0;i < thread_num ; i++ ))
	do
		sh qps_test.sh  $i $test_times $thread_num "$curl" &  

	done

	wait

	end_time=`date +%s%N`
	let duration=end_time-start_time

	let test_count=thread_num*test_times

	echo "执行curl $curl" >> test_output
	echo "并发数 $thread_num   总发送量 $test_count" >> test_output

	#检查接口返回结果，默认关闭
	#echo "startcheck "
	#sh check.sh >> test_output

	echo "start caclu"
	echo $duration
	sh calcu.sh $thread_num $duration >> test_output


	echo "test case $test_case_count finished"
	echo -----------------------------------------------

	let test_case_count=test_case_count+1

	sleep 5

done  < test_info
