$rawData = Get-Content example.txt
 <#Safe reports are lines where the numbers are either increasing or decreasing by between 1 and 3 through the whole line#>
$safeLines = 0

foreach($line in $rawData){
    $reports = $line.split(" ")
    $Safe = $true
    [bool]$increasing
    [bool]$decreasing
    $errorCount = 0
    $count = $reports.count
    foreach($report in $reports){
        $regex = $report
        if($regex.matches($reports).count -gt 1){
            $safe = $false
        }elseif($regex.matches($reports).count -eq 1){
            
        }
    }
    
    if($Safe){
        $safeLines++
        Write-Host "Line $line is safe"
    }
}