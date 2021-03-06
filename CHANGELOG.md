
# Versions

## Unreleased

### 1.6.0
* Adds support for functions that query Vault API endpoints that utilize the LIST method.
  * Adds Show-VaultTokenAccessor, a command that lists all active token accessors.
  * Adds Show-VaultKVSecret, a command that presents a list of key names at a specified Vault secret path.
* Updates the README with information noting the Invoke-RestMethod limitation of not having a LIST method.
* Updates the README with information about the Show --> List aliasing.
* Updates the module manifest with new functions and aliases.
* Fixes a bug in Format-VaultOutput introduced in v1.5.1.

### 1.5.1
* Adds functions for listing, getting, updating, creating and deleting policies.
* Adds a function for generating policy documents.
* Adds a private function for deriving a specified TTL in seconds, given a string-formatted TTL that Vault recognizes.
* Adds new functions and aliases to the manifest file, and adds new aliases to the module file.
* Adds support for formatting objects containing policy information to Format-VaultOutput.

### 1.4.5
* Adds `DNSClient` to the list of RequiredModules.
* Adds a Project Uri.

### 1.4.4
* Adds SupportsShouldProcess to functions that modify system state.
* Fixes a typo in $publicFunctions and $privateFunctions.
* Fixes a bug with the alias New-VaultCubbyholeSecret.
* Removes errant Write-Verbose calls.

### 1.4.3
* Replaces Invoke-Expression calls in Format-VaultOutput with Invoke-Command. Replaces expressions with ScriptBlocks.
* Fixes a formatting issue in the README.
* Replaces bsmall email address with anti-bot email address formatting.
* Generalizes a reference to an actual KV engine.
* Fixes parameter help for OutputType in approximately 28 functions.
* Removes wayfair CODEOWNERS file.
* Clarifies that the DSC proof-of-concept example requires the `CredentialManager` module.

## Released

### 1.4.2

* First public release.
* Removes Wayfair-specific code from repository.
* Adds author's note to README.