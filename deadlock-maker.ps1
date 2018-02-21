Write-Host -Foreground Green "Starting up deadlock scripts"
Write-Host -Foreground Green "Gimme about 5 seconds to load up some parallel processes"

. C:\github\xevents-demo\invoke-parallel.ps1

$sql = "
IF OBJECT_ID('tempdb..table1') IS NULL
BEGIN
	CREATE TABLE table1 (column1 int);
	INSERT INTO table1 VALUES (1);
END

IF OBJECT_ID('tempdb..table2') IS NULL
BEGIN
	CREATE TABLE table2 (column1 int);
	INSERT INTO table2 VALUES (1);
END



BEGIN TRAN

UPDATE table1
SET column1 = 0

DECLARE @waitString varchar(50) = 'WAITFOR DELAY ''00:00:'+ RIGHT('0' + CAST(ABS(CHECKSUM(NEWID())) % 10 AS varchar(2)),2) +''''
EXEC(@waitString)

UPDATE table2
SET column1 = 0

ROLLBACK


BEGIN TRAN

UPDATE table2
SET column1 = 0

SET @waitString = 'WAITFOR DELAY ''00:00:'+ RIGHT('0' + CAST(ABS(CHECKSUM(NEWID())) % 10 AS varchar(2)),2) +''''
EXEC(@waitString)

UPDATE table1
SET column1 = 0

ROLLBACK
"
$dbs = @()
 1..3 | ForEach-Object {
     $dbs += "tempdb"
 }

$dbs | Invoke-Parallel -ImportVariables -ScriptBlock {
    try {
        sqlcmd -S localhost\sql2017 -Q $sql -d $psitem
    }
    catch {
        Write-Output "Potential deadlock detected"
    }
}

Read-Host -Prompt "Press enter to close"