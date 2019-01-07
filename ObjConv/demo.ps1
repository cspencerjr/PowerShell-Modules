Import-Module -Name "$(get-location)\ObjConv"

$json = @{}
$json = Get-Content -Path "demo.json" | ConvertFrom-Json | ConvertTo-Hashtable

"JSON"
"#######################################################"
"Computer Instance : " + $json.COMPUTER.SQLINSTANCE
"Database Name     : " + $json.DATABASE.NAME
"Backup Operator   : " + $json.OPERATORS.BACKUP
"Mail Domain       : " + $json.MAIL.DOMAIN
"Create Database   : " + $json.SCRIPTS.DATABASE[0]
"Create Schema     : " + $json.SCRIPTS.SCHEMA[0]
"Remove Database   : " + $json.SCRIPTS.DATABASE[1]
"Path for Data     : " + $json.SCRIPTS.PARAMETERS."createdb.sql".DATAPATH
"#######################################################"

$json = $null

Remove-Module -Name ObjConv