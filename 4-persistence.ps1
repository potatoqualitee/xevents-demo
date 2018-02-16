# Complaint: XEvents are persistent
# Answer: Actually a good thing, especially if they are managable. But, you can discover that for yourself. Until then...
$servers | Get-DbaXESession | Out-GridView
$servers | Get-DbaXESession | Out-GridView -PassThru | Stop-DbaXESession
$servers | Get-DbaXESession | Out-GridView -PassThru | Remove-DbaXESession

# But that's not all!
Get-Command -Module dbatools -Name *DbaXe* | Out-GridView
