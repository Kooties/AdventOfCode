$file = (get-content Day1Input.txt) -as [int[]]
$answer=@()
foreach($number in $file){
    foreach($number2 in $file){
        foreach($number3 in $file){
            if(($number + $number2 + $number3) -eq 2020){
            $answer = $number*$number2*$number3
            Write-Host "Answer is $answer"
            break
            }
        }
    }
}