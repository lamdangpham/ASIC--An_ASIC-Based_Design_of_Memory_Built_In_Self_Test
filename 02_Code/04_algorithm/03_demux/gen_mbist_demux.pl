&main;
sub main {
    $memnum        = $ARGV[0]-1;
    $memnum_temp   = $memnum;
    open ($SKL_FILE, "./mbist_demux_skl.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./mbist_mux_demux.v");
    
    foreach $line (<$SKL_FILE>){
            if ($line =~ /DECLEARE WRITE_READ/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE (" ,write_read_$memnum_temp\n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE RDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE (" ,rdata_$memnum_temp \n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }

            elsif ($line =~ /DECLEARE WDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE (" ,wdata_$memnum_temp \n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE ADDRESS/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE (" ,address_$memnum_temp \n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE INPUT RDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("input [DATA_WIDTH-1:0] rdata_$memnum_temp; \n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE OUTPUT WDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("output [DATA_WIDTH-1:0] wdata_$memnum_temp; \n");
                    $memnum_temp--
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE OUTPUT ADDRESS/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("output [ADDR_WIDTH-1:0] address_$memnum_temp ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }

            elsif ($line =~ /DECLEARE OUTPUT WRITE_READ/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("output write_read_$memnum_temp ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /REG WDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("reg [DATA_WIDTH-1:0] wdata_$memnum_temp ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /REG ADDRESS/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("reg [ADDR_WIDTH-1:0] address_$memnum_temp ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /REG WRITE_READ/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("reg write_read_$memnum_temp ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /RESET WDATA/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("wdata_$memnum_temp      <= 0 ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }

            elsif ($line =~ /RESET ADDRESS/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("address_$memnum_temp    <= 0 ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /RESET WRITE_READ/) {
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("write_read_$memnum_temp <= 0 ; \n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }


            elsif ($line =~ /ASSIGN RDATA_MBIST/){
                printf $TARGET_FILE ("rdata_mbist <= "); 
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("(memory_sel == $memnum_temp) ? rdata_$memnum_temp :");
                    $memnum_temp--  
                }
                printf $TARGET_FILE ("0 ;\n");
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN ADDRESS/){
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("address_$memnum_temp <= (memory_sel == $memnum_temp) ? address_mbist:0;\n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN WDATA/){
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("wdata_$memnum_temp <= (memory_sel == $memnum_temp) ? wdata_mbist:0;\n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN WRITE_READ/){
                while ($memnum_temp >= 0){
                    printf $TARGET_FILE ("write_read_$memnum_temp <= (memory_sel == $memnum_temp) ? write_read_mbist:0;\n");
                    $memnum_temp--  
                }
                $memnum_temp = $memnum;
            }

            else {
               printf $TARGET_FILE ("$line");
            }
    }

    close($SKL_FILE);
    close($TARGET_FILE);
}
