#
# Module manifest for module 'VaultUtils'
#
# Generated by: Ben Small
#
# Generated on: 6/13/2019
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'vaultUtils.psm1'
    
    # Version number of this module.
    ModuleVersion = '1.1.5'
    
    # Supported PSEditions
    # CompatiblePSEditions = @()
    
    # ID used to uniquely identify this module
    GUID = '9fec3b7d-0371-4530-bbe7-b0d1c0d1a9f8'
    
    # Author of this module
    Author = 'Ben Small'
    
    # Company or vendor of this module
    CompanyName = 'Wayfair Inc.'
    
    # Copyright statement for this module
    Copyright = ''
    
    # Description of the functionality provided by this module
    # Description = ''
    
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '3.0'
    
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
    # RequiredModules = @()
    
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()
    
    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()
    
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()
    
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()
    
    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()
    
    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Get-VaultSessionVariable'
        'Set-VaultSessionVariable'
        'Clear-VaultSessionVariable'

        'Get-VaultMetric'
        'Get-VaultStatus'
        'Protect-Vault'
        'Unprotect-Vault'
        'Revoke-VaultLeader'
        'Test-VaultHealth'

        'Get-VaultKeyStatus'
        'Get-VaultRekeyProgress'
        'Get-VaultRekeyVerificationProgress'
        'Start-VaultRekey'
        'Stop-VaultRekey'
        'Stop-VaultRekeyVerification'
        'Submit-VaultRekey'
        'Submit-VaultRekeyVerification'

        'Get-VaultLoginToken'
        'Set-VaultLoginToken'

        'New-VaultToken'
        'New-VaultWrappedToken'
        'Get-VaultToken'
        'Update-VaultToken'
        'Revoke-VaultToken'

        'Get-VaultTokenAccessor'
        'Revoke-VaultTokenAccessor'

        'Get-VaultRootTokenGenerationProgress'
        'Start-VaultRootTokenGeneration'
        'Stop-VaultRootTokenGeneration'
        'Submit-VaultRootTokenGeneration'
        'Unprotect-VaultRootToken'
        
        'ConvertFrom-Base64'
        'ConvertTo-Base64'
        'Get-VaultRandomBytes'
        'Get-VaultDataHash'

        'New-VaultKVSecret'
        'Get-VaultKVSecret'
        'Remove-VaultKVSecret'
        'Restore-VaultKVSecret'

        'New-VaultCubbyholeSecret'
        'Get-VaultCubbyholeSecret'
        'Update-VaultCubbyholeSecret'
        'Remove-VaultCubbyholeSecret'

        'Get-VaultKVEngine'
        'Set-VaultKVEngine'

        'New-VaultWrapping'
        'Show-VaultWrapping'
        'Get-VaultWrapping'
        'Update-VaultWrapping'
    )
    
    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()
    
    # Variables to export from this module
    VariablesToExport = '*'
    
    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @(
        'Seal-Vault'
        'Unseal-Vault'

        'Stepdown-VaultLeader'

        'Cancel-VaultRekey'
        'Cancel-VaultRekeyVerification'

        'Cancel-VaultRootTokenGeneration'

        'Unwrap-VaultWrapping'
        'Wrap-VaultWrapping'
        'Lookup-VaultWrapping'
        'Rewrap-VaultWrapping'

        'Renew-VaultToken'
    )
    
    # DSC resources to export from this module
    # DscResourcesToExport = @()
    
    # List of all modules packaged with this module
    # ModuleList = @()
    
    # List of all files packaged with this module
    # FileList = @()
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
    
        PSData = @{
            Title = "Hashicorp Vault Utility Functions"
    
            Summary = "A collection of utility-style powershell functions for interacting with Hashicorp Vault."
    
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()
    
            # A URL to the license for this module.
            # LicenseUri = ''
    
            # A URL to the main website for this project.
            # ProjectUri = ''
    
            # A URL to an icon representing this module.
            # IconUri = ''
    
            # ReleaseNotes of this module
            # ReleaseNotes = ''
    
        } # End of PSData hashtable
    
    } # End of PrivateData hashtable
    
    # HelpInfo URI of this module
    # HelpInfoURI = ''
    
    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
    
}
    