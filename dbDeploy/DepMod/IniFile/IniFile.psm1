##############################################################################
# Author:       Charles Spencer Jr.
# Create date:  08/29/2018
# Description:  Powershell Module
# Version:      0.0.1
##############################################################################

function Import-IniFile {
    <#
    .SYNOPSIS
    Read in a windows .INI file and store it in a hashtable.
    
    .DESCRIPTION
    Read in a windows .INI file and store it in a hashtable.
    
    .PARAMETER File
    Windows .INI file to process.
    
    .EXAMPLE
    PS C:\>$data = Imnport-IniFile -File "demo.ini"
    
    .NOTES
    Pretty simple converter function to convert data from a windows ini file 
    to hashtable for parsing.
    
    Based on the method provided on Microsoft's blog from the Scripting Guys.

    .LINK
    https://blogs.technet.microsoft.com/heyscriptingguy/2011/08/20/use-powershell-to-work-with-any-ini-file/

    #>

    [CmdletBinding()]
    param (
        [parameter(
            Mandatory = $true, 
            Position = 0
        )]
        [string[]]$File
    )
    
    begin {
        [string]$Section = $null
        $Hashtable = [ordered]@{}
        
        $Section = "NO_SECTION"
        $Hashtable[$Section] = [ordered]@{}
    }

    process {
        switch -regex -File $File {
            "^\[(.+)\]$" {
                $Section = $Matches[1].Trim()
                $Hashtable[$Section] = [ordered]@{}
            }
            "^\s*([^#].+?)\s*=\s*(.*)" {
                $Key, $Value = $Matches[1..2]
                if (!($Key.StartsWith(";"))) {
                    $Hashtable[$Section][$Key] = $Value.Trim()
                }
            }
        } 
    }

    end {
        if ($Hashtable.NO_SECTION.Count -eq 0) {
            $Hashtable.Remove("NO_SECTION")
        }

        $Hashtable
    }
}