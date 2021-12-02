function get-TreesHit {
    param (
        [int]$right,
        [int]$down
    )

    $i = 1
    $x = 0
    $treesHit = 0

    foreach($line in $file){
        if($i -ne 1){
            $x = ($x + $right)
            if($x -lt $line.length){
                $y = $x
            }else{
                $y = ($x % $line.length)
            }
            if($line[$y] -eq '#'){
                $treesHit++
                Write-Host "tree hit on $right, $down, row $i"
            }
        }
        $i += $down
    }
    return $treesHit
}

$first = Get-TreesHit -right 1 -down 1
$second = Get-TreesHit -right 3 -down1
$third = Get-TreesHit -right 5 -down 1
$fourth = Get-TreesHit -right 7 -down 1
$fifth = Get-TreesHit -right 1 -down 2
$multi = ($first * $second * $third * $fourth * $fifth)

Write-Host "The first route would hit $first trees, the second $second trees, the third $third trees, the fourth $fourth trees, and the fifth $fifth trees"
Write-Host "The multiplication would have you hit $multi trees"