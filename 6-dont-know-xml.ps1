# Complaint: Don't know XML and XPATH, which are required to query the results
# Answer: Now you can easily use PowerShell syntax - also works with Watch-DbaXESession
Get-DbaXESession -SqlInstance localhost\sql2017 | Read-DbaXEFile | 
Where-Object client_app_name -eq 'dbatools PowerShell module - dbatools.io' | Out-GridView