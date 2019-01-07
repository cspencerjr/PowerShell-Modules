##############################################################################
# Author:       Charles Spencer Jr.
# Create date:  03/06/18
# Description:  Powershell Module
# Version:      1.0
##############################################################################

function ConvertTo-Hashtable {
    <#
    .SYNOPSIS
    Convert a PSObject to a Hashtable.
    
    .DESCRIPTION
    Convert a PSObject to a Hashtable for parsing.
    
    .PARAMETER InputObject
    A PSObject.

    .EXAMPLE
    PS C:\>$json = Get-Content -Path "example.json" | ConvertFrom-Json | ConvertTo-Hashtable

    .EXAMPLE
    PS C:\>$content = Get-Content -Path "example.json" | ConvertFrom-Json
    PS C:\>$json = ConvertTo-Hashtable -InputObject $content

    .EXAMPLE
    PS C:\>$json = Get-Content -Path "example.json" | ConvertFrom-Json | ConvertTo-Hashtable

    .NOTES
    A simple recusion function to take a PSObject and convert it to a hashtable 
    for parsing.

    #>

    [CmdletBinding()]
    param (
        [parameter(
            Mandatory = $true, 
            Position = 0, 
            ValueFromPipeline = $true
        )]
        $InputObject
    )

    begin {
        $Hashtable = [ordered]@{}
    }

    process {
        if ($InputObject -is [PSObject]) {
            foreach ($Property in $InputObject.PSObject.Properties) {
                $Hashtable[$Property.Name] = 
                (ConvertTo-Hashtable -InputObject $Property.Value)
            }
        }
        else {
            $Hashtable = $InputObject
        }
    }

    end {
        $Hashtable
    }
}