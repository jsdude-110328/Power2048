. ./2048.ps1
. ./results.ps1

function Quit {
    $smaller = $score -le 100000
    $encoded = switch ($smaller) {
        ($smaller -eq $true) { Encode -message $score -n $n -e $e }
        default { Encode -message 100000 -n $n -e $e }
    } # 점수 최대치 설정 (100000)
    Add-Content -Path "./results.txt" -Value "`r`n$($encoded)"; Write-Host "게임을 종료합니다."
}

function Game {
    # 게임 메인 로직 설정
    :GameLoop while ($true) {
        Numbers
        Add-Stuff

        Write-Host "현재 점수: $($score). 최대 점수: $($max_value)."
        $ans = (Read-Host -Prompt "W로 위로, A로 왼쪽으로, S로 아래로, D로 오른쪽으로 가세요. Q를 누르면 종료됩니다.").ToUpper()
        switch ($ans) {
            "W" { Move-Up -score ([ref]$score) }
            "A" { Move-Left -score ([ref]$score) }
            "S" { Move-Down -score ([ref]$score) }
            "D" { Move-Right -score ([ref]$score) }
            "Q" { Quit; break GameLoop }
            default { Write-Host "오류입니다." }
        }
    }
}

function Main {
    # 프로그램 기본 로직 (게임 로직과는 별개)
    while ($true) {
        $ans = (Read-Host -Prompt "Power2048을 시작합니다. 1: 게임 플레이. 2: 통계 출력. Q. 게임 종료.").ToUpper()
        switch ($ans) {
            "1" { Game }
            "2" { Write-Host "전체 플레이 횟수: $($main_list.Count)회. 점수 평균: $($avv)점." }
            "Q" { Write-Host "프로그램을 종료합니다."; exit }
            default { Write-Host "오류입니다." }
        }
    }
}

Main