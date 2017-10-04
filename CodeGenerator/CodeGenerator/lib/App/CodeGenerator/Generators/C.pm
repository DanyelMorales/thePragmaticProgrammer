# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Generators::C;

use strict;
use warnings;
use parent 'App::CodeGenerator::Interfaces::AbstractLang'; 
binmode STDOUT,":encoding(cp850)";
 
sub getMetaData{

};

sub getFileName{
	my $self = shift;
	my $name = shift(@_);
    return  $name  . ".c";
};


sub doSingleComment{
	my $self = shift;
	my ($comment)= shift(@_);
	my $str = "/*$comment*/";
	push (@{$self->{lines}}, $str);
};

sub doClass{
	my $self = shift;
	my ($className )= shift(@_);
	$self->{className} = $className;
	push @{$self->{lines}}, "typedef struct{" ;
};

sub doEndOfClass{
	my $self = shift;
	my $str = "} " . $self->{className} . ";";
	push @{$self->{lines}}, $str ;
};

sub doField{
	my $self = shift; 
	my ($varname, $vartype, $varSize )= @_;
	my $str = $vartype . " " . $varname;
	if($varSize){
		$str .= "[" . $varSize . "]"
	}
	$str .= ";";
	push @{$self->{lines}}, "\t".$str ;
};


1;
