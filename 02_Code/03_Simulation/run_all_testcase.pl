&main;
sub main {
    open ($CONFIG, "./config.txt") || die("There is no config file \n");
    foreach $line (<$CONFIG>){
        if( ($line !~ /^#/) or ($line !~ /^ *#/) ) {
            chop($line);
            @line_mem =  split(/  */, $line); 
            $data_width  = @line_mem[0];
            $capacity   = @line_mem[1];
            $wrong_addr = @line_mem[2];
            $issue_code = @line_mem[3];
            $operation = @line_mem[4];
            $addr_width    = log($capacity+1)/log(2);
            $memtype = @line_mem[5];
            $is_waveform = @line_mem[6];
            $memory_sel = @line_mem[7];
            printf("./run_one_testcase.sh $data_width $addr_width  $wrong_addr $issue_code $capacity $is_waveform $memtype $operation $memory_sel \n");
            system("./run_one_testcase.sh $data_width $addr_width  $wrong_addr $issue_code $capacity $is_waveform $memtype $operation $memory_sel");
#            system("./run_one_testcase.sh $data_width $addr_width $wrong_addr $issue_code $wrong_addr $run_option $is_waveform ");
        }
    }
    close($CONFIG);
}
