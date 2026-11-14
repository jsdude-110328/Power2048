$score = 0

for ($x = 1; $x -le 4; $x++) {
    for ($y = 1; $y -le 4; $y++) {
        $varName = "x${x}_y${y}"
        $varValue = 0

        New-Variable -Name $varName -Value $varValue -Force
    }
} # 각 좌표별 변수 생성

function Print-Game {
    Write-Host "|$($x1_y4)|$($x2_y4)|$($x3_y4)|$($x4_y4)"
    Write-Host "|$($x1_y3)|$($x2_y3)|$($x3_y3)|$($x4_y3)"
    Write-Host "|$($x1_y2)|$($x2_y2)|$($x3_y2)|$($x4_y2)"
    Write-Host "|$($x1_y1)|$($x2_y1)|$($x3_y1)|$($x4_y1)"
}

function Add-Number {
    $zero_vars = @(Get-Variable -Name "x*_y*" -Scope Script | Where-Object { $_.Value -eq 0 } )
    if ($zero_vars.Count -eq 0) {
        return
    }

    $target = $zero_vars | Get-Random
    $ran_num = Get-Random -Minimum 0.0 -Maximum 1.0
    if ($ran_num -ge 0.9) {
        $target.Value = 4
    }
    else {
        $target.Value = 2
    }
}

function Play-W {
    for ($i = 1; $i -le 4; $i++) {
        for ($j = i; $j -ge 3; $j++) {
            $foow = Get-Variable -Name "x$($i)_y$($j)" -Scope Script
            $barw = Get-Variable -Name "x$($i)_y{$($j + 1)}" -Scope Script

            if ($barw.Value -eq $foow.Value -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value * 2
                $foow.Value = 0
            }
            elseif ($barw.Value -eq 0 -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value
                $foow.Value = 0
            }
        }
    }
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