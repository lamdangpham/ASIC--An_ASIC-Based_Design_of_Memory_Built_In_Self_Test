&main;
sub main {
    $marchc        = $ARGV[0];
    $apnpsf        = $ARGV[1]; 
    $marcha        = $ARGV[2];
    $marchb        = $ARGV[3];
 
    open ($SKL_FILE, "./controller_skl.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./controller.v");
    
    foreach $line (<$SKL_FILE>){
            if ($line =~ /COMPLETE_MARCHC_INPUT/  && $marchc =~ 1) {
                printf $TARGET_FILE ("input marchc_complete; \n");
            }
            elsif ($line =~ /COMPLETE_MARCHA_INPUT/  && $marcha =~ 1) {
                printf $TARGET_FILE ("input marcha_complete; \n");
            }
            elsif ($line =~ /COMPLETE_APNPSF_INPUT/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("input apnpsf_complete; \n");
            }
            elsif ($line =~ /ENABLE_MARCHA_OUTPUT/  && $marcha =~ 1) {
                printf $TARGET_FILE ("output marcha_en; \n");
            }
            elsif ($line =~ /ENABLE_MARCHC_OUTPUT/  && $marchc =~ 1) {
                printf $TARGET_FILE ("output marchc_en; \n");
            }
            elsif ($line =~ /ENABLE_APNPSF_OUTPUT/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("output apnpsf_en; \n");
            }
            elsif ($line =~ /PARAMETER_MARCHA/  && $marcha =~ 1) {
                printf $TARGET_FILE ("parameter MARCHA = 3'b100; \n");
            }
            elsif ($line =~ /PARAMETER_MARCHC/  && $marchc =~ 1) {
                printf $TARGET_FILE ("parameter MARCHC = 3'b010; \n");
            }
            elsif ($line =~ /PARAMETER_APNPSF/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("parameter APNPSF = 3'b011; \n");
            }
            elsif ($line =~ /COMPLETE_MARCHA_WIRE/  && $marcha =~ 1) {
                printf $TARGET_FILE ("wire marcha_complete; \n");
            }
            elsif ($line =~ /COMPLETE_MARCHC_WIRE/  && $marchc =~ 1) {
                printf $TARGET_FILE ("wire marchc_complete; \n");
            }
            elsif ($line =~ /COMPLETE_APNPSF_WIRE/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("wire apnpsf_complete; \n");
            }
            elsif ($line =~ /ENABLE_MARCHA_REG/  && $marcha =~ 1) {
                printf $TARGET_FILE ("reg marcha_en; \n");
            }
            elsif ($line =~ /ENABLE_MARCHC_REG/  && $marchc =~ 1) {
                printf $TARGET_FILE ("reg marchc_en; \n");
            }
            elsif ($line =~ /ENABLE_APNPSF_REG/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("reg apnpsf_en; \n");
            }

            elsif ($line =~ /DECLEARE_MARCHC/  && $marchc =~ 1) {
                printf $TARGET_FILE ("                  marchc_complete, \n");
                printf $TARGET_FILE ("                  marchc_en, \n");
            }

            elsif ($line =~ /DECLEARE_MARCHA/  && $marcha =~ 1) {
                printf $TARGET_FILE ("                  marcha_complete, \n");
                printf $TARGET_FILE ("                  marcha_en, \n");
            }

            elsif ($line =~ /DECLEARE_APNPSF/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("                  apnpsf_complete, \n");
                printf $TARGET_FILE ("                  apnpsf_en, \n");
            }


            elsif ($line =~ /ASSIGN_COMPLETE/){
                if ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~1){
                    printf $TARGET_FILE ("assign complete = marchc_complete|apnpsf_complete | marcha_complete;\n");
                } 
                elsif ($marchc =~ 1 && $apnpsf =~0 && $marcha =~1 ){
                    printf $TARGET_FILE ("assign complete = marchc_complete|marcha_complete;\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~1 && $marcha =~1 ){
                    printf $TARGET_FILE ("assign complete = apnpsf_complete|marcha_complete;\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~0 && $marcha =~1 ){
                    printf $TARGET_FILE ("assign complete = marcha_complete;\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~0){
                    printf $TARGET_FILE ("assign complete = marchc_complete|apnpsf_complete;\n");
                } 
                elsif ($marchc =~ 1 && $apnpsf =~0 && $marcha =~0 ){
                    printf $TARGET_FILE ("assign complete = marchc_complete;\n");
                }

                elsif ($marchc =~ 0 && $apnpsf =~1 && $marcha =~0 ){
                    printf $TARGET_FILE ("assign complete = apnpsf_complete;\n");
                }
                else {
                   printf $TARGET_FILE ("$line");
                }
            }
            elsif ($line =~ /ASSIGN_SET_UP_STATE_ALGORITHM/){
                if (($marchc =~ 1 && $apnpsf =~ 1)|($marchc =~ 1 && $marcha =~ 1)|($marcha =~ 1&& $apnpsf =~1)){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        if (operation == 3'b000) begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHC;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else if (operation == 3'b001)begin\n");
                    printf $TARGET_FILE ("            next_state <= APNPSF;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else if (operation == 3'b010)begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHA;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHC;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~0 && $marcha =~ 0){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHC;\n");
                    printf $TARGET_FILE ("    end\n");

                }
                elsif ($marchc =~ 0 && $apnpsf =~1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("            next_state <= APNPSF;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHA;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                else {
                    printf $TARGET_FILE ("$line");
                }
            }
            elsif ($line =~ /ASSIGN_MARCHC_STATE_ALGORITHM/ && $marchc =~1){
                    printf $TARGET_FILE ("    MARCHC: begin\n");
                    printf $TARGET_FILE ("        if (marchc_complete) begin\n");
                    printf $TARGET_FILE ("            next_state <= INITIAL;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHC;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("    end\n");

            }
            elsif ($line =~ /ASSIGN_MARCHA_STATE_ALGORITHM/ && $marcha =~1){
                    printf $TARGET_FILE ("    MARCHA: begin\n");
                    printf $TARGET_FILE ("        if (marcha_complete) begin\n");
                    printf $TARGET_FILE ("            next_state <= INITIAL;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            next_state <= MARCHA;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("    end\n");

            }
            elsif ($line =~ /ASSIGN_APNPSF_STATE_ALGORITHM/ && $apnpsf =~1){
                    printf $TARGET_FILE ("    APNPSF: begin\n");
                    printf $TARGET_FILE ("        if (apnpsf_complete) begin\n");
                    printf $TARGET_FILE ("            next_state <= INITIAL;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            next_state <= APNPSF;\n");
                    printf $TARGET_FILE ("        end\n");
                    printf $TARGET_FILE ("    end\n");

            }
            elsif ($line =~ /ASSIGN_INITIAL_STATE_OUTPUT/){
                if ($marchc =~ 0 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 0){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    INITIAL: begin\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }

                else{
                   printf $TARGET_FILE ("$line");
                }
            }

            elsif ($line =~ /ASSIGN_RESET_STATE_OUTPUT/){
                if ($marchc =~ 0 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 0){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    if (!rst_n) begin \n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                else{
                   printf $TARGET_FILE ("$line");
                }
            }
            elsif ($line =~ /ASSIGN_SET_UP_STATE_OUTPUT/){

                if ($marchc =~ 0 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 0){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    SET_UP: begin\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }

                else{
                   printf $TARGET_FILE ("$line");
                }
            }
            elsif ($line =~ /ASSIGN_MARCHC_STATE_OUTPUT/){
                if ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~0){
                    printf $TARGET_FILE ("    MARCHC: begin\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 & $marcha =~0){
                    printf $TARGET_FILE ("    MARCHC: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 0 & $marcha =~1){
                    printf $TARGET_FILE ("    MARCHC: begin\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }

                elsif ($marchc =~ 1 && $apnpsf =~ 1 & $marcha =~1){
                    printf $TARGET_FILE ("    MARCHC: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b1;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }


                else{
                   printf $TARGET_FILE ("$line");
                }
            }
            elsif ($line =~ /ASSIGN_APNPSF_STATE_OUTPUT/){
                if ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    APNPSF: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("    APNPSF: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b1;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~1 & $marcha =~1){
                    printf $TARGET_FILE ("    APNPSF: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b1;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }

                elsif ($marchc =~ 1 && $apnpsf =~ 1 & $marcha =~1){
                    printf $TARGET_FILE ("    APNPSF: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b1;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                else{
                   printf $TARGET_FILE ("$line");
                }
            }

            elsif ($line =~ /ASSIGN_MARCHA_STATE_OUTPUT/){
                if ($marchc =~ 0 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("    MARCHA: begin\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("    MARCHA: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                elsif ($marchc =~ 1 && $apnpsf =~0 & $marcha =~1){
                    printf $TARGET_FILE ("    MARCHA: begin\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b1;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("    end\n");
                }

                elsif ($marchc =~ 1 && $apnpsf =~ 1 & $marcha =~1){
                    printf $TARGET_FILE ("    MARCHA: begin\n");
                    printf $TARGET_FILE ("        apnpsf_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marchc_en <= 1'b0;\n");
                    printf $TARGET_FILE ("        marcha_en <= 1'b1;\n");
                    printf $TARGET_FILE ("    end\n");
                }
                else{
                   printf $TARGET_FILE ("$line");
                }
            }



            else {
               printf $TARGET_FILE ("$line");
            }
    }

    close($SKL_FILE);
    close($TARGET_FILE);
}

