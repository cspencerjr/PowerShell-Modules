Import-Module -Name "$(get-location)\MiscSec"

$SecureString = ConvertTo-SecureString -String "this is a test!" -AsPlainText -Force
"Secure String  = " + $SecureString

$String = ConvertTo-UnencryptedString -SecureString $SecureString
"Unecrypted String = " + $String

Remove-Module -Name MiscSec
