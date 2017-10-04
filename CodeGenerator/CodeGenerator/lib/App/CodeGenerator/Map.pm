#!/usr/bin/env perl
package  App::CodeGenerator::Map;
use strict;
use warnings;

sub new{
  my $class = shift;
  my $self = bless {
    map =>  {
      Langs => qr/^\s*Langs\s*(?:([\w,]+)?)/,
      SingleComment => qr/^\s*#\s*(.*?)\S*$/,
      Field => qr/^\s*F\s+(\w+)\s+(\w+)(?:\[(\d+)\])?\s*$/,
      Class_ => qr/^\s*M\s+(\w+)/,
      EndOfClass => qr/^\s*E\s*/
    }
  }, $class;
  return $self;
};

sub get{
  my $self = shift;
  my $index = shift(@_);
  return $self->{map}->{$index};
};

sub testIndexWithLine{
  my $self = shift;
  my $index = shift(@_);
  my $line = shift(@_);
  my $rgx = $self->{map}->{$index};
  return $line =~ $rgx;
};

sub getProperties{
    my $self = shift;
    my %tokens = %{$self->{map}};
    my @keys= keys %tokens;
    return @keys;
};

sub test{
  my $self = shift;
  my $line = shift(@_);
  $line =~ s/\p{Cc}//gi;
  foreach my $token ($self->getProperties()){
    my @result = $self->testIndexWithLine($token, $line);
    if (@result) {
      return ($token, @result);
    }
  }
  return 0;
};

return 1;
