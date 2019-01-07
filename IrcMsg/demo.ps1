Import-Module -Name "$(get-location)\modules\ircMsg"

$Session = Connect-IrcServer -ComputerName "localhost" -PortNumber 6667

$Password = ConvertTo-SecureString -String "ircbot" -AsPlainText -Force

$Channel = "#ircbot"

$Connection = @{
    Nickname     = "IrcBot";
    Username     = "IrcBot";
    Password     = $Password;
    Realname     = "IrcBot";
    Channel      = "#ircbot";
}

Connect-IrcChannel -Session $Session @Connection

do {
    $Command  = Read-IrcMessage -Session $Session
    write-output $Command
} while( $Command.Contains("366") -eq $false )

$Message = "Something to send next and again!"
Send-IrcPrivMsg -Session $Session -Channel $Channel -Message $Message

$Notice = "This is a notice of some kind!"
Send-IrcNotice -Session $Session -Channel $Channel -Message $Notice

Disconnect-IrcChannel -Session $Session -Channel $Channel
Disconnect-IrcServer -Session $Session

Remove-Module ircMsg

