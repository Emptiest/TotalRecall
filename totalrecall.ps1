function totalrecall{

    <#
    .SYNOPSIS
        A PowerShell rewrite of Total Recall, originally at https://github.com/xaitax/TotalRecall/

    .DESCRIPTION
        A PowerShell rewrite of Total Recall, originally at https://github.com/xaitax/TotalRecall/

        This very simple tool extracts and displays data from the Recall feature in Windows 11, providing an easy way to access information about your PC's activity snapshots.

    .PARAMETER FromDate
        The start date in YYYY-MM-DD format.

    .PARAMETER ToDate
        The end date in YYYY-MM-DD format.

    .PARAMETER Search
        Search term for text recognition data.

    .EXAMPLE
        PS> totalrecall

        Example of how to use this cmdlet

    .EXAMPLE
        PS> totalrecall 

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
        [datetime]  $FromDate,
        [datetime]  $ToDate,
        [string]    $Search
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
        Write-Host "PowerShell rewrite by Fullest (https://github.com/Emptiest)"
    }

    PROCESS{
        throw "This script is not ready for use yet."
        if(Test-Path $BasePath){
            $icaclsArgs = {
                "$BasePath",
                "/grant",
                "$env:USERNAME:(OI)(CI)F",
                "/T",
                "/C",
                "/Q"
            }
            try {
                Start-Process -FilePath "icacls" -ArgumentList $icaclsArgs -PassThru | Wait-Process
                Write-Host "✅ Permissions modified for $BasePath and all its subdirectories and files" -ForegroundColor Green
            }
            catch {
                Write-Host "❌ Failed to modify permissions for $BasePath" -ForegroundColor Red
                Write-Host $_
            }
            
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

        if(-not (Test-Path $DBPath) -and (Test-Path $ImageStorePath)){
            Write-Host "🚫 Windows Recall feature not found. Nothing to extract."
            return
        }

        $Proceed = (Read-Host -Prompt "🟢 Windows Recall feature found. Do you want to proceed with the extraction? (yes/no)").Trim().ToLower()
        if($Proceed -ne "yes"){
            Write-Host "⚠️ Extraction aborted."
            return
        }

        $timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"
        $ExtractionFolderPath = "$($PWD)\$($timestamp)_Recall_Extraction"
        $ExtractionFolder = New-Item -Path $ExtractionFolderPath -ItemType Directory -ErrorAction SilentlyContinue
        Write-Host "📂 Creating extraction folder: $ExtractionFolderPath"
        
        
    }

    END{
        # Done down to line 78
        Write-Host "This script is still WIP, nothing has been done yet!"
    }
}