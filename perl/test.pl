open FILE, '<test.txt';

@lines = <IN_FILE>;
chomp(@lines);

foreach(@lines){
    $holder = $_;
    if($holder =~ /\|player2=({{(.*?)\/)*(.*?)(\|.*?)*(\|(.*)?)*(\[|\})/gi){
	print("yep: $3\n");
    }else{
	print("nope\n");
    }

    print("$holder\n");
}
