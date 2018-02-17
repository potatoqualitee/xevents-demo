# Complaint: Reading using xe_file_target_read_file taxes the SQL Server CPU
# Answer: Now you can read files from any workstation or server
Read-DbaXEFile -Path C:\temp\deadocks.xel
Get-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources' | Read-DbaXEFile

# Or, again, you can read locally and export to remote table
Get-DbaXESession -SqlInstance localhost\sql2017 -Session 'Queries and Resources' | Read-DbaXEFile |
Write-DbaDataTable -SqlInstance localhost\sql2016 -Table tempdb.dbo.profiler -AutoCreateTable

# Or use New-DbaXESmartTableWriter