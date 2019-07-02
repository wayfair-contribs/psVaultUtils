function Update-VaultToken {
<#
.Synopsis
    Renews the lease/ttl associated with a specified token.

.DESCRIPTION
    Update-VaultToken renews the lease/ttl associated with a specified token.

    A token's lease/ttl can only be renewed if the renewable flag is true on the token.

.EXAMPLE
    PS> Update-VaultToken -Self

    This example demonstrates extending the calling token (VAULT_TOKEN) lease/ttl by 48 hours.

    This command does not produce any output.

.EXAMPLE 
    PS> New-VaultToken -TimeToLive 5m -Renewable:$true -OutputType Json -JustAuth
    {
        "client_token":  "s.6XC5dWL75V7ShPEPrtuY3b7K",
        "accessor":  "GjnDjvCCx7eqj5baQBZp65M5",
        "policies":  [
                        "default",
                        "jenkinsc02-secret-consumer",
                        "operator"
                    ],
        "token_policies":  [
                            "default"
                        ],
        "identity_policies":  [
                                "jenkinsc02-secret-consumer",
                                "operator"
                            ],
        "metadata":  null,
        "lease_duration":  300,
        "renewable":  false,
        "entity_id":  "357f788d-75cf-c16d-f6d9-cdbd6c5deee8",
        "token_type":  "service",
        "orphan":  false
    }

    PS> Update-VaultToken -Token s.8PO0oFZXxRupjbS5rMqNeUz4 -Increment 1h -JustAuth

    client_token   : s.8PO0oFZXxRupjbS5rMqNeUz4
    accessor       : 6IcEPieRiAQwB0MhSqqYhc2P
    policies       : {default}
    token_policies : {default}
    metadata       :
    lease_duration : 3600
    renewable      : True
    entity_id      : 357f788d-75cf-c16d-f6d9-cdbd6c5deee8
    token_type     : service
    orphan         : False

    This example demonstates creating a new renewable token with a lease of 300 seconds, or 5 minutes, and then extending the lease to 1 hour (3600 seconds).

#>
    [CmdletBinding(
        DefaultParameterSetName = 'bySelf'
    )]
    param(
        #Specifies a token whose lease should be updated.
        [Parameter(
            ParameterSetName = 'byToken'

        )]
        [String] $Token,

        #Specifies that the token whose lease should be updated is defined in VAULT_TOKEN.
        [Parameter(
            ParameterSetName = 'bySelf'
        )]
        [Switch] $Self,

        #Specifies how much the lease/ttl should be updated by.
        #Increment is a string and can be expressed as a number of seconds, minutes or hours, formatted as: '60' OR '60s' OR '60m' OR '60h'.
        [ValidateScript({ $_ -match "^\d+$|^\d+[smh]$" })]
        [String] $Increment,

        #Specifies how output information should be displayed in the console. Available options are JSON or PSObject.
        [ValidateSet('Json','PSObject')]
        [String] $OutputType = 'PSObject',

        #Specifies whether or not just the authentication information should be displayed in the console.
        [Switch] $JustAuth
    )

    begin {
        Test-VaultSessionVariable -CheckFor 'LoginMethod','Cred','Address','Token'
    }

    process {
        $uri = $global:VAULT_ADDR

        switch ($PSCmdlet.ParameterSetName) {
            'bySelf'  { $getToken = Get-VaultToken -Token $global:VAULT_TOKEN }
            'byToken' { $getToken = Get-VaultToken -Token $Token              }
        }

        if ($getToken.data.renewable) {
            switch ($PSCmdlet.ParameterSetName) {
                'bySelf' {
                    if ($Increment) {
                        $jsonPayload = @"
{
    "increment": "$Increment"
}
"@
                    }

                    $iToken      = $global:VAULT_TOKEN
                    $fulluri     = "$uri/v1/auth/token/renew-self"                
                }
                'byToken' {
                    $iToken      = $token
                    $fulluri     = "$uri/v1/auth/token/renew"
                    $jsonPayload = @"
{
    "token": "$iToken" $( if ($Increment) { ", `"increment`": `"$Increment`"" } )
}
"@
                }
            }

            $irmParams = @{
                Uri    = $fulluri
                Header = @{ "X-Vault-Token" = $global:VAULT_TOKEN }
                Method = 'Post'
            }

            if ($PSCmdlet.ParameterSetName -eq 'byToken') {
                $irmParams += @{Body = $($jsonPayload | ConvertFrom-Json | ConvertTo-Json -Compress) }
            }

            try {
                $result = Invoke-RestMethod @irmParams
            }
            catch {
                throw
            }

            switch ($OutputType) {
                'Json' {
                    if ($JustAuth) {
                        $result.auth | ConvertTo-Json
                    }
                    else {
                        $result | ConvertTo-Json
                    }
                }

                'PSObject' {
                    if ($JustAuth) {
                        $result.auth
                    }
                    else {
                        $result
                    }
                }
            }
        }
        else {
            Write-Error "The specified token is not renewable."
        }
    }

    end {

    }
}

Set-Alias -Name 'Renew-VaultToken' -Value 'Update-VaultToken'