# bin/script.pl
#!/usr/bin/env perl
package  t::App::CodeGenerator::Generators::Fixture;

use strict;
use warnings;
use parent 'App::CodeGenerator::Interfaces::ILang';
use parent 'App::CodeGenerator::Interfaces::IObserver';
use utf8;
binmode STDOUT,":encoding(cp850)";

sub new{
  my $class = shift;
  my @lines = ("#hola", "foo", "bar");
  my $self = bless {
    updated => 'no',
	lines => \@lines,
    concatenated => ''
  }, $class;
  return $self;
};

sub parseClass{

};

sub parseField{

};

sub parseSingleComment{

};

sub getFileName{
    return "myprogram.test";
};

sub getUpdated{
  my $self = shift;
  return $self->{updated};
};

sub getConcatenated{
  my $self = shift;
  return $self->{concatenated};
};

sub getLines{
  my $self = shift;
  my $ref = $self->{lines};
  return  @{$ref};
};

sub update{
  my $self = shift;
  my $b = shift(@_);
  my @a = @_; 
  
  $self->{updated}='yes';
  $self->{concatenated} .="->". join("",@a);
  return 1;
};

1;
