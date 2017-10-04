#!/usr/local/bin/perl
package t::App::CodeGenerator::CodeGenerator;
use strict;
use warnings;
use Test::More;
use App::CodeGenerator;
use t::App::CodeGenerator::Generators::Fixture;
use App::CodeGenerator::php::main;

my $analyzer=undef;
my $fixture=undef;
my $php=undef;

sub setup {
  $analyzer=App::CodeGenerator->new;
  $fixture=t::App::CodeGenerator::Generators::Fixture->new;
  $php=App::CodeGenerator::php::main->new();
};

sub tearDown {

};

###########################################################
subtest 'getLangPath' => sub {
  setup();
    my $path = $analyzer->_getLangPath('App::CodeGenerator::Generators::');
    ok($path =~  m/App\/CodeGenerator\/Generators\//ig);
};

subtest 'loadComponent' => sub {
  setup();
  my $component = $analyzer->loadComponent("C");
  ok($component);
  isa_ok($component, 'App::CodeGenerator::Interfaces::ILang');
};

subtest 'getLangs' => sub {
  setup();
  my @component = $analyzer->getLangs('App::CodeGenerator::Generators::');
  ok(@component);
  ok(scalar @component > 0);
};

subtest 'loadLangs' => sub {
  setup();
  my @component = $analyzer->loadLangs();
  ok(@component);
};

subtest 'readSources' => sub {
  setup();
  $analyzer->loadLangs();
  my $source = $php->__CWD__()."/t/Fixture/source/";
  my $resp =  $analyzer->readSources($source, ('ex.map', 'ax.map'));
  ok($resp);
  ok(scalar $analyzer->getAnalyzer()->getObservers() > 0);
};

subtest 'build' => sub {
  setup();
  $analyzer->loadLangs();
  my $source = $php->__CWD__()."/t/Fixture/source/";
  my $resp =  $analyzer->build($source);
  ok($resp);
  ok(scalar $analyzer->getAnalyzer()->getObservers() > 0);
};



###########################################################
done_testing();
