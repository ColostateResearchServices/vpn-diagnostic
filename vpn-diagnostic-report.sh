#!/bin/bash

# ---------------------
# VPN Diagnostic Report
# WCNR IT
# ---------------------

# Purpose: Exports user's Ping/Traceroute data to secure.colostate.edu to a file
# Author: Jordan Etl

# Global Variables
output_report='VPN-Diagnostic-Report.txt'

# Get current date and time
current_date_time=$(date)

# Create File
echo Writing to to file $output_report
echo $current_date_time > $output_report
echo -en '\n' >> $output_report #adds line between sections for readability

# Get user's full name
read -p 'Enter Full Name: ' full_name

echo $full_name >> $output_report 
echo -en '\n' >> $output_report #adds line between sections for readability

# Get user's ename
read -p 'Enter EID: ' ename

echo $ename >> $output_report
echo -en '\n' >> $output_report #adds line between sections for readability

# Get Ping to Secure.colostate.edu
echo Pinging secure.colostate.edu
ping secure.colostate.edu -c 5 >> $output_report
echo -en '\n' >> $output_report

# Traceroute secure.colostate.edu
echo Recording Traceroute data to secure.colostate.edu, this may take a minute
if [ -x "$(command -v traceroute)" ]; then
    traceroute -w 3 -q 1 secure.colostate.edu >> $output_report
elif [ -x "$(command -v tracepath)" ]; then
    tracepath secure.colostate.edu >> $output_report
else
    tput setaf 1;
    echo "Please install traceroute package!"
    tput sgr0;
    exit
fi
echo -en '\n' >> $output_report

# get IP address information
echo Getting IP address information
if [ -x "$(command -v ip)" ]; then
    ip addr >> $output_report
elif [ -x "$(command -v ifconfig)" ]; then
    ifconfig >> $output_report
else
    tput setaf 1;
    echo "Please install net-tools package!"
    tput sgr0;
    exit
fi
# Tell user file and where to find it
tput setaf 3;
echo VPN Diagnostic Report Complete. Result in $output_report
tput sgr0;
