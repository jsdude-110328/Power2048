$n = 103603
$e = 17
$d = 12113

function Encode {
    param ($message, $n, $e)

    return ($([bigint]::ModPow($message, $e, $n)))
} # RSA 암호화

function Decode {
    param ($message, $n, $d)

    $cipher = [bigint]::Parse($message)
    return [long]([bigint]::ModPow($cipher, $d, $n))
}

$results = Get-Content -Path ".\results.txt" -Raw

$arr = $results -split "\s+" | Where-Object { $_ -ne "" }  

$main_list = $arr | ForEach-Object { Decode -message $_ -n $n -d $d }
if ($main_list.Count -eq 0) {
    $max_value = 0
}
else {
    $max_value = ($main_list | Measure-Object -Maximum).Maximum
}