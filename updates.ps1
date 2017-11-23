::windows_updates_enable.ps1"
"Adding Service"
$ServiceManager = New-Object -ComObject "Microsoft.Update.ServiceManager"
$ServiceManager.ClientApplicationID = "GIGUK WindowsUpdates"
$ServiceManager.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
"Starting wuauserv"
Start-Service wuauserv

