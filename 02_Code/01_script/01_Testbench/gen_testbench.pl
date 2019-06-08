&main;
sub main {
    $DEBUG          = $ARGV[0];
    $MEMTYPE        = $ARGV[1]; 
    $OPERATION      = $ARGV[2];
    $MEMORY_SELECTION = $ARGV[3];
 
    open ($SKL_FILE, "./../01_script/01_Testbench/input/testbench_skl.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./run/testbench.v");
    
    if ($OPERATION =~ /0/)  {
        $ALGORITHM = "MARCHC";
    }else{
        $ALGORITHM = "ANPNSF";
         }
    foreach $line (<$SKL_FILE>){
         $line =~ s/\@MEMORY_SELECTION/$MEMORY_SELECTION/g;
         if ($line =~ /DEFINE WAVEFORM DEBUG/) {
            if($DEBUG =~ "true") {
                printf $TARGET_FILE ("initial begin                            \n"); 
                printf $TARGET_FILE ("    \$vcdplusfile(\"t_testbench.vpd\");   \n");
                printf $TARGET_FILE ("    \$vcdpluson();                       \n"); 
                printf $TARGET_FILE ("end                                      \n"); 
            }
        } elsif($line =~/DEFINE MEMTYPE/){
          printf $TARGET_FILE  ("    memtype = $MEMTYPE ; \n");
        
        } elsif($line =~/DEFINE OPERATION MODE/){
          printf $TARGET_FILE  ("    operation = $OPERATION; \n");

        } elsif($line =~/DEFINE FINISH TIME/){
             if ($OPERATION =~ /0/)  {
                 printf $TARGET_FILE  ("    \$display (\" == MARCH C ARE RUNNING ==\");\n");
                 printf $TARGET_FILE  ("    #525000000; \n    \$finish; \n");
             }
             elsif ($OPERATION =~ /2/)  {
                 printf $TARGET_FILE  ("    \$display (\" == MARCH A ARE RUNNING ==\");\n");
                 printf $TARGET_FILE  ("    #700000000; \n    \$finish; \n");
             }else {
                 printf $TARGET_FILE  ("    \$display (\" == APNPSF ARE RUNNING == \");\n");
                 printf $TARGET_FILE  ("    #1698700000;\n    \$finish; \n");
             }
        
        }else {
            printf $TARGET_FILE ("$line");
        }
    }
    close($SKL_FILE);
    close($TARGET_FILE);
}
