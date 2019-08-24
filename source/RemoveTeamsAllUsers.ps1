#Thanks to Russ2964 on Spiceworks for this snipit.

if (test-path C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe) 
{kill -name teams -force; 
(Get-ItemProperty C:\Users\*\AppData\Local\Microsoft\Teams\Current).PSParentPath | foreach-object {Start-Process $_\Update.exe -ArgumentList "--uninstall /s" -PassThru -Wait} 
}
