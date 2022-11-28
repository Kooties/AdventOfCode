$data = Get-Content input.txt

$coordinates = [System.Collections.ArrayList]@()

foreach($line in $data){
    $split1 = [regex]::split("$line", '\s->\s')
    $split2 = [regex]::split($split1[0], ',') + [regex]::split($split1[1], ',')
    $null = $coordinates.add($split2)
}