#!/usr/local/bin/perl
package t::App::CodeGenerator::SyntacticAnalyzer;

use strict;
use warnings;
use Test::More;
use App::CodeGenerator::SyntacticAnalyzer;
use t::App::CodeGenerator::Generators::Fixture;

my $analyzer=undef;
my $fixture=undef;

sub setup {
  $analyzer=App::CodeGenerator::SyntacticAnalyzer->new;
  $fixture=t::App::CodeGenerator::Generators::Fixture->new;
};

sub tearDown {

};

###########################################################
subtest 'analyze' => sub {
  setup();
  $analyzer->suscribe($fixture);
  $analyzer->analyze("# comment ");
  $analyzer->analyze("# c ");
  $analyzer->analyze("# a ");
  is($fixture->getConcatenated(), "->comment ->c ->a ");
};
subtest 'parse' => sub {
  setup();
  $analyzer->suscribe($fixture);
  my @lines = ("# comment ","# c ", "# a ");
  $analyzer->parse(@lines);
  is($fixture->getConcatenated(), "->comment ->c ->a ");
};
###########################################################
done_testing();

1;
