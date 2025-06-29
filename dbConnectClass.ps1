# dbConnectClass.ps1
# This script defines a class for managing a database connection using ODBC in PowerShell.
# Requires -Version 5.0

# use database





# 自身のデータベースを管理するクラス
class dbConnect {
    [string]$ConnectionString = $null
    [System.Data.Odbc.OdbcConnection] $connection = $null
    [System.Data.Odbc.OdbcCommand] $command
    [System.Data.Odbc.OdbcDataReader] $reader
    [System.Data.Odbc.OdbcDataAdapter] $adapter
    [System.Data.DataTable] $dataTable
    [System.Data.Odbc.OdbcTransaction] $transaction
    [string]$TableName
    [string]$DatabaseName

    dbConnect([string]$connectionString) {
        $this.ConnectionString = $connectionString

        # $connectString = "DSN=KVM; UID=iiujapan; PWD=iiujapan;"
        $this.connection = New-Object System.Data.Odbc.OdbcConnection($connectionString)
        $this.connection.Open()

    }

    [void]Connect() {
        # Implement connection logic here
        $this.command = $this.connection.CreateCommand( )
        $this.command.CommandText = "select * from tmdb_info_Avatar2"
    }

    # Select use database
    [void]UseDatabase() {
        $this.command = $this.connection.CreateCommand( )
        $this.command.CommandText = "use kokoro"
    }    


    [void]ReadData() {
        # Implement read logic here
        $this.reader = $this.command.ExecuteReader()
        while ($this.reader.Read()) {
            $row = @{}
            for ($i = 0; $i -lt $this.reader.FieldCount; $i++) {
                $row[$this.reader.GetName($i)] = $this.reader.GetValue($i)
            }
            Write-Output $row
        }
    }

    [void]WriteData() {
        # Implement write logic here
    }

    [System.Boolean]Terminate() {
        # Implement termination logic here 
        if ($null -ne $this.reader) {
            $this.reader.Close()
        }
        $this.command.Dispose()

        $this.connection.Close()
        $this.connection.Dispose()

        return $true
    }
}
