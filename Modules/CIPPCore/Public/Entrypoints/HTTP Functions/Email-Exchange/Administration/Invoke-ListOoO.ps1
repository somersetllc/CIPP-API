using namespace System.Net

Function Invoke-ListOoO {
    <#
    .FUNCTIONALITY
        Entrypoint
    .ROLE
        Exchange.Mailbox.Read
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)

    $APIName = $Request.Params.CIPPEndpoint
    $Tenantfilter = $request.query.tenantFilter
    try {
        $Body = Get-CIPPOutOfOffice -UserID $Request.query.userid -tenantFilter $TenantFilter -APIName $APINAME -Headers $Request.Headers
    } catch {
        $ErrorMessage = Get-NormalizedError -Message $_.Exception.Message
        $Body = [pscustomobject]@{'Results' = "Failed. $ErrorMessage" }

    }

    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = $Body
        })

}
