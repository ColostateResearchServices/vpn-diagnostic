@echo off
cls
echo ###########################################
echo #
echo #           VPN Diagnostic Report
echo #                  WCNR IT
echo #
echo ###########################################
:: Purpose: Exports user's Ping/Traceroute data to secure.colostate.edu to a file
:: Author: Jordan Etl

echo:

:: Test VPN Connection
echo Testing VPN Connection
ping -n 3 intranet.warnercnr.colostate.edu | find /I "Lost = 0"

if %errorlevel% == 1 (
	echo VPN connection is not working correctly, visit https://projects.warnercnr.colostate.edu/help/ to troubleshoot
	pause
	exit
)
echo VPN Succesfully connected

:: Global Variables
set report_file=VPN-Diagnostic-Report.txt
set current_path=%~d0%~p0

echo:

:: Gets the current date and time
set current_date_time=%date% %time%

echo:

:: Get user's full name
set /p full_name="Enter Full Name: "

echo:

:: Get user's eid
set /p ename="Enter EID: "

echo:

:: Get user's internet service provider
set /p inet_svcprv="Enter your internet service provider's name: "

echo:

:: Create file and fill in so far
echo Starting Report
echo %current_date_time%> %report_file%
echo %full_name%>> %report_file%
echo %ename%>> %report_file%
echo %inet_svcprv%>> %report_file%

echo:

:: Ping Secure.colostate.edu twice and put into report file
echo Pinging Secure.colostate.edu
ping secure.colostate.edu -n 2 >> %report_file%

echo:

:: TraceRoute Secure.colostate.edu and put into report file
echo Recording TraceRoute data (may take a minute)
tracert secure.colostate.edu >> %report_file%

echo:

:: Append ipconfig data
echo Recording ipconfig information
ipconfig >> %report_file%

echo:

:: Tell user the report is finished and where to find it.
echo Report finished and available at %current_path%\%report_file%

echo:
pause

exit
