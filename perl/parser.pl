#Set up our file I/O
open IN_FILE, '<LP_data.xml';
open DATA_OUT, '>clean_data.csv';
open LOG_OUT, '>runlog.txt';
open OUT_TOURNEYS, '>tourney_list.csv';

#Get errything out of our infile
@lines = <IN_FILE>;
chomp(@lines);

#Switch variables (hopefully well named)
$inpage = 0;
$foundteam1 = 0;
$havedate = 0;
$accum = 0;

#Counters
$tourneycount = 0;
$MMCount = 0;

#data that I'm actually gonna do something with
$team1 = "";
$team2 = "";
$team1score = 0;
$team2score = 0;
$date = 0;
$def_date = 0;
$time = 0;
$tdstring = 0;

$holder = "";

foreach(@lines){
    #see if we're in a page, I'll use this later
    if(/<page>/){
	$inpage = 1;
	$havedate = 0;
    }

    #Catch title's of various tournamens and print them out to a list
    #I just wanted to have these for later
    if(/<title>(.*)<\/title>/){
	if(/Template:(.*)/){
	    print OUT_TOURNEYS ("Template, \n");
	}else{
	    $tourneycount++;
	    print OUT_TOURNEYS ("$1, \n");
	}
    }

    #Get a default date
    if(/\|date=([0-9]+)-([0-9]+)-([0-9]+)/){
	if(!$havedate){
	    $def_date = "$1"."$2"."$3";
	    $havedate = 1;
	}
    }
    #Check for sdate too
    if(/\|sdate=([0-9]+)-([0-9]+)-([0-9]+)/){
	if(!$havedate){
	    $def_date = "$1"."$2"."$3";
	    $havedate = 1;
	}
    }

    #deal with accumulation
    if($accum){
	$holder .= $_;
    }
    
    if($_ eq '}}'){
	if($accum){
	    print LOG_OUT ("$holder\n");
	    $accum = 0;

	    if($holder =~ /\[/){
		print LOG_OUT ("bracket\n");
		if($holder =~ /\|player1=(.*?)\[\[(.*?)\]\](.*?)\|player2=\[\[(.*?)\]\](.*?)\|/gs){
		    print LOG_OUT ("first type: ");
		    $team1 = $1;
		    $team2 = $5;
		    print LOG_OUT ("$team1 \n");
		}
	    }else{
		print LOG_OUT ("nobracket\n");
		$tester = $holder;
		if($holder =~ /\|player1=({{(.*?)\/)*(.*?)(\|.*?)*(\|(.*)?)*(\[|\})/gi){
		    if($4 && $1){
			print LOG_OUT ("second type a: ");
			$team1 = $4;
			$team1 = substr $team1, 1;
		    }else{
			print LOG_OUT ("second type b: ");
			$team1 = $3;
		    }
		    print LOG_OUT ("$team1 \n");
		}
		if($tester =~ /\|player2=({{(.*?)\/)*(.*?)(\|.*?)*(\|(.*)?)*(\[|\})/gis){
		    if($4 && $1){
			$team2 = $4;
			$team2 = substr $team2, 1;
		    }else{
			$team2 = $3;
		    }
		    print LOG_OUT ("$team2 \n");
		}
	    }
	
	    for ($n = 1; $n < 8; $n++){
		if($holder =~ /\|map($n)win=([0-9])/){
		    if($1 == 1){
			$team1score++;
		    }else{
			$team2score++;
		    }
		}
	    }
	    $tdstring = 1000*$def_date + $time;
	    
	    #now print it
	    while($team1score){
		print DATA_OUT ("$team1, $team2, $tdstring\n");
		$team1score--;
	    }
	    while($team2score){
		print DATA_OUT ("$team2, $team1, $tdstring\n");
		$team2score--;
	    }
	}
    }
    
    
    #Catch the first format of match data
    if(/\|R([0-9]+)([A-Z])[0-9]+team=(.*)\s\|R[0-9]+[A-Z][0-9]+score=([0-9])/){
	if(!$foundteam1){
	    #print LOG_OUT ("team 1 = $3, $4 \n");
	    $foundteam1 = 1;
	    $time = $1 * 100;
	    $team1 = $3;
	    $team1score = $4;
	    if($2 =~ /D/){
		$time += 1;
	    }
	}else{
	    #print LOG_OUT ("team 2 = $3, $4 \n");
	    $tdstring = 1000*$def_date + $time;
	    $team2 = $3;
	    $team2score = $4;
	    #print LOG_OUT ("date = $tdstring\n");
	    while($team1score){
		print DATA_OUT ("$team1, $team2, $tdstring\n");
		$team1score--;
	    }
	    while($team2score){
		print DATA_OUT ("$team2, $team1, $tdstring\n");
		$team2score--;
	    }
	    $foundteam1 = 0;
	}
    }

    #Catch the second format
    if(/\|match([0-9])+=\{\{MatchMaps/){
	#print LOG_OUT ("Found a MatchMap:");
	#print LOG_OUT ("$_ \n");
	$time = $1;
	$MMCount++;
	$holder = $_;
 
	if(/\}\}\z/){
	    #print LOG_OUT ("one-liner\n");
	     
	    #parse it
	    #print("$holder\n");

	    if($holder =~ /\|player1=(.*?)\|/){
		$team1 = $1;
	    }
	    if($holder =~ /\|player2=(.*?)\|/){
		$team2 = $1;
	    }
	    for ($n = 1; $n < 8; $n++){
		if($holder =~ /\|map($n)win=([0-9])/){
		    if($1 == 1){
			$team1score++;
		    }else{
			$team2score++;
		    }
		}
	    }

	    $tdstring = 1000*$def_date + $time;
	    
	    #now print it
	    while($team1score){
		#print DATA_OUT ("$team1, $team2, $tdstring\n");
		$team1score--;
	    }
	    while($team2score){
		#print DATA_OUT ("$team2, $team1, $tdstring\n");
		$team2score--;
	    }

	}else{
	    #print LOG_OUT ("multi-liner\n");
	    $accum = 1;
	}
    }
}

print LOG_OUT ("We found $MMCount Match Maps\n");
print OUT_TOURNEYS ("We have $tourneycount torunaments\n");
