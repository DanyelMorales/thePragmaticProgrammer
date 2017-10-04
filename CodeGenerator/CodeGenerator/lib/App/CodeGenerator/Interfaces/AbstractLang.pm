# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Interfaces::AbstractLang;
use strict;
use warnings; 
use utf8;
binmode STDOUT,":encoding(cp850)";
use parent 'App::CodeGenerator::Interfaces::ILang';
use parent 'App::CodeGenerator::Interfaces::IObserver';

sub new{
  my $class = shift;
  my @lines = ();
  my $self = bless {
      lines => \@lines
  }, $class;
  return $self;
};

sub getLines{
  my $self = shift;
  my $ref = $self->{lines};
  return  @{$ref};
};

sub update{
  my $self = shift;
  my $type = shift(@_);
  my @data = @_; 

  if($type eq "SingleComment"){
	$self->doSingleComment(@data);
  } 
  
  if($type eq "Class_"){
	$self->doClass(@data);
  } 
  
  if($type eq "EndOfClass"){
	$self->doEndOfClass(@data);
  } 
  
  if($type eq "Field"){
	$self->doField(@data);
  }
  
}

sub doSingleComment{
	my $self = shift;
	die "You cannot create an instance of me directly\n";
};

sub doClass{
	my $self = shift;
	die "You cannot create an instance of me directly\n";
};

sub doEndOfClass{
	my $self = shift;
	die "You cannot create an instance of me directly\n";
};

sub doField{
	my $self = shift;
	die "You cannot create an instance of me directly\n";
};


1;
