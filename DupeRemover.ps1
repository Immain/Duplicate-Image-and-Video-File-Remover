# Specify the directory path where your images are located
$directoryPath = "C:\Path\To\Files"


# Confirmation
$confirmation = Read-Host "This script will delete duplicate image and video files in $directoryPath. Continue? (y/n)"
if ($confirmation -ne 'y') {
    Write-Host "Operation cancelled."
    return
}

try {
    # Get all image files in the specified directory and its subdirectories
    Write-Host "Searching for image and video files..."
    $imageFiles = Get-ChildItem -Path $directoryPath -Recurse -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp, *.mp4
    Write-Host "Found $($imageFiles.Count) image files"

    # Define the pattern to match files with " - Copy" and/or (n) at the end of the filename
    $pattern = '^(.+?)(?:\s*-\s*Copy)?\s*(?:\(\d+\))?(\.[^.]+)$'

    # Group the files by their base name (without the " - Copy" or (n) suffix)
    $groupedFiles = $imageFiles | Group-Object { 
        if ($_.Name -match $pattern) {
            $matches[1] + $matches[2]
        } else {
            $_.Name
        }
    }

    # Process each group of files
    foreach ($group in $groupedFiles) {
        # Sort the files by name
        $sortedFiles = $group.Group | Sort-Object Name

        # Keep the original file (without " - Copy" or (n) suffix)
        $originalFile = $sortedFiles | Where-Object { $_.Name -notmatch '(\s*-\s*Copy|\s*\(\d+\))' } | Select-Object -First 1

        if ($originalFile) {
            Write-Host "Keeping original file: $($originalFile.FullName)"

            # Remove the files with suffixes
            $sortedFiles | Where-Object { $_ -ne $originalFile } | ForEach-Object {
                if ($_.Name -match '(\s*-\s*Copy|\s*\(\d+\))') {
                    Write-Host "Removing duplicate file: $($_.FullName)"
                    Remove-Item $_.FullName -Force
                }
            }
        } else {
            Write-Host "No original file found for group: $($group.Name)"
        }
    }

    Write-Host "File removal process completed."
}
catch {
    Write-Host "An error occurred: $_"
}
