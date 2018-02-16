# Complaint: Can't replay events from Session
# Answer: You can now read and execute from a xel file
Read-DbaXEFile -Path C:\temp\sample.xel | Invoke-DbaXeReplay -SqlInstance localhost\sql2017 -Database planning

# Answer: Or, if you want an online replay, check out our preview of SmartReplay
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources'
$response = New-DbaXESmartReplay -SqlInstance localhost\sql2016 -Database planning
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Queries and Resources' -Responder $response


# other smart things
$params = @{
    SmtpServer = "localhost"
    To = "sqldba@ad.local"
    Sender = "reports@ad.local"
    Subject = "Deadlock Captured"
    Body = "Caught a deadlock"
}

$emailresponse = New-DbaXESmartEmail @params
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Pretend This is a Deadlock Capture' -Responder $emailresponse -NotAsJob

# You can handle them by using built-in commands as well
Get-DbaXESmartTarget | Stop-DbaXESmartTarget
Get-DbaXESmartTarget | Remove-DbaXESmartTarget
