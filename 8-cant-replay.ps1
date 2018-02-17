# Complaint: Can't replay events from Session
# Answer: You can now read and execute from a xel file
Get-ChildItem small-sample.xel | Read-DbaXEFile | Invoke-DbaXeReplay -SqlInstance localhost\sql2017 -Database planning


# Answer: Or, if you want an online replay, check out our preview of SmartReplay
# Ensure it's started
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources'

# Setup your response
$response = New-DbaXESmartReplay -SqlInstance localhost\sql2016 -Database planning
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Queries and Resources' -Responder $response

# As an added bonus, you can even get email notifications
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Deadlock Graphs'

$params = @{
    SmtpServer = "localhost"
    To = "sqldba@ad.local"
    Sender = "reports@ad.local"
    Subject = "Deadlock Captured"
    Body = "Caught a deadlock"
    Attachment = "xml_report"
    AttachmentFileName = "report.xml"
}

# Event = 'database_xml_deadlock_report'

$emailresponse = New-DbaXESmartEmail @params
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Deadlock Graphs' -Responder $emailresponse

# Create deadlock
Start-Process -FilePath powershell -ArgumentList C:\github\xevents-demo\deadlock-maker.ps1 -Wait

# See the background process/job
Get-DbaXESmartTarget

# Stop will cancel
Stop-DbaXESession -SqlInstance localhost\sql2017 -Session 'Deadlock Graphs'

# You can handle them by using built-in commands as well
Get-DbaXESmartTarget
Get-DbaXESmartTarget | Remove-DbaXESmartTarget