# Ejecutar desde la raiz del repo todo-api
# Uso: .\scripts\create-issues.ps1

$issues = Get-Content -Raw -Path "docs\issues\issues.json" | ConvertFrom-Json

foreach ($issue in $issues) {
    $labels = $issue.labels -join ","
    $tmpFile = New-TemporaryFile

    # Escribimos el body a un archivo temporal en UTF8 sin BOM para que gh lo lea bien
    [System.IO.File]::WriteAllText($tmpFile.FullName, $issue.body)

    Write-Host "Creando issue: $($issue.title)"
    gh issue create --title $issue.title --label $labels --body-file $tmpFile.FullName

    Remove-Item $tmpFile.FullName
    Start-Sleep -Milliseconds 500
}

Write-Host "`nListo. Issues creados:"
gh issue list