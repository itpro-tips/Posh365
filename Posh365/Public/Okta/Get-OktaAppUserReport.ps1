function Get-OktaAppUserReport {

    Param (
        [Parameter()]
        [string] $SearchString,
            
        [Parameter()]
        [string] $Filter,

        [Parameter()]
        [string] $Id
    )
    $Url = $OKTACredential.GetNetworkCredential().username
    $Token = $OKTACredential.GetNetworkCredential().Password

    $Headers = @{
        "Authorization" = "SSWS $Token"
        "Accept"        = "application/json"
        "Content-Type"  = "application/json"
    }

    if (-not $Filter -and (-not $SearchString) -and (-not $Id)) {
        $RestSplat = @{
            Uri     = "https://$Url.okta.com/api/v1/users/"
            Headers = $Headers
            Method  = 'Get'
        }
    }

    if ($id) {
        $RestSplat = @{
            Uri     = 'https://{0}.okta.com/api/v1/users/?filter=id eq "{1}"' -f $Url, $id
            Headers = $Headers
            Method  = 'Get'
        }
    }

    if ($SearchString) {
        $RestSplat = @{
            Uri     = "https://$Url.okta.com/api/v1/users/?q=$SearchString"
            Headers = $Headers
            Method  = 'Get'
        }
    }

    $User = Invoke-RestMethod @RestSplat

    foreach ($CurUser in $User) {
        $Id = $CurUser.Id
        $FirstName = $CurUser.Profile.FirstName
        $LastName = $CurUser.Profile.LastName
        $Login = $CurUser.Profile.Login
        $Email = $CurUser.Profile.Email
        
        $RestSplat = @{
            Uri     = 'https://{0}.okta.com/api/v1/apps?filter=user.id+eq+"{1}"' -f $Url, $Id
            Headers = $Headers
            Method  = 'Get'
        }

        $AppsInUser = Invoke-RestMethod @RestSplat

        foreach ($App in $AppsInUser) {
            [pscustomobject]@{
                FirstName     = $FirstName
                LastName      = $LastName
                Login         = $Login
                Email         = $Email
                AppName       = $App.Name
                AppStatus     = $App.Status
                AppSignOnMode = $App.SignOnMode
            }
        }
    }
}