&main;
sub main {
    open ($MBIST_ALGORITHM, "./mbist_algorithm.txt") || die("There is no mbist_algorithm file \n");
    foreach $line (<$MBIST_ALGORITHM>){
        if( ($line !~ /^#/) or ($line !~ /^ *#/) ) {
            chop($line);
            @line_algorithm =  split(/  */, $line); 
            $marchc         = @line_algorithm[0];
            $apnpsf         = @line_algorithm[1];
            $marcha         = @line_algorithm[2];
            $marchb         = @line_algorithm[3];
            $memnum         = @line_algorithm[4];
            printf("./run_algorithm.sh $marchc $apnpsf $marcha $marchb $memnum\n");
            system("./run_algorithm.sh $marchc $apnpsf $marcha $marchb $memnum\n");
        }
    }
    close($MBIST_ALGORITHM);
}
