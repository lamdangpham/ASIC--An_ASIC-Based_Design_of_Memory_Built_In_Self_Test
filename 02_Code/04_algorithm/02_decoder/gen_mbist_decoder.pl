&main;
sub main {
    $marchc        = $ARGV[0];
    $apnpsf        = $ARGV[1]; 
    $marcha        = $ARGV[2];
    $marchb        = $ARGV[3];
 
    open ($SKL_FILE, "./mbist_decoder_skl.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./mbist_decoder.v");
    
    foreach $line (<$SKL_FILE>){
            if ($line =~ /ENABLE MARCHC ALGORITHM/  && $marchc =~ 1) {
                printf $TARGET_FILE ("input marchc_en; \n");
            }
            elsif ($line =~ /ENABLE APNPSF ALGORITHM/  && $apnpsf =~ 1) {
                printf $TARGET_FILE ("input apnpsf_en; \n");
            }
            elsif ($line =~ /ENABLE MARCHA ALGORITHM/  && $marcha =~ 1) {
                printf $TARGET_FILE ("input marcha_en; \n");
            }
            elsif ($line =~ /DECLEARE_MARCHC_EN/){
                if ($marchc =~ 1){
                    printf $TARGET_FILE ("                       marchc_en, \n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /DECLEARE_MARCHA_EN/){
                if ($marcha =~ 1){
                    printf $TARGET_FILE ("                       marcha_en, \n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /DECLEARE_APNPSF_EN/){
                if ($apnpsf =~ 1){
                    printf $TARGET_FILE ("                      apnpsf_en, \n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /DECLEARE_MARCHA_COMPLETE/){
                if ($marcha =~ 1){
                    printf $TARGET_FILE ("                      marcha_complete, \n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /DECLEARE_MARCHC_COMPLETE/){
                if ($marchc =~ 1){
                    printf $TARGET_FILE ("                      marchc_complete,\n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /DECLEARE_APNPSF_COMPLETE/){
                if ($apnpsf =~ 1){
                    printf $TARGET_FILE ("                     apnpsf_complete \n");
                } 
                else {
                    printf $TARGET_FILE ("");
                }
            }
            elsif ($line =~ /COMPLETE MARCHC ALGORITHM/ && $marchc =~ 1) {
                printf $TARGET_FILE ("output marchc_complete; \n");
            }
            elsif ($line =~ /COMPLETE MARCHA ALGORITHM/ && $marcha =~ 1) {
                printf $TARGET_FILE ("output marcha_complete; \n");
            }
            elsif ($line =~ /COMPLETE APNPSF ALGORITHM/ && $apnpsf =~ 1) {
                printf $TARGET_FILE ("output apnpsf_complete; \n");
            }
           elsif ($line =~ /MARCHC ALGORITHM/ && $marchc =~1 ){
                printf $TARGET_FILE ("wire marchc_en;\n");
                printf $TARGET_FILE ("wire marchc_complete;\n");
                printf $TARGET_FILE ("wire marchc_write_read;\n");
                printf $TARGET_FILE ("wire marchc_error;\n");
                printf $TARGET_FILE ("wire marchc_force_terminate;\n");
                printf $TARGET_FILE ("wire [ADDR_WIDTH-1:0] marchc_address;\n");
                printf $TARGET_FILE ("wire [DATA_WIDTH-1:0] marchc_wdata;\n");
            }
           elsif ($line =~ /MARCHA ALGORITHM/ && $marcha =~1 ){
                printf $TARGET_FILE ("wire marcha_en;\n");
                printf $TARGET_FILE ("wire marcha_complete;\n");
                printf $TARGET_FILE ("wire marcha_write_read;\n");
                printf $TARGET_FILE ("wire marcha_error;\n");
                printf $TARGET_FILE ("wire marcha_force_terminate;\n");
                printf $TARGET_FILE ("wire [ADDR_WIDTH-1:0] marcha_address;\n");
                printf $TARGET_FILE ("wire [DATA_WIDTH-1:0] marcha_wdata;\n");
            }
           elsif ($line =~ /APNPSF ALGORITHM/ && $apnpsf =~ 1){
                printf $TARGET_FILE ("wire apnpsf_en;\n");
                printf $TARGET_FILE ("wire apnpsf_complete;\n");
                printf $TARGET_FILE ("wire apnpsf_write_read;\n");
                printf $TARGET_FILE ("wire apnpsf_error;\n");
                printf $TARGET_FILE ("wire apnpsf_force_terminate;\n");
                printf $TARGET_FILE ("wire [ADDR_WIDTH-1:0] apnpsf_address;\n");
                printf $TARGET_FILE ("wire [DATA_WIDTH-1:0] apnpsf_wdata;\n");
            }
           elsif ($line =~ /ASSIGN_MARCHC_ALGORITHM/ && $marchc =~ 1){
                printf $TARGET_FILE ("marchc_decoder marchc_decoder_1(.clk(clk),.rst_n(rst_n),.marchc_en(marchc_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(marchc_address),.write_read(marchc_write_read),.memtype(memtype),.wdata(marchc_wdata),.rdata(rdata),.error(marchc_error),.force_terminate(marchc_force_terminate),.marchc_complete(marchc_complete));\n")
            }
           elsif ($line =~ /ASSIGN_MARCHA_ALGORITHM/ && $marcha =~ 1){
                printf $TARGET_FILE ("marcha_decoder marcha_decoder_1(.clk(clk),.rst_n(rst_n),.marcha_en(marcha_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(marcha_address),.write_read(marcha_write_read),.memtype(memtype),.wdata(marcha_wdata),.rdata(rdata),.error(marcha_error),.force_terminate(marcha_force_terminate),.marcha_complete(marcha_complete));\n")
            }
           elsif ($line =~ /ASSIGN_APNPSF_ALGORITHM/ && $apnpsf =~ 1){
                printf $TARGET_FILE ("apnpsf_decoder apnpsf_decoder_1(.clk(clk),.rst_n(rst_n),.apnpsf_en(apnpsf_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(apnpsf_address),.write_read(apnpsf_write_read),.memtype(memtype),.wdata(apnpsf_wdata),.rdata(rdata),.error(apnpsf_error),.force_terminate(apnpsf_force_terminate),.apnpsf_complete(apnpsf_complete));\n")
            }
           elsif ($line =~ /ASSIGN_APNPSF_MARCHC_MARCHA/){
                if ($apnpsf =~ 1 && $marchc =~ 0 && $marcha =~0){
                    printf $TARGET_FILE ("assign address = (apnpsf_en)? apnpsf_address:16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (apnpsf_en)? apnpsf_write_read:1'b0;\n");
                    printf $TARGET_FILE ("assign error = (apnpsf_en)? apnpsf_error: 1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (apnpsf_en) ? apnpsf_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("        if (apnpsf_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= apnpsf_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");
                }
                elsif ($apnpsf =~ 0 && $marchc =~1 && $marcha =~0 ){
                    printf $TARGET_FILE ("assign address = (marchc_en)? marchc_address:16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marchc_en)? marchc_write_read:1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marchc_en)? marchc_error:1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marchc_en) ? marchc_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("       if (marchc_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marchc_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");
               }
                elsif ($apnpsf =~ 0 && $marchc =~0 && $marcha =~1 ){
                    printf $TARGET_FILE ("assign address = (marcha_en)? marcha_address:16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marcha_en)? marcha_write_read:1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marcha_en)? marcha_error:1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marcha_en) ? marcha_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("       if (marcha_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marcha_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");
               }
               elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 0){
                    printf $TARGET_FILE ("assign address = (marchc_en) ? marchc_address : (apnpsf_en) ? apnpsf_address : 16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marchc_en) ? marchc_write_read : (apnpsf_en) ? apnpsf_write_read : 1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marchc_en) ? marchc_error : (apnpsf_en) ? apnpsf_error : 1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marchc_en) ? marchc_force_terminate : (apnpsf_en) ? apnpsf_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("        if (marchc_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marchc_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else if (apnpsf_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= apnpsf_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");

               }
               elsif ($marchc =~ 0 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("assign address = (marcha_en) ? marcha_address : (apnpsf_en) ? apnpsf_address : 16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marcha_en) ? marcha_write_read : (apnpsf_en) ? apnpsf_write_read : 1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marcha_en) ? marcha_error : (apnpsf_en) ? apnpsf_error : 1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marcha_en) ? marcha_force_terminate : (apnpsf_en) ? apnpsf_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("        if (marcha_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marcha_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else if (apnpsf_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= apnpsf_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");

               }
               elsif ($marchc =~ 1 && $apnpsf =~ 0 && $marcha =~ 1){
                    printf $TARGET_FILE ("assign address = (marcha_en) ? marcha_address : (marchc_en) ? marchc_address : 16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marcha_en) ? marcha_write_read : (marchc_en) ? marchc_write_read : 1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marcha_en) ? marcha_error : (marchc_en) ? marchc_error : 1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marcha_en) ? marcha_force_terminate : (marchc_en) ? marchc_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("        if (marcha_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marcha_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else if (marchc_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marchc_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");

               }
               elsif ($marchc =~ 1 && $apnpsf =~ 1 && $marcha =~ 1){
                    printf $TARGET_FILE ("assign address = (marcha_en) ? marcha_address : (marchc_en) ? marchc_address : (apnpsf_en) ?  apnpsf_address : 16'h00;\n");
                    printf $TARGET_FILE ("assign write_read = (marcha_en) ? marcha_write_read : (marchc_en) ? marchc_write_read : (apnpsf_en) ?  apnpsf_write_read: 1'b0;\n");
                    printf $TARGET_FILE ("assign error = (marcha_en) ? marcha_error : (marchc_en) ? marchc_error : (apnpsf_en) ? apnpsf_error: 1'b0;\n");
                    printf $TARGET_FILE ("assign force_terminate = (marcha_en) ? marcha_force_terminate : (marchc_en) ? marchc_force_terminate : (apnpsf_en) ? apnpsf_force_terminate : 1'b0;\n");
                    printf $TARGET_FILE ("always@(posedge clk or negedge rst_n) begin \n");
                    printf $TARGET_FILE ("    if(!rst_n) begin \n");
                    printf $TARGET_FILE ("        wdata <= 0;\n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("    else begin \n");
                    printf $TARGET_FILE ("        if (marcha_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marcha_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else if (marchc_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= marchc_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else if (apnpsf_en ==1) begin \n");
                    printf $TARGET_FILE ("            wdata <= apnpsf_wdata;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("        else begin\n");
                    printf $TARGET_FILE ("            wdata <= 0;\n");
                    printf $TARGET_FILE ("        end \n");
                    printf $TARGET_FILE ("    end \n");
                    printf $TARGET_FILE ("end \n");

               }
               else {
                  printf $TARGET_FILE (""); 
               }
          }

          else {
               printf $TARGET_FILE ("$line");
          }
    }

    close($SKL_FILE);
    close($TARGET_FILE);
}
