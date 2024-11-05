# Duplicate Image and Video File Remover

## Description

I created this PowerShell script to remove duplicate image and video files in a specified directory and its subdirectories. It identifies duplicates based on file names with " - Copy" and/or "(n)" suffixes, keeping the original file and deleting the duplicates.

## Features

- Searches for image files (jpg, jpeg, png, gif, bmp) and video files (mp4) recursively in a specified directory
- Identifies duplicate files based on naming patterns
- Keeps the original file and removes duplicates
- Provides user confirmation before proceeding
- Outputs detailed information about the process

## Usage

1. Open the script in a text editor.
2. Set the `$directoryPath` variable to the directory containing your images and videos.
3. Run the script in PowerShell.
4. Confirm the operation when prompted.

## How It Works

1. The script first asks for user confirmation to proceed.
2. It then searches for image and video files in the specified directory and its subdirectories.
3. Files are grouped based on their base name (ignoring " - Copy" or "(n)" suffixes).
4. For each group:
   - The original file (without suffixes) is identified and kept.
   - Duplicate files (with suffixes) are removed.
5. The script provides output about kept and removed files.

## Supported File Types

- Images: .jpg, .jpeg, .png, .gif, .bmp
- Videos: .mp4

## Caution

- This script permanently deletes files. Use with caution and ensure you have backups.
- Always verify the `$directoryPath` before running the script.


## Requirements

- PowerShell 7.0 or later

## Disclaimer

Use this script at your own risk. The author is not responsible for any data loss or damage caused by the use of this script.
