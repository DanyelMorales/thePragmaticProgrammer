#!/usr/bin/env perl
package  App::CodeGenerator::SyntacticAnalyzer;
use strict;
use warnings;
use App::CodeGenerator::AbstractObservable;
use App::CodeGenerator::Map;
use parent 'App::CodeGenerator::AbstractObservable';
use utf8;
use Scalar::Util 'refaddr';
binmode STDOUT,":encoding(cp850)";

sub new{
  my $class = shift;
  my @observers=();
  my $self = bless {
    Map => App::CodeGenerator::Map->new,
    observers => \@observers
  }, $class;
  return $self;
};

##
# TODO: throw error on false or null result
#
#line
sub analyze{
    my  $self = shift;
    my  $line = shift(@_); 
    my @result = $self->{Map}->test($line);
    if (!@result) {
      return 0;
    } 
    $self->notificateAll(@result);
    return 1;
};

#file
sub parse{
  my $self = shift;
  my @lines = @_;
  for my $line (@lines){
    $self->analyze($line);
  }
};

1;
