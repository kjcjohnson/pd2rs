open FILE, '<LP_data.xml';

@lines = <FILE>;

$inpage = 0;
$tourneycount = 0;

foreach(@lines){
    if(/<page>/){
	$inpage = 1;
    }
    if(/<title>(.*)<\/title>/){
	if(/Template:(.*)/){
	    print("Template \n");
	}else{
	    $tourneycount++;
	    print("$1 \n");
	}
    }
}

print("We have $tourneycount torunaments\n");
