function Expand-Data([string]$string){
    $idNumber = 0
    $arrayList = [System.Collections.ArrayList]@()
    for($i=0; $i -lt $string.length; $i++){
        #Write-Host "Working on Index $i"
        if($i%2 -eq 0){
            #Write-Host "ID Number is currently $idNumber"
            $numberToAdd = ([int]$string[$i] - 48)
            #Write-Host "Times to add is $numberToAdd"
            for($x=0; $x -lt $numberToAdd; $x++){
                $arrayList.Add([string]$idNumber) | Out-Null
            }
            $idNumber++
        }else{
            #Write-Host "At a blank section"
            $numberBlankBlocks = ([int]$string[$i] - 48)
            #Write-Host "Number of Blanks is $numberBlankBlocks"
            for($y=0; $y -lt $numberBlankBlocks; $y++){
                $arrayList.Add(".") | Out-Null
            }
        }
    }
    return $arrayList
}

function Compress-DataPart1($data){
    [System.Collections.ArrayList]$dataClone = $data
    $returnData = [System.Collections.ArrayList]@()
    for($i=0; $i -lt $data.count; $i++){
            if($data[$i] -notlike '.'){
                    #Write-Host "Not an empty block"
                    $returnData.Add($data[$i]) | Out-Null
            }elseif($data[$i] -like '.'){
                #Write-Host "Processing empty space"
                while($dataClone[-1] -like '.'){
                    #Write-Host "Backtracking also has an empty spot"
                    $dataClone.RemoveAt($dataClone.count - 1) | Out-Null
                }
                #Write-Host "Found a match"
                $returnData.Add($dataClone[-1]) | Out-Null
                $dataClone.RemoveAt($dataClone.count - 1) | Out-Null
            }
    }

    $count = [regex]::Matches($data,'\.').count
    for($x=1; $x -le $count; $x ++){
        $returnData[-$x] = '.'
    }
    return $returnData
}

function Compress-DataPart2($data){
    [System.Collections.ArrayList]$dataClone = $data
    $dataCounts = [System.Collections.ArrayList]@()

}
function Get-Checksum($data){
    $sum = 0
    for($i=0; $i -lt $data.length; $i++){
        if($data[$i] -notlike '.'){
            #Write-Host "Index is $i"
            $num = ([int]$data[$i])
            #Write-Host "Number is $num"
            $amount = $num * $i
            #Write-Host "Total is $amount"
            $sum += $amount
            #Write-Host "Sum is now $sum"
        }
    }
    return $sum
}

$rawData = get-content example.txt

$expandedData = Expand-Data -string $rawData

$compressedDataPart1 = Compress-DataPart1 -data $expandedData

$part1Checksum = Get-Checksum -data $compressedDataPart1
#$compressedDataPart2 = CompressDataPart2 -data $expandedData
#$part2Chekcsum = Get-Checksum -data $compressedDataPart2

Write-Host "Checksum for Part 1 is $part1Checksum"
#Write-Host "Checksum for Part 2 is $part2Checksum"