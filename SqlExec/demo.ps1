Import-Module -Name "$(get-location)\SqlExec"

$PasswordParam = @{
    String      = 'Yasstb0x'
    AsPlainText = $true;
    Force       = $true;
}

$ConnectParams = @{
    ComputerName = 'localhost';
    UserName     = 'sa';
    Password     = ConvertTo-SecureString @PasswordParam
}

$Connection = Connect-SqlInstance @ConnectParams

Invoke-SqlScript -Connection $Connection -Path "demo.sql"

Invoke-SqlQuery -Connection $Connection -Query "select * from master.dbo.sysdatabases"

if ($Connection) {
    Disconnect-SqlInstance -Connection $connection
}

Remove-Module -Name sqlExec
