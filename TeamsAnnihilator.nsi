!include LogicLib.nsh
!include x64.nsh
!include WinVer.nsh


Var GlobalName
Section GlobalName
	StrCpy $GlobalName "TeamsAnnihilator"
SectionEnd
!ifndef CONFIG_DIR
    !define CONFIG_DIR "config"
!endif

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

    # Maybe warn that directory is not here?
    # @todo check for RDP_encryption_fix Dir in Registry

	#SetOutPath $TEMP
    #DetailPrint "Extracting RDP_encryption_fix $OUTDIR"
	
	WriteRegDWORD HKCU "SOFTWARE\Policies\Microsoft\Office\16.0\Teams" "PreventFirstLaunchAfterInstall" 00000001
	WriteRegDWORD HKLM "SOFTWARE\Policies\Microsoft\Office\16.0\common\officeupdate" "preventteamsinstall" 00000001
	
	ExecWait "msiexec.exe /X {731F6BAA-A986-45A4-8936-7C3AAAAA760B} /QN"
	
	SetOutPath $TEMP
	File source\RemoveTeamsAllUsers.ps1
	ExecWait "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File $TEMP\RemoveTeamsAllUsers.ps1 -FFFeatureOff"
	
	
	
	
	#WriteRegDWORD HKLM "OFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoUpdate" 00000001
	
	#SetOutPath $TEMP
    #DetailPrint "Extracting $OUTDIR"
	
	#File config\IntronRootCa2.crt
	#File config\IntronRootCA.crt
	
	#File source\installCertAuth.bat
	
	#ExecWait "$TEMP\installCertAuth.bat" $0
	#IntCmp $0 0 goodInstall
    #        DetailPrint "Failed to Install Certs: $0"
    #        MessageBox MB_OK|MB_ICONSTOP "Failed to install CertAuth"
    #        Quit
	#goodInstall:
	
	DetailPrint "Successfully Installed"
	

SectionEnd