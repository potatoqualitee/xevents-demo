Import-Module C:\temp\new\dbatools\dbatools.psm1

Get-DbaXESession -SqlInstance localhost\sql2016 -Session WorkloadReplay | Start-DbaXESession | Watch-DbaXESession

