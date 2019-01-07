##############################################################################
# Author:       Chuck Spencer Jr.
# Create date:  11/12/17
# Update date:  03/03/18
# Description:  Powershell Module
# Version:      0.0.2
##############################################################################

function Connect-IrcServer {
    
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [string]$ComputerName, 
        [parameter(Mandatory = $true, Position = 1)]
        [int32]$PortNumber
    ) 

    begin {
        $Session = @{}  
        $Client = New-Object Net.Sockets.TcpClient
    }

    process {
        $Client.Connect($ComputerName, $PortNumber)         

        [Net.Sockets.NetworkStream]$NetStream = $Client.GetStream()
        [IO.StreamWriter]$Writer = 
            new-object IO.StreamWriter($NetStream, [Text.Encoding]::ASCII)
        [IO.StreamReader]$Reader = 
            new-object IO.StreamReader($NetStream, [Text.Encoding]::ASCII)
        
        $Session.Client    = $Client
        $Session.Netstream = $NetStream
        $Session.Writer    = $Writer
        $Session.Reader    = $Reader    

        $Session       
    }
}

function Disconnect-IrcServer {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session
    ) 

    process {
        $Session.Client.Close()
        $Session = $null
    }   
}

function Send-IrcMessage {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session, 
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Message
    ) 

    process {
        $Session.Writer.WriteLine($Message)
        $Session.Writer.Flush()
    }
}

function Read-IrcMessage {
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session
    ) 

    begin {
        [string]$Message = ""
    }

    process {
        $Message  = $Session.Reader.readline()
        $Message
    }
}

function Connect-IrcChannel {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session, 
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Username, 
        [parameter(Mandatory = $true, Position = 2)]
        [SecureString]$Password, 
        [parameter(Mandatory = $true, Position = 3)]
        [string]$Nickname, 
        [parameter(Mandatory = $true, Position = 4)]
        [string]$Realname, 
        [parameter(Mandatory = $true, Position = 5)]
        [string]$Channel
    )

    process {
        [System.IntPtr]$binPassword = 
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
        [string]$strPassword = 
            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($binPassword)

        Send-IrcMessage $Session "PASS $($strPassword)"
        Send-IrcMessage $Session "NICK $($Nickname)"
        Send-IrcMessage $Session "USER $($Username) 8 * :$($Realname)"
        Send-IrcMessage $Session "JOIN $($Channel)"
    }
}

function Disconnect-IrcChannel {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session, 
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Channel
    ) 

    process {
        Send-IrcMessage $Session "PART $($Channel)"
        Send-IrcMessage $Session "QUIT :bye bye"
    }
}

function Send-IrcPrivMsg {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session, 
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Channel, 
        [parameter(Mandatory = $true, Position = 2)]
        [string]$Message
    )

    process {
        $Message = $Message.Trimend()
        if (($Message -ne "") -and ($Message -ne $null)) {
            Send-IrcMessage $Session "PRIVMSG $($Channel) :$($Message)"   
        }         
    }
}

function Send-IrcNotice {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [array]$Session, 
        [parameter(Mandatory = $true, Position = 1)]
        [string]$Channel, 
        [parameter(Mandatory = $true, Position = 2)]
        [string]$Message
    )

    process {
        $Message = $Message.Trimend()
        if (($Message -ne "") -and ($Message -ne $null)) { 
            Send-IrcMessage $Session "NOTICE $($Channel) :$($Message)"    
        }
    }
}
