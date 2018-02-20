break

# Complaint: Can't replay events from Session
# Answer: You can now read and execute from a xel file
Get-ChildItem small-sample.xel | Read-DbaXEFile | Invoke-DbaXeReplay -SqlInstance localhost\sql2017



# Answer: Or, if you want an online replay, check out our preview of SmartReplay

# Setup
. C:\github\xevents-demo\setup-replay.ps1

# Ensure it's started
Start-DbaXESession -SqlInstance localhost\sql2017 -Session 'WorkloadReplay'

# Setup your response
$response = New-DbaXESmartReplay -SqlInstance localhost\sql2016 -SqlCredential $cred
Start-DbaXESmartTarget -SqlInstance localhost\sql2017 -Session 'WorkloadReplay' -Responder $response

# Start Workload
Start-Process -FilePath powershell -ArgumentList C:\github\xevents-demo\start-workload.ps1

# Display Events
Start-Process -FilePath powershell -ArgumentList C:\github\xevents-demo\display-workload.ps1 