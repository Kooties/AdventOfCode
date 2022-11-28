class bingoCard
{
    [ValidateNotNullOrEmpty()][array]$row1
    [ValidateNotNullOrEmpty()][array]$row2
    [ValidateNotNullOrEmpty()][array]$row3
    [ValidateNotNullOrEmpty()][array]$row4
    [ValidateNotNullOrEmpty()][array]$row5
}

$data = Get-Content -Path .\input.txt

$numberString = $data[0].Split(",")
$calledNumbers = foreach($number in $numberString){([int]::parse($number))}
$allCards = [System.Collections.ArrayList]@()

for($i=2; $i -lt $data.length; $i++){
    if((($i - 2)%6) -eq 0){
        $1 = $data[$i] -split "[\s]{1,}"
        $2 = $data[$i+1] -split "[\s]{1,}"
        $3 = $data[$i+2] -split "[\s]{1,}"
        $4 = $data[$i+3] -split "[\s]{1,}"
        $5 = $data[$i+4] -split "[\s]{1,}"
        $1split = foreach($number in $1){([int]::parse($number))}
        $2split = foreach($number in $2){([int]::parse($number))}
        $3split = foreach($number in $3){([int]::parse($number))}
        $4split = foreach($number in $4){([int]::parse($number))}
        $5split = foreach($number in $5){([int]::parse($number))}
        #Write-Host "Writing Card #" + ((($i-2)/6)+1)
        $card = [bingoCard]@{
            row1 = $1split
            row2 = $2split
            row3 = $3split
            row4 = $4split
            row5 = $5split
        }
        $null = $allCards.Add($card)
    }
}

foreach($number in $calledNumbers){
    foreach($card in $allCards){
        if($card.row1[0] -is [int]){
        for($j=0;$j -lt 5;$j++){
            if($card.row1[$j] -eq $number){
                $card.row1[$j] = 0
                #Write-Host "Match Detected"
            }
            if($card.row2[$j] -eq $number){
                $card.row2[$j] = 0
                #Write-Host "Match Detected"
            }
            if($card.row3[$j] -eq $number){
                $card.row3[$j] = 0
                #Write-Host "Match Detected"
            }
            if($card.row4[$j] -eq $number){
                $card.row4[$j] = 0
                #Write-Host "Match Detected"
            }
            if($card.row5[$j] -eq $number){
                $card.row5[$j] = 0
                #Write-Host "Match Detected"
            }
        }
        $row1total = $card.row1[0] + $card.row1[1] + $card.row1[2] + $card.row1[3] + $card.row1[4]
        $row2total = $card.row2[0] + $card.row2[1] + $card.row2[2] + $card.row2[3] + $card.row2[4]
        $row3total = $card.row3[0] + $card.row3[1] + $card.row3[2] + $card.row3[3] + $card.row3[4]
        $row4total = $card.row4[0] + $card.row4[1] + $card.row4[2] + $card.row4[3] + $card.row4[4]
        $row5total = $card.row5[0] + $card.row5[1] + $card.row5[2] + $card.row5[3] + $card.row5[4]

        if(($row1total -eq 0) -or ($row2total -eq 0) -or ($row3total -eq 0) -or ($row4total -eq 0) -or ($row5total -eq 0)){
            $sum = $row1total + $row2total + $row3total + $row4total + $row5total
            $winningNumber = $sum*$number
            Write-Host "$card`n$sum x $number = $winningNumber"
            $card.row1[0] = "x"
        }

        for($k=0;$k -lt 5;$k++){
            $rowTotal = $card.row1[$k] + $card.row2[$k] +$card.row3[$k] +$card.row4[$k] +$card.row5[$k]
            if($rowTotal -eq 0){
                $sum = $row1total + $row2total + $row3total + $row4total + $row5total
                $winningNumber = $sum*$number
                Write-Host $card.row1 `n $card.row2 `n $card.row3 `n $card.row4 `n $card.row5 `n "`n$sum x $number = $winningNumber"
                $card.row1[0] = "x"
            }
        }
    }
}
}