function New-VaultWrapping {
<#
.Synopsis
    Wraps one or more specified key-value pairs with a specified TTL.

.DESCRIPTION
    New-VaultWrapping wraps one or more specified key-value pairs with a specified TTL. 

    Wrapped data can be retrieved once using the token returned by New-VaultWrapping, 
    until the wrapped data expires (determined by its TTL).

.EXAMPLE
    PS> New-VaultWrapping -WrapData @{'foo'='bar'} -WrapTTL 60m

    request_id     :
    lease_id       :
    renewable      : False
    lease_duration : 0
    data           :
    wrap_info      : @{token=s.1G4mBRbpvZ7TQEj0Cf90MImO; accessor=nfxQwWjK2NCq9dDGtCin1u3l; ttl=3600;
                    creation_time=2019-07-01T15:38:01.0379215-04:00; creation_path=sys/wrapping/wrap}
    warnings       :
    auth           :

.EXAMPLE
    PS> Wrap-VaultWrapping -WrapData @{'foo'='bar';'zip'='zap'} -WrapTTL 60h

    request_id     :
    lease_id       :
    renewable      : False
    lease_duration : 0
    data           :
    wrap_info      : @{token=s.yGdKDWpLBFYUPMbtnHZkmJZ7; accessor=b2GincNXOeuZqKapqkIL9VXI; ttl=216000;
                    creation_time=2019-07-01T15:55:45.3618027-04:00; creation_path=sys/wrapping/wrap}
    warnings       :
    auth           :
#>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium'
    )]
    param(
        #Specifies one or more key-values pairs of data to wrap.
        [Parameter(
            Position = 0
        )]
        [Hashtable] $WrapData,

        #Specifies a time-to-live value the wrapped data is valid for.
        #TTL is a string and can be expressed as a number of seconds, minutes or hours, formatted as: '60' OR '60s' OR '60m' OR '60h'.
        #The default TTL is '24h' or 24 hours.
        [Parameter(
            Position = 1
        )]
        [Alias('TTL')]
        [ValidateScript({ $_ -match "^\d+$|^\d+[smh]$" })]
        [String] $WrapTTL = "24h",

        #Specifies how output information should be displayed in the console. Available options are JSON, PSObject or Hashtable.
        [Parameter(
            Position = 2
        )]
        [ValidateSet('Json','PSObject','Hashtable')]
        [String] $OutputType = 'PSObject',

        #Specifies whether or not just the data should be displayed in the console.
        [Parameter(
            Position = 3
        )]
        [Switch] $JustData
    )

    begin {
        Test-VaultSessionVariable -CheckFor 'Address','Token'
    }

    process {
        $uri = $global:VAULT_ADDR

        $wrapDataKV = @()
        foreach ($wd in $WrapData.GetEnumerator()) {
            $wrapDataKV += "`"$($wd.Name)`": `"$($wd.Value)`""
        }

        $jsonPayload = @"
{
    $($wrapDataKV -join ", ")
}      
"@

        $irmParams = @{
            Uri    = "$uri/v1/sys/wrapping/wrap"
            Header = @{ 
                "X-Vault-Token"    = $global:VAULT_TOKEN
                "X-Vault-Wrap-TTL" = $WrapTTL
            }
            Method = 'Post'
            Body   = $($jsonPayload | ConvertFrom-Json | ConvertTo-Json -Compress)
        }

        if ($PSCmdlet.ShouldProcess("$($global:VAULT_ADDR.Replace('https://',''))",'Create Vault wrapping')) {
            try {
                $result = Invoke-RestMethod @irmParams
            }
            catch {
                throw
            }
        }

        $formatParams = @{
            InputObject = $result
            DataType    = 'wrap_info'
            JustData    = $JustData.IsPresent
            OutputType  = $OutputType
        }

        Format-VaultOutput @formatParams
    }

    end {

    }
}

Set-Alias -Name 'Wrap-VaultWrapping' -Value 'New-VaultWrapping'