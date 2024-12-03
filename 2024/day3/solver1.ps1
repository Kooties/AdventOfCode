#example answer should be 161 - 2*4 + 5*5 + 11*8 + 8*5 for part One
#For part two, it's 48 - 2*4 + 8*5

$rawData = Get-Content input.txt

$regEx = "mul\(\d+,\d+\)|do\(\)|don't\(\)"
$do = 'do\(\)'
$dont = "don't\(\)"
[bool]$on = $true

$allMatches = Select-String $regEx -InputObject $rawData -AllMatches | ForEach-Object {$_.matches.Value}
$runningTotal = 0
foreach($match in $allMatches){
    #Write-Host "Parsing $match"
    if($match -match $do){
        #Write-Host "Setting On to True"
        $on = $true
    }elseif($match -match $dont){
        #Write-Host "Setting On to False"
        $on = $false
    }elseif($on){
    $split = $match.replace("mul(",'')
    $split = $split.replace(')','')
    $split = $split.split(',')
    $runningTotal += ([int]$split[0] * [int]$split[1])
    Write-Host "Multiplied " $split[0] " by " $split[1] " and current running total is $runningTotal"
    }elseif(!$on){
        #Write-Host "Set to Off"
    }
}