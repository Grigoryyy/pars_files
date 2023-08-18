#!/usr/bin/powershell -Command
param (
    [Parameter(Mandatory=$true)]
    [string]$InputDirectory,

    [Parameter(Mandatory=$true)]
    [string]$OutputDirectory
)

if (-not ($InputDirectory -and $OutputDirectory)) {
    Write-Host "Usage: script.ps1 -InputDirectory <input_directory> -OutputDirectory <output_directory>"
    exit
}

# Создание отчета
$report = @()
$files = Get-ChildItem -Path $InputDirectory -Recurse -File

foreach ($file in $files) {
    $size = [math]::Round($file.Length / 1MB, 2)
    $extension = $file.Extension.TrimStart('.')
    $name = $file.Name

    # Если расширение отсутствует, устанавливаем значение "no_extension"
    if ([string]::IsNullOrEmpty($extension)) {
        $extension = "no_extension"
    }

    # Проверяем, существует ли уже запись для данного расширения
    $existingEntry = $report | Where-Object { $_.Extension -eq $extension }

    if ($existingEntry) {
        $existingEntry.Size += $size
    } else {
        $entry = [PSCustomObject]@{
            Name = $name
            Extension = $extension
            Size = $size
        }
        $report += $entry
    }
}

# Сортировка по убыванию суммарного размера
$report = $report | Sort-Object -Property Size -Descending

# Получение топ 10 самых больших типов файлов
$top10 = $report | Select-Object -First 10

# Создание текстового отчета
$reportText = "filename`tTotal volume in Mb`n"
foreach ($entry in $top10) {
    $reportText += "$($entry.Name)`t$($entry.Size)`n"
}

# Сохранение отчета в файл
$reportText | Out-File -FilePath "$OutputDirectory\report.txt"
Write-Host "Report saved to $OutputDirectory\report.txt"
