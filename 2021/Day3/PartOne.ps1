$data = Get-Content testinput.txt
$columns = $data[0].Length
$workingNumber = ""

foreach($column in $columns){
    $column -= 1
    $zero = 0
    $one = 0
    foreach($line in $data){

        if($line[$column] -eq "0"){
            $zero++
            Write-Host ($line[$column]) "is 0 and 0's count is $zero"
        }else{
            $one++
            Write-Host ($line[$column]) "is 1 and 1's count is $one"
        }
    }
        if($zero -gt $one){
            $workingNumber.$column+= "0"
            $outputNumber = $workingnumber[$column]
            Write-Host "Working number is currently $outputNumber"
        }else{
            $workingNumber.$column+= "1"
            $outputNumber = $workingnumber[$column]
            Write-Host "Working number is currently $outputNumber"
        
    }
}
$substring1 = ($workingNumber[$column].length / 2) -1

$gammaRateStr = $workingNumber[$column].substring($substring1)


