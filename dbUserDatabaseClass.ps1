# 他のユーザーデータベースを管理するクラス
# 別のURL Databaseからのデータをコピーする機能

class dbUserDatabase {
    [string]$ConnectionString = $null

    # Constructor to initialize the database connection
    dbUserDatabase([string]$connectionString) {
        # Initialize the database connection
        $this.ConnectionString = $connectionString
        $this.connection = New-Object System.Data.Odbc.OdbcConnection($connectionString)
        $this.connection.Open()
    }



}
