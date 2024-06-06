function totalrecall{

    <#
    .SYNOPSIS
        A PowerShell rewrite of Total Recall, originally at https://github.com/xaitax/TotalRecall/

    .DESCRIPTION
        A PowerShell rewrite of Total Recall, originally at https://github.com/xaitax/TotalRecall/

        This very simple tool extracts and displays data from the Recall feature in Windows 11, providing an easy way to access information about your PC's activity snapshots.

    .PARAMETER fromDate
        The start date in YYYY-MM-DD format.

    .PARAMETER toDate
        The end date in YYYY-MM-DD format.

    .PARAMETER search
        Search term for text recognition data.

    .EXAMPLE
        PS>

        Example of how to use this cmdlet

    .EXAMPLE
        PS>

        Another example of how to use this cmdlet

    .INPUTS
        Inputs to this cmdlet (if any)

    .OUTPUTS
        Output from this cmdlet (if any)

    .LINK
        Original: https://github.com/xaitax/TotalRecall/
    .LINK
        This fork: https://github.com/Emptiest/TotalRecall

    .NOTES
        General notes
    #>

    [CmdletBinding()]

    param(
        [datetime] $fromDate,
        [datetime] $toDate,
        [string] $search
    )

    BEGIN{
        $Version = 0.3
        $BasePath = "$env:LOCALAPPDATA\CoreAIPlatform.00\UKP"
        $Banner = "
___________     __         .__ __________                     .__  .__   
\__    ___/____/  |______  |  |\______   \ ____   ____ _____  |  | |  |  
  |    | /  _ \   __\__  \ |  | |       _// __ \_/ ___\\__  \ |  | |  |  
  |    |(  <_> )  |  / __ \|  |_|    |   \  ___/\  \___ / __ \|  |_|  |__
  |____| \____/|__| (____  /____/____|_  /\___  >\___  >____  /____/____/
                         \/            \/     \/     \/     \/           
                         "
        Write-Host $Banner
        Write-Host "v$Version / Alexander Hagenah / @xaitax / ah@primepage.de"
    }

    PROCESS{
        if(Test-Path $BasePath){
            $icaclsArgs = {
                "$BasePath",
                "/grant",
                "$env:USERNAME:(OI)(CI)F",
                "/T",
                "/C",
                "/Q"
            }
            Start-Process -FilePath "icacls" -ArgumentList $icaclsArgs -PassThru | Wait-Process
            foreach($folder in (Get-ChildItem -Path $BasePath -Directory)){
                $FolderPath = $BasePath + $folder
                if(Test-Path $FolderPath){
                    $GuidFolder = $FolderPath
                    break
                }
            }
        }else{
            Write-Host "🚫 Base path does not exist."
            return
        }

        if(-not $GuidFolder){
            Write-Host "🚫 Could not find the GUID folder."
            return
        }

        Write-Host "📁 Recall folder found: $GuidFolder"

        $DBPath = $GuidFolder + "ukg.db"
        $ImageStorePath = $GuidFolder + "ImageStore"

        # Done down to line 75
        Write-Host "This script is still WIP, nothing has been done yet!"
    }

    END{}
}



