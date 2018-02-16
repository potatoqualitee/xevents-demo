# Complaint: Remembering to turn off Xevent
# Answer: PowerShell can help in 3 ways

# Answer: Auto create a disappearing Agent job
Start-DbaXESession -SqlInstance localhost\sql2016 -Session 'Queries and Resources' -StopAt (Get-Date).AddMinutes(30)

# Answer: Use dbachecks
Set-DbcConfig -Name policy.xevent.requiredstoppedsession -Value 'Queries and Resources'
Invoke-DbcCheck -SqlInstance localhost\sql2017 -Check XESessionStopped

# Or as mentioned before, Sessions can be easily stopped en masse
$servers | Get-DbaXESession | Out-GridView -PassThru | Stop-DbaXESession