#/bin/bash
#	Vincent Chau 
# 	998947424
# 	ECS122B Spring 2016
# 	Program 1 - sanity_check.sh 


# 1. Take the the number of tests (number of files to sort) as its first command line
# argument, and the number of integers in each sample as its second command line
# argument. Your script should compile your source files and create executables if
# necessary.


javac quicksort_verbose.java
javac mergesort_verbose.java

# Reminder: each java program takes as arguments 
# for Quick Sort: < K , DataFilename >
numberTests=$1
numberInts=$2
testCount=0
passedAll=true
failCount=0
while [ $testCount != $1 ]
do
	counter=0
	while [ $counter != $2 ]
	do
		echo $[($RANDOM % $2)] >> data_${testCount}.txt
		((counter++))
	done
	k=$(($RANDOM%$2)) # set randomvalue for K as length to do insertion sort

		java QuickSortVerbose $k data_${testCount}.txt >> output_test_${testCount}.txt
		java MergeSortVerbose data_${testCount}.txt >> output2_test_${testCount}.txt
		diff=$(diff output_test_${testCount}.txt output2_test_${testCount}.txt)
		if [ "$diff" != "" ]; then
			echo "error?"
			$passedAll=false
			$failCount=$failCount+1
			$diff >> failedTest_${testCount}.txt
		else
			rm output2_test_${testCount}.txt
			rm output_test_${testCount}.txt
		fi

	((testCount++))
done

# Cleaning
rm *.class
rm data_*


if [[ $passedAll == true ]]; then
	printf "All tests passed.\n"
else
	printf "%d tests failed.\n"
	exit
fi

