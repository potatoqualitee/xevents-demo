break
# Complaint: Already have a library of Profiler templates
# Answer: Convert them instantly to Sessions (h/t Jonathan Kehayias [kay hi ass])
Get-DbaTrace -SqlInstance localhost\sql2017
Get-DbaTrace -SqlInstance localhost\sql2017 | Out-GridView -PassThru | Stop-DbaTrace

Get-DbaTrace -SqlInstance localhost\sql2017 -Id 1 | Read-DbaTraceFile
Get-DbaTrace -SqlInstance localhost\sql2017 -Id 1 | ConvertTo-DbaXESession -Name 'Default Trace'

# Remove that bad boy
Get-DbaTrace -SqlInstance localhost\sql2017 | Out-GridView -PassThru | Remove-DbaTrace