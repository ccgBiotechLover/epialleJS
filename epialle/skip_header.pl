sub skip_header{
	$file = $_[0];
	$headline = 0;
	open SAO,"$file" or die "cannot open samfile when skip header:$!\n";
	while($headone = <SAO>){
        if($headone =~ /\@/){
            $headline++;
        }else{
            last;
        }
	}
	close(SAO);
}
1;