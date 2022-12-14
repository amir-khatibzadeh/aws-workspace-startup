[CmdletBinding()]
param (
    [string]
    $ProfileName
)
$currentPWD = $PWD
Set-Location -Path "$env:USERPROFILE\appdata\Local\Amazon Web Services\Amazon WorkSpaces\"
$registrationList = Get-Content -Path .\RegistrationList.json -Raw | ConvertFrom-Json -Depth 10
$userSettings = Get-Content -Path .\UserSettings.json -Raw | ConvertFrom-Json -Depth 10

$currentProfile = $registrationList | Where-Object CustomDescription -EQ $ProfileName
$measure = $currentProfile | Measure-Object
if($measure.Count -gt 0){
    $userSettings.CurrentRegistration = $currentProfile[0]
    $content = $userSettings | ConvertTo-Json -Depth 10
    Set-Content -Path .\UserSettings.json -Value $content -Force
}

Start-Process -FilePath "C:\Program Files\Amazon Web Services, Inc\Amazon WorkSpaces\workspaces.exe"
Set-Location $currentPWD