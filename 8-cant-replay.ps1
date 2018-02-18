break
# Complaint: Can't replay events from Session
# Answer: You can now read and execute from a xel file
Get-ChildItem small-sample.xel | Read-DbaXEFile | Invoke-DbaXeReplay -SqlInstance localhost\sql2017


# Answer: Or, if you want an online replay, check out our preview of SmartReplay
# Ensure it's started
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources'

# Setup your response
$response = New-DbaXESmartReplay -SqlInstance localhost\sql2016 -Database planning
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'Queries and Resources' -Responder $response