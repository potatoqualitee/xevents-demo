# Complaint: Can't replay events from Session
# Answer: You can now read and execute from a xel file
Read-DbaXEFile -Path C:\temp\sample2.xel | Invoke-DbaXeReplay -SqlInstance localhost\sql2017 -Database planning

# Answer: Or, if you want an online replay, check out our preview of SmartReplay
# Ensure it's started
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources'

# Setup your response
$response = New-DbaXESmartReplay -SqlInstance localhost\sql2016 -Database planning
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Queries and Resources' -Responder $response


# As an added bonus, you can even get email notifications
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Pretend This is a Deadlock Capture'

$params = @{
    SmtpServer = "localhost"
    To = "sqldba@ad.local"
    Sender = "reports@ad.local"
    Subject = "Deadlock Captured"
    Body = "Caught a deadlock"
    Event = "sql_batch_completed"
    Filter = "batch_text = 'select @@servername'"
}

$emailresponse = New-DbaXESmartEmail @params
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Pretend This is a Deadlock Capture' -Responder $emailresponse

# You can handle them by using built-in commands as well
Get-DbaXESmartTarget | Stop-DbaXESmartTarget
Get-DbaXESmartTarget | Remove-DbaXESmartTarget
