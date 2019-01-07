##############################################################################
# Author:       Chuck Spencer Jr.
# Create date:  11/12/17
# Update date:  03/04/18
# Description:  Powershell Module
# Version:      0.0.2
##############################################################################

function Connect-SqlInstance {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [string]$ComputerName, 
        [parameter(Mandatory = $false, Position = 1)]
        [string]$DatabaseName = "master", 
        [parameter(Mandatory = $false, Position = 2)]
        [string]$UserName,
        [parameter(Mandatory = $false, Position = 3)]
        [SecureString]$Password
    ) 

    begin {
        $Connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
        [string]$ConnString = $null
        [string]$SqlPassword = $null
    } 

    process {
        $ConnString = "Server=$($ComputerName);Database=$($DatabaseName);"
        if (
            ($UserName -eq $null) -or 
            ($UserName -eq "") -or 
            ($Password -eq $null) -or 
            ($Password -eq "") 
        ) {
            $ConnString += "Integrated Security=SSPI;"
        }
        else {
            [System.IntPtr]$BinaryString = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
            $SqlPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BinaryString)
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BinaryString);

            $ConnString += "User=$($UserName);PWD=$($SqlPassword);"
        } 
        $Connection.ConnectionString = $ConnString 
        try {
            $Connection.Open()
        }
        catch {
            $Connection = $null
        }

        $Connection
    } 
} 

function Disconnect-SqlInstance {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [System.Data.SqlClient.SqlConnection]$Connection
    ) 

    process {
        [System.Data.SqlClient.SqlConnection]::ClearPool($Connection)         
        $Connection.Close()
    } 
}

function Invoke-SqlScript {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [System.Data.SqlClient.SqlConnection]$Connection,
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Path,
        [parameter(Mandatory = $false, Position = 2)]
        [string]$DatabaseName = $null,
        [parameter(Mandatory = $false, Position = 3)]
        [hashtable]$ParamList
    ) 

    begin {
        $Command = New-Object -TypeName System.Data.SqlClient.SqlCommand
    } 

    process {
        $ScriptContent = Get-Content -Path $Path
        $SQLText = Out-String -InputObject ($ScriptContent)

        if (($ParamList -ne $null) -and ($ParamList.Count -gt 0)) {
            foreach ($Param in $ParamList.GetEnumerator()) {
                $Name = $Param.Key
                $Value = $Param.Value
                $SQLText = $SQLText -replace "\$\($($Name)\)", $Value
            } 
        }         

        $SQLText = $SQLText -replace "(\s+GO(\s+|$))", "`n"

        $Command.CommandText = $SQLText

        if (($DatabaseName -ne $null) -and ($DatabaseName -ne "")) {
            $Connection.ChangeDatabase($DatabaseName)
        }

        $Command.Connection = $Connection;

        $Return = $Command.ExecuteNonQuery()

        if ($Return -eq -1) {
            $Return = 0
        } 

        $Command = $null

        $Return
    } 
} 

function Invoke-SqlQuery {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [System.Data.SqlClient.SqlConnection]$Connection,
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Query,
        [parameter(Mandatory = $false, Position = 2)]
        [string]$DatabaseName   
    ) 

    begin {
        $Command = New-Object -TypeName System.Data.SqlClient.SqlCommand
        $Rows = @()
    } 

    process {
        $Command.CommandText = $Query;
        
        if (($DatabaseName -ne $null) -and ($DatabaseName -ne "")) {
            $Connection.ChangeDatabase($DatabaseName)
        }
        
        $Command.Connection = $Connection

        $RecordSet = $Command.ExecuteReader()

        while ($RecordSet.Read()) {
            $Rows += $RecordSet[0]
        } 

        $RecordSet.Close()

        $Rows
    } 
}
