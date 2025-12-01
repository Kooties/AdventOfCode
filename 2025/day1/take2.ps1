$rawData = get-content testinput.txt
$outfile = ".\testoutput.txt"

$startingNumber = 50
$zeroCount = 0
$zeroTouch = 0

Add-Content -path $outfile -Value "The dial starts by pointing at $startingNumber"

foreach($data in $rawData){
    $roundOne = $true
    
    $alreadyCounted = $false
    if($data -match 'L'){
        $add = $false
    }else{
        $add = $true
    }
    $number = [int]$data.substring(1,$data.length-1)

    if($add){
        $startingNumber += $number
    }else{
        $startingNumber -= $number
    }

    while($startingNumber -gt 99){
        $zeroTouch++
        $alreadyCounted = $true
        $startingNumber -= 100
    }

    while($startingNumber -lt 0){
        if(([Math]::Abs($startingNumber) -eq $number) -and $roundOne){
            $zeroTouch--
        }
        $zeroTouch++
        $alreadyCounted = $true
        $startingNumber += 100
        $roundOne = $false
    }

    if($startingNumber -eq 0){
        $zeroCount ++
        if(!$alreadyCounted){
            $zeroTouch ++
        }
    }
    Add-Content -path $outfile -Value "The dial moved $data and ended on $startingNumber"
    Add-Content -path $outfile -Value "It has landed on zero $zeroCount times, and touched zero $zeroTouch times"
    
}

#6255 too low; 6814 too high

Write-Host "Landed on zero $zeroCount times, and touched zero $zeroTouch times"