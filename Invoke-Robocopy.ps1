function Invoke-Robocopy {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Source,
        [Parameter(Mandatory=$true)]
        [string]$Destination,
        [Parameter(Mandatory=$false)]
        [switch]$Recurse,
        [Parameter(Mandatory=$false)]
        [switch]$Backup,
        [Parameter(Mandatory=$false)]
        [switch]$MultiThreaded,
        [Parameter(Mandatory=$false)]
        [switch]$NetworkMode,
        [Parameter(Mandatory=$false)]
        [string]$LogFile,
        [Parameter(Mandatory=$false)]
        [switch]$MoveFiles,
        [Parameter(Mandatory=$false)]
        [switch]$MoveAll,
        [Parameter(Mandatory=$false)]
        [string]$Monitor
    )

    $robocopyCommand = "ROBOCOPY"
    $robocopyArgs = @("`"$Source`"", "`"$Destination`"")

    # Includes all subfolders, both empty and not empty
    if ($Recurse) {$robocopyArgs += "/E"}
    # Enables multithreading; currently set to 8; may improve this so you can specify later
    if ($MultiThreaded) {$robocopyArgs += "/MT:8"}
    # Enables robocopy's network mode
    if ($NetworkMode) {$robocopyArgs += "/Z"}
    # Enables robocopy's backup mode
    if ($Backup) {$robocopyArgs += "/B"}
    # Enable logging; remember to specify the file when using this parameter
    if ($LogFile) {$robocopyArgs += "/LOG: `"$LogFile`""}
    # Enables move mode; removes files from source
    if ($MoveFiles) {$robocopyArgs += "/MOV"}
    # Enables move mode; removes files and folders from source
    if ($MoveAll) {$robocopyArgs += "/MOVE"}
    # Enables monitoring; robocopy will monitor source at specified intervals and copy changes
    if ($Monitor) {$robocopyArgs += "/MON:$Monitor"}

    Start-Process -FilePath $robocopyCommand -ArgumentList $robocopyArgs -NoNewWindow -Wait
}
