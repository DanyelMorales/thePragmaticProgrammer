# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Generators::Pascal;
use strict;
use warnings;
use parent 'App::CodeGenerator::Interfaces::AbstractLang'; 
binmode STDOUT,":encoding(cp850)";
 
sub getMetaData{

};

sub getFileName{
	my $self = shift;
	my $name = shift(@_);
    return  $name  . ".pascal";
};

sub doSingleComment{
	my $self = shift;
	my ($comment)= shift(@_);
	my $str = "{" .$comment . "}";
	push @{$self->{lines}}, $str ;
};

sub doClass{
	my $self = shift;
	my ($className )= shift(@_);
	push @{$self->{lines}}, "$className = packed record";
};

sub doEndOfClass{
	my $self = shift;
	my $str = "end;";
	push @{$self->{lines}}, $str ;
};

sub doField{
	my $self = shift;
	my ($varname, $vartype, $varSize )= @_;
	my $str =  "$varname: ";
	
	if($varSize){
		$str .= "array[0.." . $varSize . "] of "
	}
	
	$str .= $vartype . ";";
	push @{$self->{lines}}, "\t".$str ;
};


 
1;

