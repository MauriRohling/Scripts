$AzureDevOpsPAT = "[PAT KEY]"
$OrganizationName = "[organization name]"

$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriGroups = "https://vssps.dev.azure.com/$($OrganizationName)/_apis/Graph/Groups"
$UriEntitlements = "https://vsaex.dev.azure.com/$($OrganizationName)/_apis/GroupEntitlements/{0}/Members"


echo "Getting list of groups..."
$Groups = Invoke-RestMethod -Uri $UriGroups -Method get -Headers $AzureDevOpsAuthenicationHeader 

echo "$($Groups.value.Count) groups found"
echo ""


$Output = "Display Name;Principal Name;Last Access;Group$(([Environment]::NewLine))"

foreach($g in $Groups.value){
    echo "Getting $($g.displayName) users..."

    $Users = Invoke-RestMethod -Uri ([string]::Format($UriEntitlements, $g.originId)) -Method get -Headers $AzureDevOpsAuthenicationHeader

    foreach($u in $Users.items){
        $Output += "$($u.user.displayName);$($u.user.principalName);$($u.lastAccessedDate);$($g.displayName)$(([Environment]::NewLine))"
    }
}


Out-File -FilePath .\result.csv -InputObject $Output