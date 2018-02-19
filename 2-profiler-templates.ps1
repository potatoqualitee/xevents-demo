break
# Complaint: Already have a library of Profiler templates
# Answer: Convert them instantly to Sessions (h/t Jonathan Kehayias)
Get-DbaTrace -SqlInstance localhost\sql2017 | Out-GridView -PassThru | Read-DbaTraceFile
Get-DbaTrace -SqlInstance localhost\sql2017 | Out-GridView -PassThru | Stop-DbaTrace

# Convert
Get-DbaTrace -SqlInstance localhost\sql2017 -Id 1 | ConvertTo-DbaXESession -Name 'Default Trace' | Start-DbaXESession

# Go look in SSMS! :D

# Remove that bad boy
Get-DbaTrace -SqlInstance localhost, localhost\sql2016, localhost\sql2017 | Out-GridView -PassThru | Remove-DbaTrace