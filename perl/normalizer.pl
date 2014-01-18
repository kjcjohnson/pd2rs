open IN_FILE, '<clean_data.csv';
open OUT_FILE, '>norm_data.csv';

@lines = <IN_FILE>;

$team1;
$team2;
$date;

foreach(@lines){
    if(/(.*),(.*),\s([0-9]+)/){
	#print("did we at least get here?\n");
	$team1 = $1;
	$team2 = $2;
	$date = $3;
	if(&lengthen($team1)){
	    $team1 = &lengthen($team1);
	}
	if(&lengthen($team2)){
	    $team2 = &lengthen($team2);
	}
	print OUT_FILE ("$team1,$team2,$date\n");

    }
}

sub lengthen{
    $_ = $_[0];
    
    if(/1st\.VN/i){
	"1stvn";
    }elsif(/3D\!Clan/i){
	"3dclan";
    }elsif(/3DMAX/i){
	"3dmax";
    }elsif(/4FC/i){
	"4 friends chrillee";
    }elsif(/ABC/i){
	"abc";
    }elsif(/aL/i){
	"absolute legends";
    }elsif(/Ace/i){
	"aceonline";
    }elsif(/Adversa/i){
	"adversa";
    }elsif(/AEON/i){
	"aeonsports";
    }elsif(/Ahead\.kz/i){
	"ahead gaming";
    }elsif(/aL\.Acad/i){
	"al academy";
    }elsif(/aNa/i){
	"anarchist";
    }elsif(/Aposis/i){
	"aposis gaming";
    }elsif(/ART/i){
	"art";
    }elsif(/Artyk/i){
	"artyk";
    }elsif(/aSpera/i){
	"aspera";
    }elsif(/Aurochs/i){
	"aurochs";
    }elsif(/Ave/i){
	"ave";
    }elsif(/Awake/i){
	"awake";
    }elsif(/Baguette/i){
	"baguette";
    }elsif(/BHA/i){
	"bien hoa assassins";
    }elsif(/BX3/i){
	"bx3 esports club";
    }elsif(/cSc/i){
	"cascade";
    }elsif(/C\.SK/i){
	"chainsstack";
    }elsif(/Clan Pl/i){
	"clan poland";
    }elsif(/CoMe/i){
	"come";
    }elsif(/CNB/i){
	"cnb";
    }elsif(/coL/i){
	"complexity gaming";
    }elsif(/Wolves/i){
	"copenhagen wolves";
    }elsif(/CLG/i){
	"counter logic gaming";
    }elsif(/Darer/i){
	"darer";
    }elsif(/DD/i){
	"dddota";
    }elsif(/Denial/i){
	"denial esports";
    }elsif(/Drmz/i){
	"dreamz";
    }elsif(/DRz/i){
	"druidz";
    }elsif(/DTS/i){
	"dts gaming";
    }elsif(/DTS2010/i){
	"dts2010";
    }elsif(/Duskbin/i){
	"duskbin";
    }elsif(/DuSt/i){
	"dust";
    }elsif(/Duza/i){
	"duza";
    }elsif(/EC/i){
	"eclypsia";
    }elsif(/EHOME/i){
	"ehome";
    }elsif(/Energy/i){
	"energy esports";
    }elsif(/E\+4/i){
	"eosin";
    }elsif(/EG/i){
	"evil geniuses";
    }elsif(/evo\^/i){
	"evo";
    }elsif(/xP/i){
	"experience";
    }elsif(/EYES/i){
	"eyesonu";
    }elsif(/FastGG/i){
	"fastgg";
    }elsif(/FD/i){
	"firstdeparture";
    }elsif(/Flash/i){
	"flash";
    }elsif(/\[F\.3\]/i){
	"flipside tactics";
    }elsif(/Fnatic/i){
	"fnatic";
    }elsif(/Fnatic\.EU/i){
	"fnatic.eu";
    }elsif(/Fnatic\.NA/i){
	"fnatic.na";
    }elsif(/FL/i){
	"forlove";
    }elsif(/fOu/i){
	"for our utopia";
    }elsif(/fota/i){
	"freedom of the action";
    }elsif(/FUBAR/i){
	"fubar";
    }elsif(/FXO/i){
	"fxopen e-sports";
    }elsif(/PLS/i){
	"gabe pls";
    }elsif(/GU/i){
	"gamer university";
    }elsif(/GL/i){
	"gamersleague";
    }elsif(/GW/i){
	"gameware";
    }elsif(/\[GD\]/i){
	"gdteam";
    }elsif(/GizMo/i){
	"gizmo";
    }elsif(/GG/i){
	"gosugamers";
    }elsif(/GraTs/i){
	"grats tho";
    }elsif(/H2k/i){
	"h2k gaming";
    }elsif(/HGT/i){
	"heart get together";
    }elsif(/HWA/i){
	"hwa";
    }elsif(/iCCup/i){
	"iccup";
    }elsif(/Ice/i){
	"ice";
    }elsif(/IC/i){
	"ice climbers";
    }elsif(/iDeal/i){
	"ideal";
    }elsif(/imG/i){
	"imaginary gaming";
    }elsif(/IMP/i){
	"imperium";
    }elsif(/Imp/i){
	"impervious";
    }elsif(/iNG/i){
	"infernity gaming";
    }elsif(/Inf/i){
	"infinity";
    }elsif(/Insight/i){
	"insight esports";
    }elsif(/Invasion/i){
	"invasion";
    }elsif(/iG/i){
	"invictus gaming";
    }elsif(/Isurus/i){
	"isurus";
    }elsif(/It\'s Gosu/i){
	"it's gosu esports";
    }elsif(/JoeNet/i){
	"joenet";
    }elsif(/KP/i){
	"kaipi";
    }elsif(/Kawaii/i){
	"kawaii";
    }elsif(/Keita/i){
	"keita gaming";
    }elsif(/LGD/i){
	"lgd gaming";
    }elsif(/LGD\.int/i){
	"lgd international";
    }elsif(/eL\'Pride/i){
	"lions pride";
    }elsif(/LLL/i){
	"lowlandlions";
    }elsif(/MD/i){
	"make dream";
    }elsif(/MYM/i){
	"meet your makers";
    }elsif(/Mineski/i){
	"mineski infinity";
    }elsif(/Minion/i){
	"minion!";
    }elsif(/MiTH/i){
	"mith.trust";
    }elsif(/mMe/i){
	"mme";
    }elsif(/MU/i){
	"moonlight united";
    }elsif(/mTw/i){
	"mortal team work";
    }elsif(/M5/i){
	"moscow five";
    }elsif(/mouz/i){
	"mousesports";
    }elsif(/MSI/i){
	"msi-evogt";
    }elsif(/MUFC/i){
	"mufc";
    }elsif(/MVP/i){
	"mvp";
    }elsif(/N9/i){
	"natural 9";
    }elsif(/Na\`Vi/i){
	"natus vincere";
    }elsif(/navi/i){
	"natus vincere";
    }elsif(/NeoES/i){
	"neolution";
    }elsif(/Neo\.ac/i){
	"neolution\.ac";
    }elsif(/Neo\.int/i){
	"neolution.int";
    }elsif(/Neo\.ino/i){
	"neolution.ino";
    }elsif(/Neo\.th/i){
	"neolution.th";
    }elsif(/NTL/i){
	"netolic";
    }elsif(/NeVo/i){
	"nevo";
    }elsif(/neX\-I/i){
	"nex impetus";
    }elsif(/NEXT/i){
	"next.kz";
    }elsif(/Nirvana/i){
	"nirvana";
    }elsif(/Nirvana\.int/i){
	"nirvana.int";
    }elsif(/NJ&K/i){
	"njkids";
    }elsif(/nth/i){
	"no tidehunter";
    }elsif(/OK/i){
	"online kingdom";
    }elsif(/OoT/i){
	"oot";
    }elsif(/Orange/i){
	"orange";
    }elsif(/OsG/i){
	"oslik gaming";
    }elsif(/Pacific/i){
	"pacific";
    }elsif(/Pacific 2/i){
	"pacific2";
    }elsif(/paiN/i){
	"pain";
    }elsif(/paiN\.int/i){
	"painint";
    }elsif(/PanDa/i){
	"pandarea";
    }elsif(/PSN/i){
	"poseidon";
    }elsif(/PotM/i){
	"potm bottom";
    }elsif(/PR/i){
	"power rangers";
    }elsif(/prOp/i){
	"property";
    }elsif(/Pulse/i){
	"pulse";
    }elsif(/QPAD/i){
	"qpad dragons";
    }elsif(/Quantic/i){
	"quantic gaming";
    }elsif(/QWERT/i){
	"qwert12345";
    }elsif(/rat/i){
	"rat in the dark";
    }elsif(/RSnake/i){
	"rattlesnake";
    }elsif(/RS\.int/i){
	"rattlesnake.int";
    }elsif(/Rvg/i){
	"revenge";
    }elsif(/r3D/i){
	"rigg3d";
    }elsif(/RStars/i){
	"risingstars";
    }elsif(/ROOT/i){
	"root gaming";
    }elsif(/RoX/i){
	"rox";
    }elsif(/SFZ/i){
	"scaryfacez";
    }elsif(/Scythe/i){
	"scythe gaming";
    }elsif(/SOne/i){
	"seasonone";
    }elsif(/sqL/i){
	"sequential";
    }elsif(/Shakira/i){
	"shakira";
    }elsif(/S\.int/i){
	"sigma.int";
    }elsif(/SK/i){
	"sk gaming";
    }elsif(/Skåne/i){
	"skanes elit";
    }elsif(/SH/i){
	"skyhigh";
    }elsif(/Speed/i){
	"speed gaming";
    }elsif(/ST/i){
	"startale";
    }elsif(/SGC/i){
	"storm games clan";
    }elsif(/SnY/i){
	"sushiandyasha";
    }elsif(/Shz/i){
	"svenhunterz";
    }elsif(/SnC/i){
	"sweetnchina";
    }elsif(/SWYC/i){
	"swyc";
    }elsif(/Sym4ny/i){
	"symphony";
    }elsif(/TBA/i){
	"tba";
    }elsif(/TBD/i){
	"tbd";
    }elsif(/TCM/i){
	"tcm-gaming";
    }elsif(/aAa/i){
	"team aaa";
    }elsif(/Dignitas/i){
	"team dignitas";
    }elsif(/DK/i){
	"team dk";
    }elsif(/Empire/i){
	"team empire";
    }elsif(/Infused/i){
	"team infused";
    }elsif(/Life/i){
	"team life";
    }elsif(/tl/i){
	"team liquid";
    }elsif(/Liquid/i){
	"team liquid";
    }elsif(/Menace/i){
	"team menace.fi";
    }elsif(/ONE/i){
	"team one";
    }elsif(/Zenith/i){
	"team zenith";
    }elsif(/Tera/i){
	"tera gaming";
    }elsif(/TTD/i){
	"terrible terrible damage";
    }elsif(/\[A\]/i){
	"the alliance";
    }elsif(/TR/i){
	"the retry";
    }elsif(/Titan/i){
	"titan esports";
    }elsif(/TnC/i){
	"tnc";
    }elsif(/TongFu/i){
	"tongfu";
    }elsif(/top/i){
	"top igrokai";
    }elsif(/TTB/i){
	"ttb";
    }elsif(/Turtle/i){
	"turtle masters";
    }elsif(/TyLoo/i){
	"tyloo";
    }elsif(/uebelstG/i){
	"uebelst";
    }elsif(/ULTI/i){
	"ultimate";
    }elsif(/UR/i){
	"underrateds";
    }elsif(/VG/i){
	"vici gaming";
    }elsif(/VTG/i){
	"virtualthrone";
    }elsif(/VP/i){
	"virtus.pro";
    }elsif(/virtus/i){
	"virtus.pro";
    }elsif(/Virus/i){
	"virus gaming";
    }elsif(/Vivacity/i){
	"vivacity";
    }elsif(/vTG/i){
	"vt gaming";
    }elsif(/w4sp/i){
	"w4sp";
    }elsif(/WhA/i){
	"we haz asian";
    }elsif(/WW/i){
	"western wolves";
    }elsif(/WHB/i){
	"wild honey badgers";
    }elsif(/WE/i){
	"world elite";
    }elsif(/WPC\.A/i){
	"wpc";
    }elsif(/XX5/i){
	"xx5";
    }elsif(/yB/i){
	"youboat";
    }elsif(/Z4/i){
	"z4";
    }elsif(/Zero/i){
	"zero";
    }elsif(/zNation/i){
	"znation";
    }elsif(/zRAGE/i){
	"zrage";
    }
}
