sub pattern_meth{
	for ($i=0;$i<2;$i++){
		for($k=0;$k<2;$k++){
			for($j=0;$j<2;$j++){
				for($n=0;$n<2;$n++){
					$index = "$i$k$j$n";
					$pattern1{$index} = 0;
					$meth1{$index} = $i+$k+$j+$n;
					$pattern2{$index} = 0;
				}
			}
		}
	}	
}
1;