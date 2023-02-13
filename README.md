# h4rdrain

*Requires PowerShell 5.1 to run, default PowerShell. Run as Administrator*


Requires Hyper-V (Professional or Server Edition), run the following command Hyper-V is not installed as Administrator
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

Set PowerShell Execution Policy to Unrestricted
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
```

Install Convert-WindowsImage Module from repository
```
Import-Module .\Convert-WindowsImage.psm1
```

Run install.ps1 from within unzipped repository
```
.\install.ps1
```

Enter Username and Password (if desired), should boot directly into Windows.

Note:


- To cleanup, delete Hyper-V Guest and vhdx file found the same folder as install.ps1. 
