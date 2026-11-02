# Compatible with Windows PowerShell 5.1.
$ErrorActionPreference = 'Stop'
$pocetHodu = 1000
$cetnosti = @(0, 0, 0, 0, 0, 0)

for ($i = 0; $i -lt $pocetHodu; $i++) {
    $hod = Get-Random -Minimum 1 -Maximum 7
    $cetnosti[$hod - 1]++
}

$soucet = ($cetnosti | Measure-Object -Sum).Sum
if ($soucet -ne $pocetHodu) {
    throw "Chyba: soucet cetnosti je $soucet, ocekavano $pocetHodu."
}

$tabulka = for ($hodnota = 1; $hodnota -le 6; $hodnota++) {
    [PSCustomObject]@{
        Hodnota = $hodnota
        Pocet = $cetnosti[$hodnota - 1]
        Procenta = '{0:F1} %' -f (100.0 * $cetnosti[$hodnota - 1] / $pocetHodu)
    }
}

$tabulka | Format-Table -AutoSize
Write-Output "Kontrola OK: soucet cetnosti je $soucet (ocekavano $pocetHodu)."
