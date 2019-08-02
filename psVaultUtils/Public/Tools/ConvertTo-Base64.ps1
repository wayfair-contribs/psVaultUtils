# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#Credit/Changes:
<#
    * Author: Aaron Jensen
    * Copyright: Aaron Jensen and WebMD Health Services
    * Module: Carbon 2.1.0
    * Link: https://www.powershellgallery.com/packages/Carbon/2.8.1
    * Link: https://github.com/webmd-health-services/Carbon/blob/develop/Carbon/Functions/ConvertTo-Base64.ps1
    * Changes:
        * Removed function calls Set-StrictMode and Use-CallerPreference from begin block.
        * Formatting changes: 
            * Formatting changes to curly brackets.
            * Formatting of param block (and capitalization of [string[]]).
#>

function ConvertTo-Base64 {
<# 
.SYNOPSIS 
Converts a value to base-64 encoding. 
    
.DESCRIPTION 
For some reason. .NET makes encoding a string a two-step process. This function makes it a one-step process. 
    
You're actually allowed to pass in `$null` and an empty string. If you do, you'll get `$null` and an empty string back. 

.LINK 
ConvertFrom-Base64 
    
.EXAMPLE 
ConvertTo-Base64 -Value 'Encode me, please!' 
    
Encodes `Encode me, please!` into a base-64 string. 
    
.EXAMPLE 
ConvertTo-Base64 -Value 'Encode me, please!' -Encoding ([Text.Encoding]::ASCII) 
    
Shows how to specify a custom encoding in case your string isn't in Unicode text encoding. 
    
.EXAMPLE 
'Encode me!' | ConvertTo-Base64 
    
Converts `Encode me!` into a base-64 string. 
#>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [AllowNull()]
        [AllowEmptyString()]
        [String[]]
        # The value to base-64 encoding.
        $Value,
        
        [Text.Encoding]
        # The encoding to use. Default is Unicode.
        $Encoding = ([Text.Encoding]::Unicode)
    )
    
    begin {  

    }

    process {
        $Value | ForEach-Object {
            if( $_ -eq $null )
            {
                return $null
            }
            
            $bytes = $Encoding.GetBytes($_)
            [Convert]::ToBase64String($bytes)
        }
    }
}