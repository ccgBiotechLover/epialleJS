sub common_alle{
	open RES,">","$out3" or die "cannot open resultfile when output common_alle:$!\n";
	print RES "chr\tstart\tend\tstrand\tloci\tJSD\tmeth1\tmeth2\tp1:0000\tp1:0001\tp1:0010\tp1:0011\tp1:0100\tp1:0101\tp1:0110\tp1:0111\tp1:1000\tp1:1001\tp1:1010\tp1:1011\tp1:1100\tp1:1101\tp1:1110\tp1:1111\tp2:0000\tp2:0001\tp2:0010\tp2:0011\tp2:0100\tp2:0101\tp2:0110\tp2:0111\tp2:1000\tp2:1001\tp2:1010\tp2:1011\tp2:1100\tp2:1101\tp2:1110\tp2:1111\tdepth1\tdepth2\n";
	foreach $loci(sort{$a cmp $b} keys %locimeth1){
		if(exists $locimeth2{$loci}){
			@p1 = split(/\t/,$locimeth1{$loci});
			@p2 = split(/\t/,$locimeth2{$loci});
			$freq1 = @p1;
			$freq2 = @p2;
			if($freq1 >= $cov && $freq2 >= $cov){
				foreach $loci1 (keys %pattern1){
						 $pattern1{$loci1} = 0;
						 $pattern2{$loci1} = 0;
				}
				#sample1
				for($i=0;$i<$freq1;$i++){
					$pattern1{$p1[$i]}++;
				}
				#sample2
				for($i=0;$i<$freq2;$i++){
					$pattern2{$p2[$i]}++;
				}
				$count1 = 0;
				$HA = 0;
				$patnum1 = "";
				$count2 = 0;
				$HB = 0;
				$patnum2 = "";
				$HAB = 0;
				foreach $loci1(sort{$a cmp $b} keys %pattern1){#{sort $a <=> $b}
					$count1 += $pattern1{$loci1} * $meth1{$loci1};
					$count2 += $pattern2{$loci1} * $meth1{$loci1};
					$patnum1 = "$patnum1\t$pattern1{$loci1}";
					$patnum2 = "$patnum2\t$pattern2{$loci1}";
					$pattern1{$loci1} = $pattern1{$loci1}/$freq1 + (6.25e-7);
					$pattern2{$loci1} = $pattern2{$loci1}/$freq2 + (6.25e-7);
					$HH = ($pattern1{$loci1}+$pattern2{$loci1})/2;
					$HA += $pattern1{$loci1}*(log($pattern1{$loci1})/log(2));
					$HB += $pattern2{$loci1}*(log($pattern2{$loci1})/log(2));
					$HAB += $HH*(log($HH)/log(2));
				}
				$methy1 = 100.0 * $count1/$freq1/4.0;
				$methy2 = 100.0 * $count2/$freq2/4.0;
				$JS = ($HA+$HB)/2-$HAB;
				$JSD = sqrt($JS);
				print RES "$loci\t$JSD\t$methy1\t$methy2$patnum1$patnum2\t$freq1\t$freq2\n";
			}
		}
	}
	close(RES);
}
1;