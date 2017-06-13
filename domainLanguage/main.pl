require "./lib/pythoner.pl";
require "./lib/rules.pl";

$file = $ARGV[0];
$output = "./tmp/myownturtle.py";
@cmdNames = keys %commands;
$cmdRegex = "^(" . join("|", @cmdNames) . ")(.*)\$";

initPythoner();
parse();

sub writeCoded{
	open (FILE, "> $output") || die "problem opening $output\n";
	print FILE getPythonerCode();
	close(FILE);
};
sub parse{ 
	readf($file);
	writeCoded();
	system("py $output");
};

sub parseLine{
	my $line = shift(@_);
	$line =~ s/(#.*)/ /g;
	my @capture = ($line =~ m/$cmdRegex/);
	if(!@capture){
		return 0;
	};
	return @capture;
};

sub parseCommand{
	my ($cmd, $value) = @_;
	if(!exists $commands{$cmd})
	{
		return 0;
	}
	my $rule = %commands{$cmd};  
	my @capture = ($value =~ m/($rule)/);
	
	if(!@capture){
		return 0;
	}
	
	my $call = "do_$cmd";
	if(&$call($value,$rule,@capture))
	{
		return 1;
	}
	
	print "COULD NOT BE PARSED: $cmd => $value";
	return 0;
};

sub readf{
	my $file = shift(@_);
	open (MYFILE, "<:encoding(utf8)", $file)
        or die "Can't open '$file': $!"; 
		
	while (<MYFILE>) {
	   chomp;
	   my $line = $_;
	   my @parsed = parseLine($line);
	   
	   if(@parsed){
	   	   parseCommand(@parsed)
	   }

	}
	close (MYFILE);
};
