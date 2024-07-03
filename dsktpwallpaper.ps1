$executionPolicy = "RemoteSigned"

# Set the execution policy for the script
Set-ExecutionPolicy -ExecutionPolicy $executionPolicy -Scope Process -Force

# Function to download an image from a URL
function Download-Image {
    param(
        [string]$url,
        [string]$outputPath
    )

    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $outputPath)
}

# Function to set desktop wallpaper
function Set-DesktopWallpaper {
    param(
        [string]$imagePath
    )

    # Set the wallpaper
    $code = @'
    using System;
    using System.Runtime.InteropServices;

    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        
        public const int SPI_SETDESKWALLPAPER = 0x0014;
        public const int SPIF_UPDATEINIFILE = 0x01;
        public const int SPIF_SENDCHANGE = 0x02;

        public static void SetWallpaper(string path) {
            SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
        }
    }
'@

    Add-Type -TypeDefinition $code -Language CSharp
    [Wallpaper]::SetWallpaper($imagePath)
}

# URL of the image
$imageUrl = "https://entrustbkp.s3.ap-south-1.amazonaws.com/Enturst+image.jpg"

# Path to save the downloaded image
$imagePath = "C:\Windows\Web\Wallpaper\Windows\wallpaper.jpg"

# Download the image
Download-Image -url $imageUrl -outputPath $imagePath

# Set the desktop wallpaper
Set-DesktopWallpaper -imagePath $imagePath
