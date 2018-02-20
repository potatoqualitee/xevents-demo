Import-Module C:\temp\new\dbatools\dbatools.psm1

$instance_name = "localhost\sql2017"

$sql = "
INSERT INTO ReplayDB.dbo.testNumbers OUTPUT(INSERTED.num) DEFAULT VALUES;

WAITFOR DELAY '00:00:01';
"

$pwd = "replayuser" | ConvertTo-SecureString -AsPlainText -Force
[pscredential]$cred = New-Object System.Management.Automation.PSCredential -ArgumentList "replayuser",$pwd
$db = Get-DbaDatabase -SqlInstance $instance_name -SqlCredential $cred -Database ReplayDB 
while($true) {
    Write-Host $sql
    $db.Query($sql)
}
