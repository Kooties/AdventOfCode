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
        }else{
            $one++
        }
    }
        if($zero -gt $one){
            $workingNumber += "0"
            $workingNumber2 += "1"
        }else{
            $workingNumber += "1"
            $workingNumber2 += "0"
        
    }
}

$gammaRate = $workingNumber -as [int]
$epsilonRate = $workingNumber2 -as [int]

$powerConsumption = $gammaRate * $epsilonRate
return $powerConsumption
