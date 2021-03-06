Function Write-Log {
    param
    (

        [Parameter()]
        [string] $Log,

        [Parameter()]
        [string] $AddToLog

    )

    Add-Content -Path $Log -Value $AddToLog
}

<# future Write-Log Function

function Write-Log {
    param (
        [String]$Message,
        [ValidateSet("Success", "Failed", "Information" )]
        [String]$Status = "Information"
    )
    $_ESC = "$([char]27)"
    $_FG = "$_ESC[38;5"
    $_BG = "$_ESC[48;5"
    $_Yellow = "$([char]27)[38;5;11m"
    $_White = "$([char]27)[38;5;3m"
    $_Red = "$([char]27)[38;5;1m"
    $_Green = "$([char]27)[38;5;2m"

    switch ($Status) {
        "Success" { $Color = $_Green }
        "Failed" { $Color = $_Red }
        Default { $Color = $_White }
    }

    $TimeStamp = "${_Yellow}[${_White}{0}${_Yellow}]${_Yellow}[${Color}{1}${_Yellow}]: ${Color}{2}" -f (Get-Date).ToString("HH:mm:ss"), $Status, $Message
    Write-host $TimeStamp
}

Write-Log -Message "Failure Message" -Status Failed
Write-Log -Message "Success Message" -Status Success
Write-Log -Message "Information Message"


#>