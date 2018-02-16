# now that you're done with traces, let's talk about xevents

# Complaint: Faster to setup quick traces
# Complaint: Templates work remotely across all instances
# Answer: Now you can easily deploy all of your session templates or redeploy existing sessions across your whole enterprise
$servers = "localhost\sql2016","localhost\sql2017"
Get-DbaXESessionTemplate | Out-GridView -PassThru | Import-DbaXESessionTemplate -SqlInstance $servers | Start-DbaXESession
Get-DbaXESession -SqlInstance localhost\sql2016 -Session 'Acme Sample' | Export-DbaXESessionTemplate | Import-DbaXESessionTemplate -SqlInstance "localhost\sql2016"

Start-Process "$home\Documents\SQL Server Management Studio\Templates\XEventTemplates"