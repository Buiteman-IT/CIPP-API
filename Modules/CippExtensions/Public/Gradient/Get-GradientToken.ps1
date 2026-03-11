function Get-GradientToken {
    param(
        $Configuration
    )
    if ($Configuration.vendorKey) {
        $partnerApiKey = (Get-CippKeyVaultSecret  -Name 'Gradient' -AsPlainText)
        $authorizationToken = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$($configuration.vendorKey):$($partnerApiKey)"))

        $headers = [hashtable]@{
            'Accept'         = 'application/json'
            'GRADIENT-TOKEN' = $authorizationToken
        }

        try {
            return [hashtable]$headers
        } catch {
            return $false
        }
    } else {
        return $false
    }
}
