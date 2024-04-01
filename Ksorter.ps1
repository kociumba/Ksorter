function Rename_jfif {
    # renames any found .jfif files to .jpeg

    param (
        [string]$directory = (Get-Location)
    )

    $files = Get-ChildItem $directory -File
    $totalFiles = $files.Count
    $processedFiles = 0
    
    foreach ($file in $files) {
        $ext = $file.Extension.ToLower()
        if ($ext -eq ".jfif") {
            $newName = $file.BaseName + ".jpeg"
            $newPath = Join-Path -Path $directory -ChildPath $newName
            if (-not (Test-Path -Path $newPath)) {
                $file | Rename-Item -NewName $newName -ErrorAction SilentlyContinue
            } else {
                Write-Warning "File '$newName' already exists. Skipping."
            }
        }
        
        $processedFiles++
        $percentComplete = ($processedFiles / $totalFiles) * 100
        Write-Progress -Activity "Renaming .jfif files" -Status "Progress" -PercentComplete $percentComplete
    }
}


# get the user consent and settings
echo "This script will move all the supported files in the current directory"
$answer = Read-Host "Do you wish to proceed? (y/n)"
if ($answer -ne "y") {
    echo "Exiting script." -ForegroundColor Red
    exit
}

$rename_jfif = Read-Host "Do you wish to rename all the jfif files? (y/n)"
if ($rename_jfif -eq "y") {
    Rename_jfif
}

echo "Creating all the folders" -ForegroundColor Green


# set up the needed data and create initaial folders
$directory = Get-Location
$files = Get-ChildItem $directory -File
$totalFiles = $files.Count
$currentFile = 0

if (!(Test-Path "$directory/PDFs")) {
    mkdir "$directory/PDFs" > $null
}
if (!(Test-Path "$directory/Images")) {
    mkdir "$directory/Images" > $null
}
if (!(Test-Path "$directory/Docs")) {
    mkdir "$directory/Docs" > $null
}
if (!(Test-Path "$directory/Music")) {
    mkdir "$directory/Music" > $null
}
if (!(Test-Path "$directory/Videos")) {
    mkdir "$directory/Videos" > $null
}
if (!(Test-Path "$directory/Archives")) {
    mkdir "$directory/Archives" > $null
}
if (!(Test-Path "$directory/Design")) {
    mkdir "$directory/Design" > $null
}
if (!(Test-Path "$directory/Code")) {
    mkdir "$directory/Code" > $null
}
if (!(Test-Path "$directory/Executables")) {
    mkdir "$directory/Executables" > $null
}
if (!(Test-Path "$directory/Presentations")) {
    mkdir "$directory/Presentations" > $null
}
if (!(Test-Path "$directory/Text")) {
    mkdir "$directory/Text" > $null
}

echo "Moving all the files" -ForegroundColor Green


# move all found files by extension
foreach ($file in $files) {
    $currentFile++
    $ext = $file.Extension.ToLower()

    # Calculate progress percentage
    $progress = [math]::Round(($currentFile / $totalFiles) * 100)

    # Update progress bar
    Write-Progress -Activity "Moving Files" -Status "Progress: $progress%" -PercentComplete $progress

    try {
        if ($ext -in @(".pdf")) {
            $file | Move-Item -Destination "$directory/PDFs" -ErrorAction Stop
        }
        if ($ext -in @(".png", ".jpg", ".jpg_large", ".jpeg", ".jfif", ".bmp", ".gif", ".psd", ".tiff", ".webp", ".svg", ".ico", ".xcf")) {
            $file | Move-Item -Destination "$directory/Images" -ErrorAction Stop
        }
        if ($ext -in @(".docx", ".doc")) {
            $file | Move-Item -Destination "$directory/Docs" -ErrorAction Stop
        }
        if ($ext -in @(".mp3", ".wav", ".flac", ".m4a", ".aac", ".ogg", ".mid", ".wma", ".ape", ".aiff", ".alac", ".opus")) {
            $file | Move-Item -Destination "$directory/Music" -ErrorAction Stop
        }
        if ($ext -in @(".mp4", ".wmv", ".avi", ".mov", ".webm", ".flv", ".avchd")) {
            $file | Move-Item -Destination "$directory/Videos" -ErrorAction Stop
        }
        if ($ext -in @(".zip", ".rar", ".7z", ".Bzip2", ".gzip", ".tar", ".gz", ".io")) {
            $file | Move-Item -Destination "$directory/Archives" -ErrorAction Stop
        }
        if ($ext -in @(".dwg", ".dwf", ".dxf", ".acis")) {
            $file | Move-Item -Destination "$directory/Design" -ErrorAction Stop
        }
        if ($ext -in @(
                ".c", 
                ".go", 
                ".cs", 
                ".java", 
                ".class", 
                ".swift", 
                ".vb", 
                ".php", 
                ".mod", 
                ".sum", 
                ".ino", 
                ".asm", 
                ".a51", 
                ".inc", 
                ".nasm",
                ".js",
                ".html",
                ".css",
                ".xml",
                ".json",
                ".py",
                ".csproj",
                ".sln",
                ".jsx",
                ".ts",
                ".tsx",
                ".bat",
                ".cmd",
                ".sh",
                ".ps1",
                ".dockerfile",
                ".sql",
                ".ex",
                ".gd",
                ".hs",
                ".lua",
                ".zig",
                ".r",
                ".nsi",
                ".ml",
                ".rs")) {
            $currentScriptName = $MyInvocation.MyCommand.Name
            if ($file.name -eq $currentScriptName) {
                continue
            }
            $file | Move-Item -Destination "$directory/Code" -ErrorAction Stop
        }

        if ($ext -in @(".exe", ".msi", ".dll")) {
            $file | Move-Item -Destination "$directory/Executables" -ErrorAction Stop
        }

        if ($ext -in @(".pptx", ".ppt", ".pptm", ".potx", ".potm", ".ppam", ".ppsx", ".ppsm", ".sldx", ".sldm", ".odp", ".otp")) {
            $file | Move-Item -Destination "$directory/Presentations" -ErrorAction Stop
        }

        if ($ext -in @(".txt", ".md")) {
            $file | Move-Item -Destination "$directory/Text" -ErrorAction Stop
        }
    }
    catch {
        Write-Warning "Failed to move file $($file.FullName): $_"
    }
}


echo "Cleaning up" -ForegroundColor Green


# clean up any unused folders 
$PDFs = Get-ChildItem "$directory/PDFs"
if ($PDFs.Length -eq 0) {
    Remove-Item -Path "$directory/PDFs"
}

$Images = Get-ChildItem "$directory/Images"
if ($Images.Length -eq 0) {
    Remove-Item -Path "$directory/Images"
}

$Docs = Get-ChildItem "$directory/Docs"
if ($Docs.Length -eq 0) {
    Remove-Item -Path "$directory/Docs"
}

$Music = Get-ChildItem "$directory/Music"
if ($Music.Length -eq 0) {
    Remove-Item -Path "$directory/Music"
}

$Videos = Get-ChildItem "$directory/Videos"
if ($Videos.Length -eq 0) {
    Remove-Item -Path "$directory/Videos"
}

$Archives = Get-ChildItem "$directory/Archives"
if ($Archives.Length -eq 0) {
    Remove-Item -Path "$directory/Archives"
}

$Design = Get-ChildItem "$directory/Design"
if ($Design.Length -eq 0) {
    Remove-Item -Path "$directory/Design"
}

$Code = Get-ChildItem "$directory/Code"
if ($Code.Length -eq 0) {
    Remove-Item -Path "$directory/Code"
}

$Executables = Get-ChildItem "$directory/Executables"
if ($Executables.Length -eq 0) {
    Remove-Item -Path "$directory/Executables"
}

$Presentations = Get-ChildItem "$directory/Presentations"
if ($Presentations.Length -eq 0) {
    Remove-Item -Path "$directory/Presentations"
}

$Text = Get-ChildItem "$directory/Text"
if ($Text.Length -eq 0) {
    Remove-Item -Path "$directory/Text"
}


# display simple stats and finalize the script
echo "Getting final stats" -ForegroundColor Green
$files = Get-ChildItem -Path $directory -File -Recurse
$totalSize = ($files | Measure-Object -Property Length -Sum).Sum
$sortFolders = Get-ChildItem "$directory"
echo "Total size: " -NoNewline
if ($totalSize / 1GB -lt 1) {
    $sizeFormatted = "{0:N2} MB" -f ($totalSize / 1MB)
} else {
    $sizeFormatted = "{0:N2} GB" -f ($totalSize / 1GB)
}
echo $sizeFormatted -ForegroundColor Cyan
echo "Total number of files: " -NoNewline
echo "$($files.Count - 1)" -ForegroundColor Cyan
echo "Total number of folders: " -NoNewline
echo "$($sortFolders.Count - 1)" -ForegroundColor Cyan

echo "Task complete. Thank you for indulging my " -NoNewline 
echo "'schizo coding'." -ForegroundColor Magenta
echo ""
echo "Press Enter to close this window..." 
$null = Read-Host
echo "Goodbye!" -ForegroundColor Green