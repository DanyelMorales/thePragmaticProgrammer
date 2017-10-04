#!/usr/local/bin/perl
package t::App::CodeGenerator::test::Util;
use App::CodeGenerator::php::main;

sub new{
  my $class = shift;
  my $self = bless {
    php => App::CodeGenerator::php::main->new
  }, $class;
  return $self;
};

sub getPath{
  my $self = shift;
  my $file = shift(@_);
  my $php = $self->{php};
  my @arr = ($php->__CWD__(), $file);
  return join($php->DIRECTORY_SEPARATOR(), @arr);
};


return 1;
