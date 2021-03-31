<p align="center">
<img src="https://i.imgur.com/ubHHTuu.png">
</p>

# BatchStealer

### A batch script for taking files or info and sending them to a webhook

* Windows 10 build 17063, or later (*cURL* is included)

31.3.2021 < FUD [(Virustotal)](https://www.virustotal.com/gui/file/3aaea776054652cb1f9a9e2840a61dd78bc8148db3a258380d3e14a297e48854/detection)

# Important

⚠️ It is forbidden to use this batch file for non-educational purposes. Use only with permission on your own computers.

# How to use

1. Change the webhook to yours
2. Remove fail-safes ("goto xxx")
3. Run the batch file

### Avoid
* Just changing the webhook and doing nothing else. If the batch file does nothing the user will open it to see what's wrong.

# Features

#### Steals (Almost everything is encrypted, I haven't had the patience to do that on a fucking batch file while staying FUD)
* Full system information (systeminfo)
  * OS Name & Version
  * Product ID
  * System Manufacturer
  * Processor(s)
  * BIOS Version
  * Time Zone:
  * Total Physical Memory
  * Network Card(s)
  * And more...
* Chrome
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
* Opera
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
* Vivaldi
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
* Firefox
  * Logins
  * key3
  * key4
* osu!
  * osu!.cfg
* Discord
  * File containing a Token
  * Other various files
* Steam
  * Logged in users (Username, email)
* Minecraft
  * Launcher profiles and accounts
* Growtopia
  * Save.dat

#### Other features
* Delete itself after execution
* Add itself to task scheduler (CMD window will be visible when executed by task scheduler)

# Support

* If you want to support the project do a pull request.
  * The pull request could be a new steal etc.

# Screenshots

<p align="center">
<img src="https://i.imgur.com/JSrmSzW.png">
</p>

# Obfuscation
* You can try [this](https://github.com/SkyEmie/batch-obfuscator)

# Legal

None of the authors, contributors, or anyone else connected with this open source project, in any way whatsoever, can be responsible for your use of the information or the application contained in or linked from this repository.

Under Section 107 of the Copyright Act 1976, allowance is made for "fair use" for purposes such as criticism, comment, news reporting, teaching, scholarship and research. Fair use is a use permitted by copyright statute that might otherwise be infringing. Non-profit, educational or personal use tips the balance in favor of fair use.

If you don't agree with any of our disclaimers above, do not read the code or download anything from our repository as you have no permission to read and explore our repository until you agree.
