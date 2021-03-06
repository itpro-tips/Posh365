#
# Module manifest for module 'Posh365'
#
# Generated by: Kevin Blumenfeld
#
# Generated on: 10/27/2017
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule         = '.\Posh365.psm1'

    # Version number of this module.
    ModuleVersion      = '0.9.2.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID               = '40a79250-811a-441c-b871-7edbc8d6b9ef'

    # Author of this module
    Author             = 'Kevin Blumenfeld'

    # Company or vendor of this module
    # CompanyName = ''

    # Copyright statement for this module
    Copyright          = '(c) 2018 Kevin Blumenfeld. All rights reserved. MIT License.'

    # Description of the functionality provided by this module
    Description        = 'Connect. Provision. Migrate. Maintain.

Toolbox for Office 365 Environments.

https://github.com/kevinblumenfeld/Posh365
'

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @('')

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @('Private\DLL\Microsoft.SharePoint.Client.dll', 'Private\DLL\Microsoft.SharePoint.Client.Runtime.dll')

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport  = @(
        'Add-365RecipientEmailAddresses'
        'Add-ConnectionFilterPolicyDetail'
        'Add-ContentFilterPolicyDetail'
        'Add-Task'
        'Add-TaskByMinute'
        'Add-TaskDaily'
        'Add-TaskWeekly'
        'Add-TransportRuleDetail'
        'Clear-SFBAttribute'
        'Compare-Csv'
        'Compare-List'
        'Connect-Cloud'
        'Connect-Exchange'
        'Connect-Graph'
        'Connect-OktaSecure'
        'ConvertTo-Shared'
        'Disable-Employee'
        'Export-AndImportUnifiedGroups'
        'Export-CsvData'
        'Export-CsvDataForGroups'
        'Export-CsvJoinedData'
        'Export-QCsvData'
        'Get-365Info'
        'Get-365MobileDevice'
        'Get-365MsolGroup'
        'Get-365MsolUser'
        'Get-365Recipient'
        'Get-365RecipientEmailAddresses'
        'Get-ActiveDirectoryContact'
        'Get-ActiveDirectoryGroup'
        'Get-ActiveDirectoryObject'
        'Get-ActiveDirectoryUser'
        'Get-ActiveDirectoryUserFiltered'
        'Get-ADReplication'
        'Get-AuditLog'
        'Get-CloudLicense'
        'Get-Cred'
        'Get-DGPerms'
        'Get-DGSendAsPerms'
        'Get-DiscoveryInfo'
        'Get-DistributionGroupMembers'
        'Get-DistributionGroupMembersHash'
        'Get-DistributionGroupMembership'
        'Get-DistributionGroupMembershipHash'
        'Get-EdiscoveryCase'
        'Get-ExchangeDistributionGroup'
        'Get-ExchangeMailbox'
        'Get-ExchangeReceiveConnector'
        'Get-EXODGPerms'
        'Get-EXOFullAccessPerms'
        'Get-EXOFullAccessRecursePerms'
        'Get-EXOGroup'
        'Get-EXOMailbox'
        'Get-EXOMailboxPerms'
        'Get-EXOMailboxRecursePerms'
        'Get-EXOMailContact'
        'Get-EXOMigrationStatistics'
        'Get-EXOMoveRequestStatistics'
        'Get-EXOResourceMailbox'
        'Get-EXOSendAsPerms'
        'Get-EXOSendAsRecursePerms'
        'Get-EXOSendOnBehalfPerms'
        'Get-EXOSendOnBehalfRecursePerms'
        'Get-FullAccessPerms'
        'Get-GraphMailFolder'
        'Get-GraphMailFolderPathId'
        'Get-GraphMailMessage'
        'Get-GraphUser'
        'Get-GraphUserAll'
        'Get-MailboxPerms'
        'Get-MfaStats'
        'Get-MigrationChain'
        'Get-ModifiedMailboxItem'
        'Get-OktaAppGroupReport'
        'Get-OktaAppReport'
        'Get-OktaDiscovery'
        'Get-OktaGroupMemberReport'
        'Get-OktaGroupMembership'
        'Get-OktaGroupReport'
        'Get-OktaGroupUserMembershipReport'
        'Get-OktaPolicyReport'
        'Get-OktaUserAppReport'
        'Get-OktaUserGroupMembershipReport'
        'Get-OktaUserReport'
        'Get-OneDriveReport'
        'Get-PermissionChain'
        'Get-RetentionLinks'
        'Get-SendAsPerms'
        'Get-SendOnBehalfPerms'
        'Get-SPN'
        'Get-SPOWeb'
        'Get-VirtualDirectoryInfo'
        'Grant-FullAccessToMailbox'
        'Grant-OneDriveAdminAccess'
        'Import-365MsolUser'
        'Import-365UnifiedGroup'
        'Import-ActiveDirectoryGroupMember'
        'Import-ADData'
        'Import-ADGroupProxyAddress'
        'Import-ADUserProxyAddress'
        'Import-AzureADProperty'
        'Import-AzureADUser'
        'Import-ExchangeFolderPermission'
        'Import-ExchangeFullAccess'
        'Import-ExchangeSendAs'
        'Import-ExchangeSendOnBehalf'
        'Import-EXOGroup'
        'Import-EXOGroupPermissions'
        'Import-EXOMailboxPermissions'
        'Import-EXOResourceMailboxSettings'
        'Import-GoogleTo365Group'
        'Import-GoogleToEXOGroup'
        'Import-GoogleToEXOGroupMember'
        'Import-MoveRequest'
        'Import-MsolProperty'
        'New-ActiveDirectoryGroup'
        'New-ActiveDirectoryUser'
        'New-EXOMailTransportRuleReport'
        'New-EXOMessageTrace'
        'New-HybridMailbox'
        'New-MessageTrack'
        'New-PreFlightTemplate'
        'Remove-365Domain'
        'Remove-OfficeLicense'
        'Remove-OktaGroup'
        'Remove-OktaUser'
        'Remove-OktaUserfromApp'
        'Rename-SamAccount'
        'Rename-User'
        'Select-ADConnectServer'
        'Select-DisplayNameFormat'
        'Select-DomainController'
        'Select-ExchangeServer'
        'Select-Options'
        'Select-SamAccountNameOptions'
        'Select-TargetAddressSuffix'
        'Set-CloudLicense'
        'Switch-AddressDomain'
        'Switch-PrimarySmtp'
        'Sync-AD'
        'Sync-ADConnect'
        'Test-PreCheck'
        'Test-PreFlightCloud'
        'Test-PreFlightOnPrem'
        'Write-HostLog'
        'Write-HostProgress'
        'Write-Log'

    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport    = @()

    # Variables to export from this module
    VariablesToExport  = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport    = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData        = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @("Office", "365", "365Tools", "365Admin", "Posh", "365", "Connect", "Provision", "Active", "Directory", "OKTA")

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/kevinblumenfeld/Posh365'

            # A URL to an icon representing this module.
            IconUri    = 'https://user-images.githubusercontent.com/28877715/32844235-da22a2f4-c9ef-11e7-96ba-b4ef11de9362.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

