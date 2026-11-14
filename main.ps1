. ./2048.ps1
. ./results.ps1

function Quit {
    $encoded = Encode -message $score -n $n -e $e
    Add-Content -Path "./results.txt" -Value "`r`n$($encoded)"; Write-Host "게임을 종료합니다."; exit
}

function Main {
    while ($true) {
        Numbers
        Add-Stuff

        Write-Host "현재 점수: $($score). 최대 점수: $($max_value)."
        $ans = (Read-Host -Prompt "W로 위로, A로 왼쪽으로, S로 아래로, D로 오른쪽으로 가세요. Q를 누르면 종료됩니다.").ToUpper()
        switch ($ans) {
            "W" { Move-Up -score ([ref]$score) }
            "A" { Move-Left -score ([ref]$score) }
            "S" { Move-Down -score ([ref]$score) }
            "D" { Move-Right -score ([ref]$score) }
            "Q" { Quit }
            default { Write-Host "오류입니다." }
        }
    }
}

Main