

Var GlobalName
Section GlobalName
	StrCpy $GlobalName "TeamsAnnihilator"
SectionEnd


!ifndef OUTPUT_EXE
    !define OUTPUT_EXE "TeamsAnnihilator.exe"
!endif

BrandingText $GlobalName
Caption $GlobalName
CompletedText "Installation Complete"
InstallColors 336699 333333
InstProgressFlags colored smooth
Name $GlobalName
OutFile ${OUTPUT_EXE}
RequestExecutionLevel admin
ShowInstDetails show
XPStyle off
# TargetMinimalOS 5.1

Section ""
SetShellVarContext all
#    Var /GLOBAL targetdir

	WriteRegDWORD HKCU "SOFTWARE\Policies\Microsoft\Office\16.0\Teams" "PreventFirstLaunchAfterInstall" 00000001
	WriteRegDWORD HKLM "SOFTWARE\Policies\Microsoft\Office\16.0\common\officeupdate" "preventteamsinstall" 00000001
	
	ExecWait "msiexec.exe /X {731F6BAA-A986-45A4-8936-7C3AAAAA760B} /QN"
	
	SetOutPath $TEMP
	File source\RemoveTeamsAllUsers.ps1
	ExecWait "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File $TEMP\RemoveTeamsAllUsers.ps1 -FFFeatureOff"
	
	DetailPrint "Successfully Completed"
	

SectionEnd
