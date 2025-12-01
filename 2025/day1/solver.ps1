$rawData = get-content input.txt
$outfile = ".\output.txt"

$startingNumber = 50
$zeroCount = 0
$zeroTouch = 0

#Add-Content -path $outfile -Value "The dial starts by pointing at $startingNumber"

foreach($data in $rawData){
    $add = $true
    $touch = $false
    #$end = $false
    if($data -match 'L'){
        $add = $false
    }
    #Add-Content -path $outfile -value "Starting value is $startingNumber; will be rotated $data"
    $number = [int]$data.substring(1,$data.length-1)

    if($startingNumber -eq 0){
        if($add){
            $startingNumber = $number
        }else{
            $startingNumber = 100-$number
        }
    }elseif($add){
        $startingNumber += $number
    }else{
        $startingNumber -= $number
    }

    if($startingNumber -lt 0){
            $touch = $true
        while($startingNumber -lt 0){
            $startingNumber += 100
            $zeroTouch ++
        #Add-Content -path $outfile -value "The dial has now touched zero $zeroTouch times L37"
        }
    }elseif($startingNumber -gt 99){
            $touch = $true
        while($startingNumber -gt 99){
            $startingNumber -= 100
            $zeroTouch ++
        #Add-Content -path $outfile -value "The dial has now touched zero $zeroTouch times L44"
        }
    }
    <#if($startingNumber -eq 0){
                $zeroCount ++
                $end = $true
                #Add-Content -path $outfile -value "The dial has now reached zero $zeroCount times L50" 
            }#>
    #Add-Content -path $outfile -Value "The dial has been rotated $data to point at $startingNumber L52"
    if(($startingNumber -eq 0) <#-and ($end -eq $false)#>){
        $zeroCount ++
        if(!$touch){
            $zeroTouch ++
        }
        #Add-Content -path $outfile -value "The dial has now reached zero $zeroCount times L58"
    }
}

#432 too low
#6255 too low; 6814 too high

Write-Host "Reached zero $zeroCount times"
Write-Host "Touched zero a total of $zeroTouch times"