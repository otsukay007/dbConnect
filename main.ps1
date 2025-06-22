# Database access Web Api
# KVM claud mariadb
# Author: iiujapan
# Date: 2025-6-15
# Version: 1.0.0

# include class
. dbConnectClass.ps1
. dbUserDatabaseClass.ps1


Set-Location $PSScriptRoot
try {
    $com = [dbConnect]::new("DSN=KVM; UID=iiujapan; PWD=iiujapan;")
    $com.Connect()
    $com.ReadData()
}
catch {
    Write-Output "Error occurred: $_"
}

$ret = $com.Terminate()
if ($ret) {
    Write-Output "Connection terminated successfully."
} else {
    Write-Output "Failed to terminate connection."
}





#
# read
#
$connectionString = "DSN=KVM; UID=iiujapan; PWD=iiujapan;"
$connection = New-Object System.Data.Odbc.OdbcConnection($connectionString)
$connection.Open()

$command = $connection.CreateCommand( )
$command.CommandText = "select * from tmdb_info_Avatar2"
$reader = $command.ExecuteReader()
while ($reader.Read()) {
    $row = @{}
    for ($i = 0; $i -lt $reader.FieldCount; $i++) {
        $row[$reader.GetName($i)] = $reader.GetValue($i)
    }
    Write-Output $row
}

$reader.Close()
$command.Dispose()

$connection.Close()
$connection.Dispose()

#
# write
#

#
# copy table 
#
