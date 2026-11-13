$n = 103603
$e = 17
$d = 12113

function Encode-RSA {
    param ($message, $n, $e)

    return ($([bigint]::ModPow($message, $e, $n)))
} # RSA 암호화

function Decode-RSA {
    param ($message, $n, $d)

    return ($([bigint]::ModPow($message, $d, $n)))
} # RSA 복호화

$results = Get-Content -Path ".\results.txt"
$arr = $results -split " " # 점수 리스트 입력

$results_list = $arr | ForEach-Object { Decode-RSA -message $_ -n $n -d $d }