&main;
sub main {
    $marchc        = $ARGV[0];
    $apnpsf        = $ARGV[1]; 
    $marcha        = $ARGV[2];
    $marchb        = $ARGV[3];
    $memnum        = $ARGV[4]-1;
    $memnum_temp   = $memnum;
    open ($SKL_FILE, "./mbist_skl.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./mbist.v");
    
    foreach $line (<$SKL_FILE>){
            if ($line =~ /DECLEARE_MARCHC/  && $marchc =~ 1) {
                printf $TARGET_FILE ("wire marchc_complete; \n");
                printf $TARGET_FILE ("wire marchc_en; \n");
            }

            elsif ($line =~ /DECLEARE_APNPSF/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("wire apnpsf_complete; \n");
                printf $TARGET_FILE ("wire apnpsf_en; \n");
            }
            elsif ($line =~ /DECLEARE_MARCHA/  && $marcha =~ 1) {
                printf $TARGET_FILE ("wire marcha_complete; \n");
                printf $TARGET_FILE ("wire marcha_en; \n");
            }
            elsif ($line =~ /ASSIGN_APNPSF/ && $apnpsf =~ 1){
                printf $TARGET_FILE ("                        .apnpsf_complete(anpsf_complete), \n");
                printf $TARGET_FILE ("                        .apnpsf_en(apnpsf_en), \n");

            }          
            elsif ($line =~ /ASSIGN_MARCHC/ && $marchc =~ 1){
                printf $TARGET_FILE ("                        .marchc_complete(marchc_complete), \n");
                printf $TARGET_FILE ("                        .marchc_en(marchc_en), \n");

            }          
            elsif ($line =~ /ASSIGN_MARCHA/ && $marcha =~ 1){
                printf $TARGET_FILE ("                        .marcha_complete(marcha_complete), \n");
                printf $TARGET_FILE ("                        .marcha_en(marcha_en), \n");
            }

#CODE MODIFY MEMORY NUMBER

            elsif ($line =~ /DECLEARE ADDRESS/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("address_$memnum_temp, \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE WRITE_READ/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("write_read_$memnum_temp, \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE WDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("wdata_$memnum_temp, \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE RDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("rdata_$memnum_temp, \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE INPUT RDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("input [DATA_WIDTH-1:0] rdata_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE OUTPUT WRITE_READ/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("output write_read_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE OUTPUT ADDRESS/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("output [ADDR_WIDTH-1:0] address_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /DECLEARE OUTPUT WDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("output [DATA_WIDTH-1:0] wdata_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /WIRE WRITE_READ/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("wire write_read_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /WIRE ADDRESS/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("wire [ADDR_WIDTH-1:0] address_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /WIRE RDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("wire [DATA_WIDTH-1:0] rdata_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /WIRE WDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE ("wire [DATA_WIDTH-1:0] wdata_$memnum_temp; \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN WRITE_READ/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE (",.write_read_$memnum_temp(write_read_$memnum_temp) \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN ADDRESS/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE (",.address_$memnum_temp(address_$memnum_temp) \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN RDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE (",.rdata_$memnum_temp(rdata_$memnum_temp) \n");
                    $memnum_temp--;
                }
            $memnum_temp = $memnum;
            }
            elsif ($line =~ /ASSIGN WDATA/) {
                while ($memnum_temp >=0){
                    printf $TARGET_FILE (",.wdata_$memnum_temp(wdata_$memnum_temp) \n");
                    $memnum_temp--;
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

