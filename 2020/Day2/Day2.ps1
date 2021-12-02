$passwords = (get-content Day2Input.txt)
#$passwords = (get-content Day2Test.txt)
$validPasswords = 0

foreach($password in $passwords){
    $hyphen = $password.IndexOf("-")
    $space = $password.IndexOf(" ")
    $colon = $password.IndexOf(":")
    $letter = $password[($colon-1)] -as [string[]]
    $highestNumber = $password.substring($hyphen+1, ($colon - $space))
    if($hyphen -lt 1){
        $lowestNumber = $password[0]
    }else{
        $lowestNumber = ($password.substring(0,$hyphen))
    }
    $repetitions = [regex]::matches($password,$letter).count
    $repetitions--
    if(($repetitions -ge $lowestNumber) -and ($repetitions -le $highestNumber)){
        $validPasswords++
    }
}
Write-Host "The number of valid passwords at the old job is $validPasswords"
$realValidPasswords = 0
$count = 1
foreach($password in $passwords){
    $hyphen = $password.IndexOf("-")
    $space = $password.IndexOf(" ")
    $colon = $password.IndexOf(":")
    $letter = $password[($colon-1)]
    $highestNumber = $password.substring($hyphen+1, ($colon - $space))
    if($hyphen -lt 1){
        $lowestNumber = $password[0]
    }else{
        $lowestNumber = ($password.substring(0,$hyphen))
    }
    if($password[$colon + $lowestNumber + 1] -ne $letter){
        if($password[$colon + $highestNumber + 1] -eq $letter){
            $realValidPasswords++
            #Write-Host "Entry $count is valid as the second letter matches"
        }
    }elseif($password[$colon + $lowestNumber + 1] -eq $letter){
        if($password[$colon + $highestNumber + 1] -ne $letter){
            $realValidPasswords++
            #Write-Host "Entry $count is valid as the first letter matches"
        }
    }
    #Write-Host "Entry $count is invalid"
    $count++
}
Write-Host "The number of actual valid passwords is $realValidPasswords"