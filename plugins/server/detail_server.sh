#!/bin/bash
clear

sysinfo() {
	# Removing existing bench.log
	rm -rf $HOME/bench.log
	# Reading out system information...
	# Reading CPU model
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
	# Reading amount of CPU cores
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	# Reading CPU frequency in MHz
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
	# Reading total memory in MB
	tram=$( free -m | awk 'NR==2 {print $2}' )
	# Reading Swap in MB
	vram=$( free -m | awk 'NR==4 {print $2}' )
	# Reading system uptime
	up=$( uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }' | sed 's/^[ \t]*//;s/[ \t]*$//' )
	# Reading operating system and version (simple, didn't filter the strings at the end...)
	opsy=$( cat /etc/issue.net | awk 'NR==1 {print}' ) # Operating System & Version
	arch=$( uname -m ) # Architecture
	lbit=$( getconf LONG_BIT ) # Architecture in Bit
	hn=$( hostname ) # Hostname
	kern=$( uname -r )
	# Date of benchmark
	bdates=$( date )
	
	echo "Benchmark started on $bdates"
	echo "Full benchmark log: $HOME/bench.log"
	echo ""
	
	# Output of results
	echo "System Info"
	echo "-----------"
	echo "Processor	: $cname"
	echo "CPU Cores	: $cores"
	echo "Frequency	: $freq MHz"
	echo "Memory		: $tram MB"
	echo "Swap		: $vram MB"
	echo "Uptime		: $up"
	echo ""
	echo "OS		: $opsy"
	echo "Arch		: $arch ($lbit Bit)"
	echo "Kernel		: $kern"
	echo "Hostname	: $hn"
	echo ""
}

sysinfo