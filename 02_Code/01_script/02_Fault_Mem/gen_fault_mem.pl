&main;
sub main {
    $DATA_WIDTH     = $ARGV[0];
    $ADDR_WIDTH     = $ARGV[1];
    $WRONG_ADDR     = $ARGV[2];
    $ISSUE_CODE     = $ARGV[3];
    $CAPACITY       = $ARGV[4];

    open ($SKL_FILE, "./../01_script/02_Fault_Mem/input/fault_mem_$ISSUE_CODE.v") || die("There is no skeleton file \n");
    open ($TARGET_FILE, ">./run/fault_mem.v");

    if($ISSUE_CODE =~ /0101/) {
        $FIX_DATA = "AB";
    }elsif($ISSUE_CODE =~ /0102/){
        $FIX_DATA = "00";
    }elsif($ISSUE_CODE =~ /0103/){
        $FIX_DATA = "FF";
    }elsif($ISSUE_CODE =~ /0104/){
        $FIX_DATA = "08";
    }elsif($ISSUE_CODE =~ /0105/){
        $FIX_DATA = "F7";
    }
    foreach $line (<$SKL_FILE>){
        $line =~ s/\@DATA_WIDTH/$DATA_WIDTH/g;
        $line =~ s/\@ADDR_WIDTH/$ADDR_WIDTH/g;
        $line =~ s/\@CAPACITY/$CAPACITY/g;
        $line =~ s/\@WRONG_ADDR/$WRONG_ADDR/g;
        $line =~ s/\@FIX_DATA/$FIX_DATA/g;
        printf $TARGET_FILE ("$line");
    }
    close($SKL_FILE);
    close($TARGET_FILE);
}
