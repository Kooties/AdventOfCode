# 71-97,71-72
# 49-74,22-92

$rawData = Get-Content input.txt
$totalFullyContained = 0
$totalOverlapped = 0
foreach($line in $rawData){
    $elfSplit = $line.split(',')
    $elf1 = $elfSplit[0].split('-')
    $elf2 = $elfSplit[1].split('-')
    $elf1p1 = [int]$elf1[0]
    $elf1p2 = [int]$elf1[1]
    $elf2p1 = [int]$elf2[0]
    $elf2p2 = [int]$elf2[1]
    if((($elf1p1 -le $elf2p1) -and ($elf1p2 -ge $elf2p2)) -or (($elf2p1 -le $elf1p1) -and ($elf2p2 -ge $elf1p2))){
        $totalFullyContained++
    }
    if((($elf1p1 -ge $elf2p1) -and ($elf1p1 -le $elf2p1)) -or (($elf1p2 -ge $elf2p1) -and ($elf1p2 -le $elf2p2)) -or (($elf2p1 -ge $elf1p1) -and ($elf2p1 -le $elf1p2)) -or (($elf2p2 -ge $elf1p1) -and ($elf2p2 -le $elf1p2))){
        $totalOverlapped++
    }
}

Write-Host "Number of fully contained jobs is $totalFullyContained`nNumber of overlapped duties is $totalOverlapped"