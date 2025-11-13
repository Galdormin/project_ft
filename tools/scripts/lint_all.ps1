$Root = ".."
$ExcludeDirs = @("addons", "build", ".git")

$files = Get-ChildItem -Path $Root -Recurse -Filter *.gd -File |
    Where-Object {
        $full = $_.FullName
        $exclude = $false

        foreach ($ex in $ExcludeDirs) {
            if ($full -like "*\${ex}\*") {
                $exclude = $true
                break
            }
        }

        -not $exclude
    } |
    Select-Object -Expand FullName

if (-not $files -or $files.Count -eq 0) {
    Write-Host "Aucun fichier .gd trouvé (après exclusions)."
    exit 0
}

Write-Host "File found:"
$files | ForEach-Object { Write-Host "  $_" }

Write-Host ""
& "gdscript-formatter" "lint" "--pretty" @files

Write-Host ""
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');