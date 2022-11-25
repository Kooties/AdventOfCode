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
        Write-Host "Writing Card #" + ((($i-2)/6)+1)
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
    
}