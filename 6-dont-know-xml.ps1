# Complaint: Don't know XML and XPATH, which are required to query the results
# Answer: Now you can easily use PowerShell syntax - also works with Watch-DbaXESession
Get-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources' | Read-DbaXEFile | 
Where-Object client_app_name -eq 'dbatools PowerShell module - dbatools.io' -or batch_text -match database_scoped_configurations


