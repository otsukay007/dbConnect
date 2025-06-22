# Database access Web Api
# KVM claud mariadb
# Author: iiujapan
# Date: 2025-6-15
# Version: 1.0.0

# Define class
class dbConnectClass {
    [string]$ConnectionString
    [System.Data.Odbc.OdbcConnection] $connection
    [System.Data.Odbc.OdbcCommand] $command
    [System.Data.Odbc.OdbcDataReader] $reader
    [System.Data.Odbc.OdbcDataAdapter] $adapter
    [System.Data.DataTable] $dataTable
    [System.Data.Odbc.OdbcTransaction] $transaction
    [string]$TableName
    [string]$DatabaseName

    dbConnectClass([string]$connectionString) {
        $this.ConnectionString = $connectionString

        $connectString = "DSN=KVM; UID=iiujapan; PWD=iiujapan;"
        $this.connection = New-Object System.Data.Odbc.OdbcConnection($connectString)
        $this.connection.Open()

    }

    [void]Connect() {
        # Implement connection logic here
        $this.command = $this.connection.CreateCommand( )
        $this.command.CommandText = "select * from tmdb_info_Avatar2"
    }

    [void]ReadData() {
        # Implement read logic here
    }

    [void]WriteData() {
        # Implement write logic here
    }

    [void]Terminate() {
        # Implement termination logic here 
        if ($null -ne $this.reader) {
            $this.reader.Close()
        }
        $this.command.Dispose()

        $this.connection.Close()
        $this.connection.Dispose()
    }
}

Set-Location $PSScriptRoot

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
