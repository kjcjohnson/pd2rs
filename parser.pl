#Set up our file I/O
open IN_FILE, '<LP_data.xml';
open DATA_OUT, '>clean_data.csv';
open LOG_OUT, '>runlog.txt';
open OUT_TOURNEYS, '>tourney_list.csv';

#Get errything out of our infile
@lines = <IN_FILE>;

#Switch variables (hopefully well named)
$inpage = 0;
$foundteam1 = 0;
$havedate = 0;

#Counters
$tourneycount = 0;

#data that I'm actually gonna do something with
$team1 = "";
$team2 = "";
$team1score = 0;
$team2score = 0;
$date = 0;
$def_date = 0;
$time = 0;
$tdstring = 0;

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

    #Catch the first format of match data
    if(/\|R([0-9]+)([A-Z])[0-9]+team=(.*)\s\|R[0-9]+[A-Z][0-9]+score=([0-9])/){
	if(!$foundteam1){
	    print LOG_OUT ("team 1 = $3, $4 \n");
	    $foundteam1 = 1;
	    $time = $1 * 100;
	    $team1 = $3;
	    $team1score = $4;
	    if($2 =~ /D/){
		$time += 1;
	    }
	}else{
	    print LOG_OUT ("team 2 = $3, $4 \n");
	    $tdstring = 1000*$def_date + $time;
	    $team2 = $3;
	    $team2score = $4;
	    print LOG_OUT ("date = $tdstring\n");
	    while($team1score){
		print DATA_OUT ("$team1 $team2 $tdstring\n");
		$team1score--;
	    }
	    while($team2score){
		print DATA_OUT ("$team2 $team1 $tdstring\n");
		$team2score--;
	    }
	    $foundteam1 = 0;
	}
    }
}

print OUT_TOURNEYS ("We have $tourneycount torunaments\n");
