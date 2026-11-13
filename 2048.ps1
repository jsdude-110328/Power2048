$score = 0
$zero_list = @()

for ($x = 1; $x -le 4; $x++) {
    for ($y = 1; $y -le 4; $y++) {
        $varName = "x${x}_y${y}"
        $varValue = 0

        New-Variable -Name $varName -Value $varValue -Force
    }
}

function Add-Number {
    param ([ref]$zero_list)

    $zero_list.Value = @(Get-Variable -Name "x*_y*" | Where-Object { $_ -eq 0 })
    $make_two = $zero_list.Value | Get-Random -Count 2
}

function Play-Game {

    Write-Host "명령을 입력하세요: W/A/S/D. "
    $ans = Read-Host
    switch ($ans) {
        "W" { Write-Host "W" }
        "A" { Write-Host "A" }
        "S" { Write-Host "S" }
        "D" { Write-Host "D" }
        default { Write-Host "오류입니다." }
    }
}

Add-Number