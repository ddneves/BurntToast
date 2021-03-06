function Set-BTFunctionLevel
{
    <#
        .SYNOPSIS
        Changes the function level of the BurntToast module.
        
        .DESCRIPTION
        The Set-BTFunctionLevel function changes the function level of the BurntToast module as defined in config.json.

        To use Set-BTFunctionLevel, use the FunctionLevel parameter to identify the desired FunctionLevel. The only valid inputs to the FunctionLevel parameter are 'Basic' and 'Advanced.'

        As the confirguration for the BurntToast module is saved into a file, PowerShell must be run as an Administrator in order to set a new function level if the module is saved to a location other than the users' home directory. This function will issue an error if this is the case.

        The BurntToast module needs to be re-imported in order for a new function level to take effect and this function will issue a warning when it runs successfully.
        
        .PARAMETER FunctionLevel
        Specifies the function level to set. Valid inputs are 'Basic' and 'Advanced' and 'Basic' is the default option.

        .INPUTS
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None

        .NOTES
        The Set-BTFunctionLevel function is classified as: Basic

        .EXAMPLE
        Set-BTFunctionLevel

        This command changes the function level of the BurntToast module to 'Basic', as the default option, if the current function level is 'Advanced.' If the current function level is already set to 'Basic' the function ends without making a change.

        .EXAMPLE
        Set-BTFunctionLevel -FunctionLevel Basic
        This command changes the function level of the BurntToast module to 'Basic' if the current function level is 'Advanced.' If the current function level is already set to 'Basic' the function ends without making a change.

        .EXAMPLE
        Set-BTFunctionLevel -FunctionLevel Advanced

        This command changes the function level of the BurntToast module to 'Advanced' if the current function level is 'Basic.' If the current function level is already set to 'Advanced' the function ends without making a change.
        
        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/Set-BTFunctionLevel.md

        .LINK
        Get-BTFunctionLevel
    #>

    param
    (
        [Parameter()]
        [ValidateSet('Basic','Advanced')] 
        [string] $FunctionLevel = 'Basic'
    )
    
    $ConfigPath = "$PSScriptRoot\..\..\config.json"
    $CurrentLevel = $Script:Config.FunctionLevel


    if ($CurrentLevel -ne $FunctionLevel)
    {
        $Script:Config.FunctionLevel = $FunctionLevel

        try
        {
        
            $Script:Config | ConvertTo-Json | Out-File -FilePath $ConfigPath -Encoding utf8
            Write-Warning -Message 'Configuration updated, please re-import the BurntToast module or start a new PowerShell session to reflect this function level change.'
        }
        catch
        {
            #TODO: Write/Link to better instructions
            Write-Error -Message "Unable to update $ConfigPath, try running PowerShell as an administrator or moving the BurntToast module to your user directory."
        }
    }
}
