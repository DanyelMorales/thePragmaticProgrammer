#!/usr/bin/env perl
package  App::CodeGenerator::AbstractObservable;
use strict;
use warnings;
use App::CodeGenerator::Interfaces::IObservable;
use parent 'App::CodeGenerator::Interfaces::IObservable';
use utf8;
use Scalar::Util 'refaddr';
binmode STDOUT,":encoding(cp850)";

sub new{
  my $class = shift;
  my @observers=();
  my $self = bless {
    observers => \@observers
  }, $class;
  return $self;
};

sub getObservers{
  my $self = shift;
  my @ref = @{$self->{observers}};
  return @ref;
};

sub suscribe{
  my $self = shift;
  my $obj = shift(@_);
  if (!$obj->isa("App::CodeGenerator::Interfaces::IObserver")) {
    die "MUST IMPLEMENTS IObserver interface.";
  }
  my @ref_ = $self->getObservers();
  push @ref_, $obj;
  $self->{observers} = \@ref_;
};

sub remove{
    my $self = shift;
    my $obj = shift(@_);
    my @observers = $self->getObservers();
    my $index = 0;
    $index++ until refaddr($observers[$index]) == refaddr($obj);
    splice(@observers, $index, 1);
    $self->{observers} = \@observers;
    return 0;
};

sub notificateAll{
    my $self = shift;
    my $type = shift(@_);
    my @data = @_;
    my @observers = $self->getObservers();
    foreach  my $observer (@observers){
      $observer->update($type,@data);
    }
};
return 1;
