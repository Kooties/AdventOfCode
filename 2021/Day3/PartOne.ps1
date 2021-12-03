$data = Get-Content input.txt
$columns = 0..($data[0].Length - 1)
$workingNumber = "0b"
$workingNumber2 = "0b"

foreach($column in $columns){
    $zero = 0
    $one = 0
    foreach($line in $data){

        if($line[$column] -eq "0"){
            $zero++
            #Write-Host ($line[$column]) "is 0 and 0's count is $zero"
        }else{
            $one++
            #Write-Host ($line[$column]) "is 1 and 1's count is $one"
        }
    }
        if($zero -gt $one){
            $workingNumber += "0"
            $workingNumber2 += "1"
            $outputNumber = $workingnumber[$column+2]
            #Write-Host "Working number is currently $outputNumber"
        }else{
            $workingNumber += "1"
            $workingNumber2 += "0"
            $outputNumber = $workingnumber[$column+2]
            #Write-Host "Working number is currently $outputNumber"
        
    }
}

$gammaRate = $workingNumber -as [int]
$epsilonRate = $workingNumber2 -as [int]

$powerConsumption = $gammaRate * $epsilonRate
return $powerConsumption
