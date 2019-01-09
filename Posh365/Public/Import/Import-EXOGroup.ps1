function Import-EXOGroup { 
    <#
    .SYNOPSIS
    Import Office 365 Distribution Groups
    
    .DESCRIPTION
    Import Office 365 Distribution Groups
    
    .PARAMETER Groups
    Groups and attributes to create. These group have to be imported from the pipeline through Import-CSV
    
	.PARAMETER CSVExportedFromExchangeOnPrem
    If the CSV is an Export of Distribution Group in Exchange On-premise/Active Directory (with Get-ExchangeDistributionGroup.ps1)
	
	.PARAMETER NewDomain
	Change the SMTP Domain
	
	.PARAMETER OldDomain
	Change the SMTP Domain
	
	.PARAMETER CreateEmptyGroups
	Create the groups without its members
	
	.PARAMETER UpdateMembersOnly
	Update the membership of the groups (not delete the existing members). The not existing distribution groups  will be NOT created
	
	.PARAMETER ReplaceMembersOnly
	DELETE ALL THE EXISTING MEMBERS and add only the users from this import. The not existing distribution groups  will be NOT created
	
    .EXAMPLE
    Import-Csv .\AllGroupsExport.csv -Encoding UTF8| Import-EXOGroup

	.EXAMPLE
	Import-Csv .\AllGroupsExport.csv -Encoding UTF8| Import-EXOGroup -CSVExportedFromExchangeOnPrem:$true
	
	.EXAMPLE
	Import-Csv .\AllGroupsExport.csv -Encoding UTF8 | Import-EXOGroup -CSVExportedFromExchangeOnPrem:$true -OldDomain olddomain.com -NewDomain newdomain.com
    #>

    [CmdletBinding()]
    Param 
    (
        [Parameter(Mandatory = $true,
		ValueFromPipeline = $true)]
        $Groups,
		[Parameter(Mandatory = $false)]
        [switch]$CSVExportedFromExchangeOnPrem,
		[Parameter(Mandatory=$false)]
		[string]$NewDomain,
		[Parameter(Mandatory=$false)]
		[string]$OldDomain,
		[Parameter(Mandatory=$false)]
		[switch]$CreateEmptyGroups=$false,
		[Parameter(Mandatory=$false)]
		[switch]$UpdateMembersOnly,
		[Parameter(Mandatory=$false)]
		[switch]$ReplaceMembersOnly
    )
    Begin {
		if ($OldDomain -and (! $NewDomain)) {
            Write-Warning "Must use NewDomain parameter when specifying OldDomain parameter"
            break
        }
        if ($NewDomain -and (! $OldDomain)) {
            Write-Warning "Must use OldDomain parameter when specifying NewDomain parameter"
            break
        }
		if ($UpdateMembersOnly -and $ReplaceMembersOnly) {
            Write-Warning "Must use UpdateMembersOnly without ReplaceMembersOnly"
            break
        }

		if ($CreateEmptyGroups -and ($UpdateMembersOnly -or $ReplaceMembersOnly)) {
            Write-Warning "Must use CreateEmptyGroups without UpdateMembersOnly or ReplaceMembersOnly"
            break
        }
		
    }
    Process {
        ForEach ($CurGroup in $Groups) {

            if($NewDomain){
                $CurGroup.PrimarySmtpAddress = $CurGroup.PrimarySmtpAddress.Replace("@$olddomain","@$newDomain")
				$CurGroup.EmailAddresses = $CurGroup.EmailAddresses.Replace("@$olddomain","@$newDomain")
				$CurGroup.membersSMTP = $CurGroup.membersSMTP.Replace("@$olddomain","@$newDomain")
				$CurGroup.WindowsEmailAddress = $CurGroup.WindowsEmailAddress.Replace("@$olddomain","@$newDomain")
            }
            # if CSV from Exchange on-premise, Identity is the canonicalName but Exchange Online didn't know that but only SMTP Address
            if($CSVExportedFromExchangeOnPrem)
            {
                $CurGroup.Identity = $CurGroup.PrimarySmtpAddress
            }

            $newhash = @{
                Alias                              = $CurGroup.Alias
                BypassNestedModerationEnabled      = if($CurGroup.BypassNestedModerationEnabled){[bool]::Parse($CurGroup.BypassNestedModerationEnabled)};
                DisplayName                        = $CurGroup.DisplayName
                IgnoreNamingPolicy                 = $CurGroup.IgnoreNamingPolicy
                MemberDepartRestriction            = $CurGroup.MemberDepartRestriction
                MemberJoinRestriction              = $CurGroup.MemberJoinRestriction
                ModerationEnabled                  = if($CurGroup.ModerationEnabled){[bool]::Parse($CurGroup.ModerationEnabled)};
                Name                               = $CurGroup.Name
                Notes                              = $CurGroup.Notes
                PrimarySmtpAddress                 = $CurGroup.PrimarySmtpAddress
                RequireSenderAuthenticationEnabled = if($CurGroup.RequireSenderAuthenticationEnabled){[bool]::Parse($CurGroup.RequireSenderAuthenticationEnabled)};
                SendModerationNotifications        = $CurGroup.SendModerationNotifications
            }            
            $sethash = @{
                CustomAttribute1                  = $CurGroup.CustomAttribute1
                CustomAttribute10                 = $CurGroup.CustomAttribute10
                CustomAttribute11                 = $CurGroup.CustomAttribute11
                CustomAttribute12                 = $CurGroup.CustomAttribute12
                CustomAttribute13                 = $CurGroup.CustomAttribute13
                CustomAttribute14                 = $CurGroup.CustomAttribute14
                CustomAttribute15                 = $CurGroup.CustomAttribute15
                CustomAttribute2                  = $CurGroup.CustomAttribute2
                CustomAttribute3                  = $CurGroup.CustomAttribute3
                CustomAttribute4                  = $CurGroup.CustomAttribute4
                CustomAttribute5                  = $CurGroup.CustomAttribute5
                CustomAttribute6                  = $CurGroup.CustomAttribute6
                CustomAttribute7                  = $CurGroup.CustomAttribute7
                CustomAttribute8                  = $CurGroup.CustomAttribute8
                CustomAttribute9                  = $CurGroup.CustomAttribute9
                HiddenFromAddressListsEnabled     = if($CurGroup.HiddenFromAddressListsEnabled){[bool]::Parse($CurGroup.HiddenFromAddressListsEnabled)};
                Identity                          = $CurGroup.Identity
                ReportToManagerEnabled            = if($CurGroup.ReportToManagerEnabled){[bool]::Parse($CurGroup.ReportToManagerEnabled)};
                ReportToOriginatorEnabled         = if($CurGroup.ReportToOriginatorEnabled){[bool]::Parse($CurGroup.ReportToOriginatorEnabled)};
                SendOofMessageToOriginatorEnabled = if($CurGroup.SendOofMessageToOriginatorEnabled){[bool]::Parse($CurGroup.SendOofMessageToOriginatorEnabled)};
                SimpleDisplayName                 = $CurGroup.SimpleDisplayName
                WindowsEmailAddress               = $CurGroup.WindowsEmailAddress

            }
            $newparams = @{}
            ForEach ($h in $newhash.keys) {
                if ($($newhash.item($h))) {
                    $newparams.add($h, $($newhash.item($h)))
                }
				# -eq $False because otherwise if the Value is 'False' in text in the CSV, it doesn't go to the if
				elseif($newhash.item($h) -eq $False)
				{
					$newparams.add($h, $($newhash.item($h)))
				}
            }
            $setparams = @{}
            ForEach ($h in $sethash.keys) {
                if ($($sethash.item($h))) {
                    $setparams.add($h, $($sethash.item($h)))
                }
            }
            $type = $CurGroup.RecipientTypeDetails

            switch ( $type ) {
                MailUniversalDistributionGroup {
                    $newparams['Type'] = "Distribution"
                    break
                }
                MailNonUniversalGroup {
                    $newparams['Type'] = "Distribution"
                    break
                }
                MailUniversalSecurityGroup {
                    $newparams['Type'] = "Security"
                    break
                }
                RoomList {
                    $newparams['Roomlist'] = $true
                    break
                }
            }
			if(-not ($ReplaceMembersOnly -or $UpdateMembersOnly))
            {
				New-DistributionGroup @newparams
				Set-DistributionGroup @setparams
			
				if ($CurGroup.AcceptMessagesOnlyFrom) {
					$CurGroup.AcceptMessagesOnlyFrom -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -AcceptMessagesOnlyFrom @{Add = "$_"}
					}
				}
				if ($CurGroup.AcceptMessagesOnlyFromDLMembers) {
					$CurGroup.AcceptMessagesOnlyFromDLMembers -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -AcceptMessagesOnlyFromDLMembers @{Add = "$_"}
					}
				}
				if ($CurGroup.BypassModerationFromSendersOrMembers) {
					$CurGroup.BypassModerationFromSendersOrMembers -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -BypassModerationFromSendersOrMembers @{Add = "$_"}
					}
				}
				if ($CurGroup.GrantSendOnBehalfTo) {
					$CurGroup.GrantSendOnBehalfTo -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -GrantSendOnBehalfTo @{Add = "$_"}
					}
				}
				if ($CurGroup.ManagedBy) {
					$CurGroup.ManagedBy -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ManagedBy @{Add = "$_"}
					}
				}
				if ($CurGroup.ModeratedBy) {
					$CurGroup.ModeratedBy -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ModeratedBy @{Add = "$_"}
					}
				}
				if ($CurGroup.RejectMessagesFrom) {
					$CurGroup.RejectMessagesFrom -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -RejectMessagesFrom @{Add = "$_"}
					}
				}
				if ($CurGroup.RejectMessagesFromDLMembers) {
					$CurGroup.RejectMessagesFromDLMembers -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -RejectMessagesFromDLMembers @{Add = "$_"}
					}
				}
				if ($CurGroup.RejectMessagesFromSendersOrMembers) {
					$CurGroup.RejectMessagesFromSendersOrMembers -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -RejectMessagesFromSendersOrMembers @{Add = "$_"}
					}
				}
				if ($CurGroup.ExtensionCustomAttribute1) {
					$CurGroup.ExtensionCustomAttribute1 -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ExtensionCustomAttribute1 @{Add = "$_"}
					}
				}
				if ($CurGroup.ExtensionCustomAttribute2) {
					$CurGroup.ExtensionCustomAttribute2 -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ExtensionCustomAttribute2 @{Add = "$_"}
					}
				}
				if ($CurGroup.ExtensionCustomAttribute3) {
					$CurGroup.ExtensionCustomAttribute3 -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ExtensionCustomAttribute3 @{Add = "$_"}
					}
				}
				if ($CurGroup.ExtensionCustomAttribute4) {
					$CurGroup.ExtensionCustomAttribute4 -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ExtensionCustomAttribute4 @{Add = "$_"}
					}
				}
				if ($CurGroup.ExtensionCustomAttribute5) {
					$CurGroup.ExtensionCustomAttribute5 -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -ExtensionCustomAttribute5 @{Add = "$_"}
					}
				}
				if ($CurGroup.MailTipTranslations) {
					$CurGroup.MailTipTranslations -Split ";" | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -MailTipTranslations @{Add = "$_"}
					}
				}
				if ($CurGroup.EmailAddresses) {
					$CurGroup.EmailAddresses -Split ";" | Where-Object {!($_ -clike "SMTP:*")} | ForEach-Object {
						Set-DistributionGroup -Identity $CurGroup.Identity -emailaddresses @{Add = "$_"}
					}
				}
				if ($CurGroup.x500) {
					Set-DistributionGroup -Identity $CurGroup.Identity -emailaddresses @{Add = "$($CurGroup.x500)"}
				}
            }
			if(-not($CreateEmptyGroups))
			{
				if($ReplaceMembersOnly)
				{
					$members = $null
					$members = Get-DistributionGroupMember -Identity $CurGroup.Name
					$count = ($members | Measure).count
					
					if($count -eq 0)
					{
						Write-Host "Distribution group" $CurGroup.Name "does not contain any member, no remove is needed" -ForegroundColor Yellow
					}
					else
					{
						Write-Host "Delete $count members from distribution group" $CurGroup.Name ". Please wait a moment..." -ForegroundColor Green
					}
					foreach($member in $members)
					{
						Remove-DistributionGroupMember -Identity $CurGroup.Name -member $member.Name -Confirm:$yes
					}
				}
				# Move to its own function!
				if ($CurGroup.membersSMTP) {
					$CurGroup.membersSMTP -Split ";" | ForEach-Object {
						Add-DistributionGroupMember -Identity $CurGroup.Identity -member "$_"
					}
				}
            }
        }
    }
    End {
        
    }
}
