function Get-OktaAppReport {

    Param (

    )
    $Url = $OKTACredential.GetNetworkCredential().username
    $Token = $OKTACredential.GetNetworkCredential().Password

    $Headers = @{
        "Authorization" = "SSWS $Token"
        "Accept"        = "application/json"
        "Content-Type"  = "application/json"
    }
    
    $RestSplat = @{
        Uri     = "https://$Url.okta.com/api/v1/apps/"
        Headers = $Headers
        Method  = 'Get'
    }

    $App = Invoke-RestMethod @RestSplat

    foreach ($CurApp in $App) {

        $Id = $CurApp.Id
        $Accessibility = ($CurApp).Accessibility
        $Visibility = ($CurApp).Visibility
        $Credentials = ($CurApp).Credentials
        $Features = ($CurApp).Features
        $Settings = ($CurApp).Settings

        [PSCustomObject]@{
            Name                 = $CurApp.Name
            Label                = $CurApp.Label
            Status               = $CurApp.Status
            SignOnMode           = $CurApp.SignOnMode
            TenantType           = $Settings.app.tenantType
            Domain               = $Settings.app.domain
            MsftTenant           = $Settings.app.msftTenant
            CustomDomain         = $Settings.app.customDomain
            FilterGroupsByOU     = $Settings.app.filterGroupsByOU
            Created              = $CurApp.Created
            LastUpdated          = $CurApp.LastUpdated
            Activated            = $CurApp.Activated
            UserNameTemplate     = $Credentials.UserNameTemplate.Template
            UserNameTemplateType = $Credentials.UserNameTemplate.Type
            CredentialScheme     = $Credentials.Scheme
            AppId                = $Id
            Features             = ($Features -join (';'))            
        }

    }
    
}