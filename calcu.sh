#!/bin/bash
#set -x
time_count=0;
num_count=0;
max=0
large0=0
large1=0
large2=0
large_time_line0=50
large_time_line1=100
large_time_line2=200

thread=$1
<<<<<<< HEAD
duration=$2
flag=0
=======

flag=0

>>>>>>> d92969c56c323ea5781006d2dbcc22cc74d80f26
while read info tt
do
	#echo $info $tt
	if [[ $info == "real" ]] ; then 
	        q=`echo $tt | awk -F'[m.s]' '{print $2}'`
		m=`echo $tt | awk -F'[m.s]' '{print $3}'`
		q=$((10#$q))
                m=$((10#$m))
		let t=q*1000+m
		if [[ $t -gt $large_time_line0 ]]
                then
                let large0=large0+1
                fi
		if [[ $t -gt $large_time_line1 ]]
		then
		let large1=large1+1
		fi
		if [[ $t -gt $large_time_line2 ]]
                then
                let large2=large2+1
                fi
		#echo $t >> tmp
		if [[ $t -gt $max ]] 
		then
		max=$t 
 		fi
		let time_count=time_count+t
		let num_count=num_count+1	
	fi
done < time.out
echo count: $time_count
echo times: $num_count
echo max: $max

let avg=time_count/num_count
<<<<<<< HEAD
qps=`echo $num_count $duration | awk '{print ($1*1000000000)/$2}'`
=======
let qps=thread*1000
let qps=qps/avg
>>>>>>> d92969c56c323ea5781006d2dbcc22cc74d80f26

echo avg: $avg
echo qps: $qps
echo "large then $large_time_line0 total:" $large0
echo "large then $large_time_line1 total:" $large1
echo "large then $large_time_line2 total:" $large2
