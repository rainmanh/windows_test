net accounts /maxpwage:unlimited


:: enable RDP:http://technet.microsoft.com/en-us/library/cc782195(v=ws.10).aspx
%SystemRoot%\System32\reg.exe ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
:: Enables User Login Access 
%SystemRoot%\System32\reg.exe ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v UserAuthentication /t REG_DWORD /d 1


%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateFileSizePercent /t REG_DWORD /d 0 /f
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateEnabled /t REG_DWORD /d 0 /f

netsh advfirewall firewall add rule name="All ICMP V4" dir=in action=allow protocol=icmpv4
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
::netsh advfirewall firewall add rule name=”KMS” dir=in action=allow protocol=tcp localport=1688
netsh advfirewall firewall set rule group="Key Management Service" new enable=Yes


net stop wuauserv

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v EnableFeaturedSoftware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v IncludeRecommendedUpdates /t REG_DWORD /d 1 /f


:: Disables Admin Auto Logon
if exist %SystemRoot%\System32\reg.exe (
  echo ==^> Disables Admin Auto Logon
  %SystemRoot%\System32\reg.exe DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /f
  %SystemRoot%\System32\reg.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f
  %SystemRoot%\System32\reg.exe DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /f
  %SystemRoot%\System32\reg.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /f
  :: %SystemRoot%\System32\reg.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d "" /f
  @if errorlevel 1 echo ==^> WARNING: Error %ERRORLEVEL%  was returned by: reg.exe ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f
)

:: Removes Last Logged User from Logon Screen and Enables UserSwitch
if exist %SystemRoot%\System32\reg.exe (
  echo ==^> Disables Admin Auto Logon
  %SystemRoot%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\UserSwitch /v Enabled /t REG_DWORD /d 1 /f
  %SystemRoot%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUser /d "" /f
  @if errorlevel 1 echo ==^> WARNING: Error %ERRORLEVEL%  was returned by: reg ADD LastLoggedOnUser and UserSwitch
)

::https://gist.githubusercontent.com/rainmanh/f8adaadc7a542d95330970cd33be1cd6/raw/b6d28494145a372e70780aff497157903ee45c0a/CloudbaseInitSetup_0_9_11_x64.msi
::
