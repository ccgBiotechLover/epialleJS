#输出每个样本特异的表观等位
sub unique_alle{
	my ($ou,%uniloci) = @_;
	#my $ou = $_[0];
	#my %uniloci = $_[1];
	#my %pattern = $_[2];
	open FF,">","$ou" or die "cannot open resultfile when output unique_alle:$!\n";
	print FF "chr\tstart\tend\tstrand\tloci\tmethy\tp:0000\tp:0001\tp:0010\tp:0011\tp:0100\tp:0101\tp:0110\tp:0111\tp:1000\tp:1001\tp:1010\tp:1011\tp:1100\tp:1101\tp:1110\tp:1111\tdepth\n";
	#open F2,">","$out2" or die "cannot open resultfile:$!\n";
	foreach $loci (sort{$a cmp $b} keys %uniloci){
		@p1 = split(/\t/,$uniloci{$loci});
		$freq1 = @p1;
		#print "1\n";
		if($freq1 >= $cov){	
			foreach $loci1 (keys %pattern1){
				$pattern1{$loci1} = 0;
			}
			for($i=0;$i<$freq1;$i++){
				$pattern1{$p1[$i]}++;
			}
			$count1 = 0;
			$patnum1 = "";
			#$patnum2 = "";
			foreach $loci1(sort{$a cmp $b} keys %pattern1){
				$count1 += $pattern1{$loci1} * $meth1{$loci1};
				$patnum1 = "$patnum1\t$pattern1{$loci1}";
			}
			$methy1 = 100.0 * $count1/$freq1/4.0;
			print FF "$loci\t$methy1$patnum1\t$freq1\n";
		}
	} 
	close(FF);
}
1;