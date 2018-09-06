sub epialle{
	$file = $_[0];
	my $dis = $_[1];
	open SAO1,"$file" or die "cannot open samfile when recognize epialle:$!\n";
	
	scalar <SAO1> for 1..$headline;
	my %locimeth;
	while($readone=<SAO1>){
		chomp($readone);
		@arrone = split(/\t/,$readone);
		$_ = $arrone[13];
		
		$cnum = () = /Z|z/g;
		if($cnum >= 5){
			if($arrone[2] ne "*"){
				@loc = ();
				@m = ();
				@methline = split(/\:/,$arrone[13]);
				
				if($arrone[1] & 16){
					
					$methline[2] = reverse($methline[2]);
					$strand = "-";
				}else{
					$strand = "+";
				}
				@base = split"",$methline[2];
				$pos = 0;
				foreach $ebase(@base){
					
					if ($ebase eq "z"){
						push(@loc,$arrone[3]+$pos);
						push(@m,0);
					}elsif($ebase eq "Z"){
						push(@loc,$arrone[3]+$pos);
						push(@m,1);
					}
					$pos++;
				}
				for($i = 3; $i <= $#loc; $i++){
					$dist = $loc[$i] - $loc[$i-3];
					if($dist <= $dis){
						
						$key = "$arrone[2]\t$loc[$i-3]\t$loc[$i]\t$strand\t$loc[$i-3]\:$loc[$i-2]\:$loc[$i-1]\:$loc[$i]";
						if (exists $locimeth{$key}){
							$locimeth{$key} = "$locimeth{$key}\t$m[$i-3]$m[$i-2]$m[$i-1]$m[$i]";
						}else{
							$locimeth{$key} = "$m[$i-3]$m[$i-2]$m[$i-1]$m[$i]";
						}
					}
				}
			}
		}
	}
	close(SAO1);
	return %locimeth;	
}
1;