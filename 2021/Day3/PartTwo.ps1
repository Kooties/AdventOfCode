$data = Get-Content testinput.txt
$columns = 0..($data[0].Length - 1)

[System.Collections.ArrayList]$oxy=@()
[System.Collections.ArrayList]$co2=@()

$ones = 0
$zeroes = 0
[System.Collections.ArrayList]$ayes=@()
[System.Collections.ArrayList]$naughts=@()

foreach($row in $data){
    if($row[0] -eq "1"){
        $ones++
        $ayes.Add($row)
    }else{
        $zeroes++
        $naughts.Add($row)
    }
}
if($ones -ge $zeroes){
    $oxy = $ayes
    $co2 = $naughts
}else{
    $oxy = $naughts
    $co2 = $ayes
}

[System.Collections.ArrayList]$removeoxy=@()
[System.Collections.ArrayList]$removeco2=@()


for(($i = 1);$i -le $columns.count; $i++){
    $ayes.Clear()
    $naughts.Clear()
    $ones = 0
    $zeroes = 0
    $removeoxy.clear()
    $removeco2.clear()
    foreach($row in $data){
        if($row[$i] -eq "1"){
            $ones++
            $ayes.Add($row)
        }else{
            $zeroes++
            $naughts.Add($row)
        }
    }
    if($ones -ge $zeroes){
        foreach($ox in $oxy){
            if($ayes -notcontains $ox){
                $removeoxy.Add($ox)
            }
        }
        foreach($remove in $removeoxy){
            $oxy.remove($remove)
        }
        foreach($co in $co2){
            if($naughts -notcontains $co){
                $removeco2.Add($co)
            }
        }
        foreach($remove in $removeco2){
            $co2.remove($remove)
        }
    }else{
        foreach($ox in $oxy){
            if($naughts -notcontains $ox){
                $removeoxy.Add($ox)
            }
        }
        foreach($remove in $removeoxy){
            $oxy.remove($remove)
        }
        foreach($co in $co2){
            if($ayes -notcontains $co){
                $removeco2.Add($co)
            }
        }
        foreach($remove in $removeco2){
            $co2.remove($remove)
        }
    }
}
  