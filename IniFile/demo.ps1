Import-Module -Name "$(get-location)\IniFile"

$ini = @{}
$ini = Import-IniFile -File "demo.ini"

"INI"
"#######################################################"
"Computer Instance : " + $ini.COMPUTER.SQLINSTANCE
"Database Name     : " + $ini.DATABASE.NAME
"Backup Operator   : " + $ini.OPERATORS.BACKUP
"Mail Domain       : " + $ini.MAIL.DOMAIN
"#######################################################"

$ini = $null

Remove-Module -Name IniFile