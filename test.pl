$hello = "|R2W1team=rox |R2W1score=0 |R2W1win=";


if($hello =~ /\|R([0-9]+)([A-Z])[0-9]+team=(.*)\s\|R[0-9]+[A-Z][0-9]+score=([0-9])/){
    print ("yep \n");
}else{
    print ("nope\n");
}
