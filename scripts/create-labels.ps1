# Ejecutar desde la raiz del repo todo-api
# Uso: .\scripts\create-labels.ps1

$labels = Get-Content -Raw -Path "docs\issues\labels.json" | ConvertFrom-Json

foreach ($label in $labels) {
    Write-Host "Creando label: $($label.name)"
    gh label create $label.name --color $label.color --description $label.description --force
}

Write-Host "`nListo. Labels creados/actualizados:"
gh label list