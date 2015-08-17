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

	for(( i=0;i < thread_num ; i++ ))
	do
		sh qps_test.sh  $i $test_times "$curl" &  

	done

	sleep 1


	let test_count=thread_num*test_times
	while [[ 1 -gt 0 ]]
	do
		line_count=`wc -l out.log | awk '{print $1}'`
		if [[ $line_count -ge $test_count ]]
		then
		break
		fi
		sleep 3
	done

	echo "执行curl $curl" >> test_output
	echo "并发数 $thread_num   总发送量 $test_count" >> test_output

	#检查接口返回结果，默认关闭
	#echo "startcheck "
	#sh check.sh >> test_output

	echo "start caclu"

	sh calcu.sh $thread_num >> test_output


	echo "test case $test_case_count finished"
	echo -----------------------------------------------

	let test_case_count=test_case_count+1

	sleep 5

done  < test_info
