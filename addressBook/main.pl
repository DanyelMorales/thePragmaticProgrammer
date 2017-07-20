#!/usr/bin/environment -d perl
use strict;
use warnings;

my @addressBook = ();
my $addressName=$ARGV[0].".bin";
shift(@ARGV);

sub addRegistry{
	if( !-e $addressName || -s $addressName eq 0  ){
		insert("name","lastname","phone");
	}
	insert($ARGV[0], $ARGV[1], $ARGV[2]);
	commit();
}

sub show{
	load();
	foreach my $data (@addressBook)
	{
		print join('|', @{$data});
	}
};


sub insert{
  my $name = shift(@_);
  my $lastname = shift(@_);
  my $phone = shift(@_);  
  push @addressBook,[$name, $lastname, $phone]; 
}

sub commit{
	open MYFILE, ">>".$addressName or die $_;
	foreach my $data(@addressBook)
	{	
		my $row = join "|", @{$data};
		my( $hex ) = unpack( 'H*', $row ."\n");       
		print MYFILE "$hex";
	}
	close(MYFILE);
}

sub getRow{
	my $line = shift(@_);
	return (split /0a/, $line );
};

sub loadRow{
	my $line = shift(@_);
	my @rows = getRow($line);
	foreach my $row(@rows){
		my($clear) = pack('H*', $row). "\n";
		my @arr = split "\Q|\E",$clear;
		push @addressBook, [@arr];
	}
};

sub load{
	@addressBook = ();
    open my $FILE, "<".$addressName or die $_;
	chomp(my @lines = <$FILE>);
    close($FILE);
	foreach my $line(@lines){
		loadRow(@lines);
	}
}

##################
addRegistry();
show();