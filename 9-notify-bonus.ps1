# As an added bonus, you can even get email notifications
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Deadlock Graphs'

# Use a PowerShell splat
$params = @{
    SmtpServer = "localhost"
    To = "sqldba@ad.local"
    Sender = "reports@ad.local"
    Subject = "Deadlock Captured"
    Body = "Caught a deadlock"
    Filter = "database_name = 'tempdb'"
    Event = "database_xml_deadlock_report"
}

$emailresponse = New-DbaXESmartEmail @params
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Deadlock Graphs' -Responder $emailresponse

# Create deadlock
Start-Process -FilePath powershell -ArgumentList C:\github\xevents-demo\deadlock-maker.ps1 -Wait