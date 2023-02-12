function Start-Rain
{
    param(
        [string]$Source,
        [string]$Unattended
    )

    $VirtualMachine = @{
        SourcePath = $Source
        Edition    = 6
        VhdType    = "Dynamic"
        VhdFormat  = "VHDX"
        VhdPath    = ".\H4rdRain.vhdx"
        DiskLayout = "UEFI"
        SizeBytes  = 127GB
        UnattendPath = $Unattended
    }

    Convert-WindowsImage @VirtualMachine
    Dismount-DiskImage -ImagePath $Source | Out-Null
    New-VM -Name "H4rdRain" -MemoryStartupBytes 16GB -Generation 2 -VHDPath ".\H4rdRain.vhdx" 
}


Add-Type -AssemblyName System.Windows.Forms
$Selector = New-Object System.Windows.Forms.OpenFileDialog -Property @{Title = 'Select an ISO File'; Filename = 'Select an iso file'; Filter = 'ISO files (*.iso)|*.iso|All files (*.*)|*.*'; }
$Selector.ShowDialog()
$Source = $Selector.FileName

Start-Rain -Source $Source -Unattended ".\autounattend.xml"
Start-Vm -Name "H4rdRain"
vmconnect localhost "H4rdRain"
