$score = 0

for ($x = 1; $x -le 4; $x++) {
    for ($y = 1; $y -le 4; $y++) {
        $varName = "x${x}_y${y}"
        $varValue = 0

        New-Variable -Name $varName -Value $varValue -Force
    }
} # 각 좌표별 변수 생성

function Numbers {
    Write-Host "|$($x1_y4)|$($x2_y4)|$($x3_y4)|$($x4_y4)|"
    Write-Host "|$($x1_y3)|$($x2_y3)|$($x3_y3)|$($x4_y3)|"
    Write-Host "|$($x1_y2)|$($x2_y2)|$($x3_y2)|$($x4_y2)|"
    Write-Host "|$($x1_y1)|$($x2_y1)|$($x3_y1)|$($x4_y1)|"
}

function Add-Stuff {
    $zero_vars = @(Get-Variable -Name "x*_y*" -Scope Script | Where-Object { $_.Value -eq 0 } )
    if ($zero_vars.Count -eq 0) {
        return
    }

    $target = $zero_vars | Get-Random # 0인것들 중 랜덤하게 하나 뽑아서 2나 4로 만드는 코드
    $ran_num = Get-Random -Minimum 0.0 -Maximum 1.0
    if ($ran_num -ge 0.9) {
        $target.Value = 4
    }
    else {
        $target.Value = 2
    }
}

function Move-Up {
    # Move-**** 함수들은 모두 각 이동키마다의 동작 정의 (위/아래/왼/오)
    param ([ref]$score)

    for ($i = 1; $i -le 4; $i++) {
        for ($j = 1; $j -le 3; $j++) {
            $foow = Get-Variable -Name "x$($i)_y$($j)" -Scope Script
            $barw = Get-Variable -Name "x$($i)_y$($j + 1)" -Scope Script

            if ($barw.Value -eq $foow.Value -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value * 2
                $score.Value += $barw.Value
                $foow.Value = 0
            }
            elseif ($barw.Value -eq 0 -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value
                $foow.Value = 0
            }
        }
    }
}

function Move-Down {
    param ([ref]$score)

    for ($i = 1; $i -le 4; $i++) {
        for ($j = 4; $j -ge 2; $j--) {
            $foow = Get-Variable -Name "x$($i)_y$($j)" -Scope Script
            $barw = Get-Variable -Name "x$($i)_y$($j - 1)" -Scope Script

            if ($barw.Value -eq $foow.Value -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value * 2
                $score.Value += $barw.Value
                $foow.Value = 0
            }
            elseif ($barw.Value -eq 0 -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value
                $foow.Value = 0
            }
        }
    }
}

function Move-Right {
    param ([ref]$score)

    for ($j = 1; $j -le 4; $j++) {
        for ($i = 1; $i -le 3; $i++) {
            $foow = Get-Variable -Name "x$($i)_y$($j)" -Scope Script
            $barw = Get-Variable -Name "x$($i + 1)_y$($j)" -Scope Script

            if ($barw.Value -eq $foow.Value -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value * 2
                $score.Value += $barw.Value
                $foow.Value = 0
            }
            elseif ($barw.Value -eq 0 -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value
                $foow.Value = 0
            }
        }
    }
}

function Move-Left {
    param ([ref]$score)

    for ($j = 1; $j -le 4; $j++) {
        for ($i = 4; $i -ge 2; $i--) {
            $foow = Get-Variable -Name "x$($i)_y$($j)" -Scope Script
            $barw = Get-Variable -Name "x$($i - 1)_y$($j)" -Scope Script

            if ($barw.Value -eq $foow.Value -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value * 2
                $score.Value += $barw.Value
                $foow.Value = 0
            }
            elseif ($barw.Value -eq 0 -and $foow.Value -ne 0) {
                $barw.Value = $foow.Value
                $foow.Value = 0
            }
        }
    }
}