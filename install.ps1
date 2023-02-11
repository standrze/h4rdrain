$Unattended = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <ProtectYourPC>3</ProtectYourPC>
                <HideLocalAccountScreen>false</HideLocalAccountScreen>
            </OOBE>
            <RegisteredOrganization></RegisteredOrganization>
            <DisableAutoDaylightTimeSet>false</DisableAutoDaylightTimeSet>
            <TimeZone>Eastern Standard Time</TimeZone>
        </component>
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <InputLocale>0409:00000409</InputLocale>
            <SystemLocale>en-US</SystemLocale>
            <UILanguage>en-US</UILanguage>
            <UILanguageFallback>en-US</UILanguageFallback>
            <UserLocale>en-US</UserLocale>
        </component>
    </settings>
    <cpi:offlineImage cpi:source="wim:c:/users/sandr/onedrive/desktop/install.wim#Windows 11 Pro" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
</unattend>
"@

$Unattended | Out-File -FilePath ".\autounattend.xml"

function Start-Rain
{
    param(
        [string]$Source,
        [string]$Unattended
    )

    #Size at 40GB, Memory /2 for testing
    Convert-WindowsImage -SourcePath $Source -Edition 6 -VhdFormat "VHDX" -DiskLayout "UEFI" -VhdPath "H4rdRain.vhdx" -SizeBytes 40GB -UnattendPath $Unattended 
    Dismount-DiskImage -ImagePath $Source | Out-Null
    New-VM -Name "H4rdRain" -MemoryStartupBytes 16GB -Generation 2 -VHDPath "H4rdRain.vhdx" 
}


Add-Type -AssemblyName System.Windows.Forms
$Selector = New-Object System.Windows.Forms.OpenFileDialog -Property @{Title = 'Select an ISO File'; Filename = 'Select an iso file'; Filter = 'ISO files (*.iso)|*.iso|All files (*.*)|*.*'; }
$Selector.ShowDialog()
$Source = $Selector.FileName

Start-Rain -Source $Source -Unattended ".\autounattend.xml"
