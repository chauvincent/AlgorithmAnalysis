#/bin/bash
#	Vincent Chau 
# 	998947424
# 	ECS122B Spring 2016
# 	Program 1 - pipeline.sh

# Take the executable to run as the first command line argument, the number of
# samples (number of files to sort) as its second command line argument, and the
# number of integers in each sample as its third command line argument.


# Clean 
rm *.csv

# Running the stats
if [[ $1 == "quicksort" ]]; then
	echo "Sample Number","Language","Time","Number of Partitioning Stages","Number of Exchanges","Number of Compares" >> quicksort.csv
	javac quicksort_stats.java
	javac quicksort_timed.java
elif [[ $1 == "mergesort" ]]; then
	javac mergesort_timed.java
	javac mergesort_stats.java
elif [[ $1 == "both" ]]; then
	echo "Sample Number","Language","Time","Number of Partitioning Stages","Number of Exchanges","Number of Compares" >> quicksort.csv
	echo "Sample Number","Language","Time","Number of Recursive Calls","Number of Transitions","Number of Compares" >> mergesort.csv
	javac quicksort_stats.java
	javac mergesort_stats.java
	javac quicksort_timed.java
	javac mergesort_timed.java
else
	printf "\nPlease enter a either 'quicksort' or 'mergesort' as the first parameter.. or 'both'\n"
	printf "If you enter both, this will compare the outputs of both the sorts and diff\n\n"
	printf "eg: ./sanity_check.sh mergesort 10 300\n"
	printf "eg: ./sanity_check.sh both 1 20\n\n"
	printf "This will create 10 tests with 10 test files with 300 random number each\n\n"
	exit
fi
# Reminder: each java program takes as arguments 
# for Quick Sort: < K , DataFilename >
numberTests=$2
numberInts=$3
testCount=0
passedAll=true
failCount=0
timeTest=0
timeTest2=0
while [ $testCount != $2 ]
do
	counter=0
	while [ $counter != $3 ]
	do
		echo $[($RANDOM % $3)] >> data_${testCount}.txt
		((counter++))
	done
	k=$(($RANDOM%$3)) # set randomvalue for K as length to do insertion sort
	if [[ $1 == "quicksort" ]]; then
		#java QuickSortStats $k data_${testCount}.txt >> qsort_stats_${testCount}.txt 
		(time java QuickSortTimed $k data_${testCount}.txt) > time.txt 2>&1
		java QuickSortStats $k data_${testCount}.txt >> qsort_stats_${testCount}.txt
		timeTest=$(cat time.txt | grep real | cut -d: -f2)
		numExchange=$(cat qsort_stats_${testCount}.txt | grep Exchanges | cut -d: -f2)
		numPartition=$(cat qsort_stats_${testCount}.txt | grep Partitioning\ Stages | cut -d: -f2)
		numCompares=$(cat qsort_stats_${testCount}.txt | grep Compares\ Stages | cut -d: -f2)
		echo "${testCount}","Java","$timeTest","$numPartition","$numExchange","$numCompares" >> quicksort.csv
		rm time.txt
	elif [[ $1 == "mergesort" ]]; then
		(time java MergeSortTimed $k data_${testCount}.txt) > time2.txt 2>&1
		timeTest2=$(cat time2.txt | grep real | cut -d: -f2)
		java MergeSortStats data_${testCount}.txt >> msort_stats_${testCount}.txt
		numRecursive=$(cat msort_stats_${testCount}.txt | grep Recursive\ Calls | cut -d: -f2)
		numTransition=$(cat msort_stats_${testCount}.txt | grep Transitions | cut -d: -f2)
		numCompares2=$(cat msort_stats_${testCount}.txt | grep Compares | cut -d: -f2)
		echo "${testCount}","Java","$timeTest2","$numRecursive","$numTransition","$numCompares2" >> mergesort.csv
		rm time2.txt
	elif [[ $1 == "both" ]]; then
		java QuickSortStats $k data_${testCount}.txt >> qsort_stats_${testCount}.txt
		java MergeSortStats data_${testCount}.txt >> msort_stats_${testCount}.txt
		#time operations
		(time java QuickSortTimed $k data_${testCount}.txt) > time.txt 2>&1
		timeTest=$(cat time.txt | grep real | cut -d: -f2)
		rm time.txt
		# quicksort data
		numExchange=$(cat qsort_stats_${testCount}.txt | grep Exchanges | cut -d: -f2)
		numPartition=$(cat qsort_stats_${testCount}.txt | grep Partitioning\ Stages | cut -d: -f2)
		numCompares=$(cat qsort_stats_${testCount}.txt | grep Compares\ Stages | cut -d: -f2)
		echo "${testCount}","Java","$timeTest","$numPartition","$numExchange","$numCompares" >> quicksort.csv

		#time opeartions
		(time java MergeSortTimed $k data_${testCount}.txt) > time2.txt 2>&1
		timeTest2=$(cat time2.txt | grep real | cut -d: -f2)
		rm time2.txt
		# mergesort data
		numRecursive=$(cat msort_stats_${testCount}.txt | grep Recursive\ Calls | cut -d: -f2)
		numTransition=$(cat msort_stats_${testCount}.txt | grep Transitions | cut -d: -f2)
		numCompares2=$(cat msort_stats_${testCount}.txt | grep Compares | cut -d: -f2)
		echo "${testCount}","Java","$timeTest2","$numRecursive","$numTransition","$numCompares2" >> mergesort.csv
	fi
	((testCount++))
done

rm *.class
rm msort_*
rm qsort_*
rm data_*