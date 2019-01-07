# =============================================================================
# Author:       Charles Spencer Jr.
# Create date:  11/12/17
# Update date:  03/04/18
# Description:  Powershell Module Security
# Version:      0.0.2
# =============================================================================

function ConvertTo-UnencryptedString {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SecureString]$SecureString
    )    

    begin {
        [string]$PlainTextString = $null
    }

    process {
        [System.IntPtr]$BinaryString = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
        $PlainTextString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BinaryString)
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BinaryString)

        $PlainTextString
    }
}

