#!/bin/bash

#check方法，需要自己指定判断接口是否正常返回的字段名

error_count=0
while read line
do
	result=`echo $line | jq .result`
	if [[ $result != true ]]
	then
		let error_count=error_count+1
		echo "get -------------- 1 error"
		echo $line >>error
	fi

done < ./tmp_log/out.log
echo error total $error_count
