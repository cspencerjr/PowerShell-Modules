##############################################################################
# Author:       Chuck Spencer Jr.
# Create date:  11/12/17
# Update date:  03/04/18
# Description:  Powershell Module
# Version:      0.0.2
##############################################################################

function Send-HCRoomNotification {
    
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true,  Position = 0)]
        [System.String[]] $ApiToken, 
        [parameter(Mandatory = $true,  Position = 1)]
        [System.Int32] $RoomId, 
        [parameter(Mandatory = $true,  Position = 2)]
        [System.String[]] $Message, 
        [parameter(Mandatory = $false, Position = 3)]
        [ValidateSet("html", "text")]
        [System.String[]] $MessageFormat,
        [parameter(Mandatory = $false, Position = 4)]
        [System.Boolean] $Notify,
        [parameter(Mandatory = $false, Position = 5)]
        [ValidateSet("yellow", "red", "green", "purple", "gray", "random")]
        [System.String[]] $Color 
    )
    
    process {
        $Url = "https://api.hipchat.com/v2/room/$RoomId/notification?auth_token=$ApiToken"

        $postStr = "message=$Message"

        if ($Color) { $postStr += "&color=$Color" }

        if ($Notify) { $postStr += "&notify=$Notify" }

        if ($MessageFormat) { $postStr += "&message_format=$MessageFormat" }

        $webRequest = [System.Net.WebRequest]::Create($Url)
        $webRequest.ContentType = "application/x-www-form-urlencoded"

        $Post = [System.Text.Encoding]::UTF8.GetBytes($postStr)

        $webRequest.ContentLength = $Post.Length
        $webRequest.Method = "POST"

        $requestStream = $webRequest.GetRequestStream()
        $requestStream.Write($Post, 0, $Post.length)
        $requestStream.Close()

        [System.Net.WebResponse] $webResponse = $webRequest.GetResponse()
        $responseStream = $webResponse.GetResponseStream()

        $webResponse.Close() 
        $responseStream.Close()
    }
}
