$data = Get-Content input.txt

$days = 1..80

$splitInput = $data.split(',')

$sanitizedInput = [System.Collections.ArrayList]@()

foreach($thing in $splitInput){
    $null = $sanitizedInput.Add(([int]::parse($thing)))
}
$newFish = [System.Collections.ArrayList]@()
$newList = [System.Collections.ArrayList]@()
foreach($day in $days){
    foreach($num in $sanitizedInput){
        if($num -eq 0){
            $null = $newFish.Add('x')
            $null = $newList.Add(6)
        }else{
            $null = $newList.Add(($num-1))
        }
    }
    foreach($fish in $newFish){
        $null = $newList.Add(8)
    }
    $newFish.clear()
    $sanitizedInput.clear()
    foreach($thing in $newList){
        $sanitizedInput.add($thing)
    }
    $newList.clear()
}