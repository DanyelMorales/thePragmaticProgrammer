#!/usr/local/bin/perl
package t::App::CodeGenerator::AbstractObservable;

use strict;
use warnings;
use Test::More;
use App::CodeGenerator::AbstractObservable;
use t::App::CodeGenerator::Generators::Fixture;

my $analyzer=undef;
my $fixture=undef;
sub setup {
  $analyzer=App::CodeGenerator::AbstractObservable->new;
  $fixture=t::App::CodeGenerator::Generators::Fixture->new;
};

sub tearDown {

};

###########################################################
subtest 'getObservers' => sub {
  setup();
  my @arr = $analyzer->getObservers();
  is(scalar @arr, 0);
};
subtest 'suscribe' => sub {
  setup();
  $analyzer->suscribe($fixture);
  $analyzer->suscribe($fixture);
  $analyzer->suscribe($fixture);
  my @arr = $analyzer->getObservers();
  is(scalar @arr, 3);
};
subtest 'remove' => sub {
  setup();
  my $o1=t::App::CodeGenerator::Generators::Fixture->new;
  my $o2=t::App::CodeGenerator::Generators::Fixture->new;
  my $o3=t::App::CodeGenerator::Generators::Fixture->new;
  $analyzer->suscribe($o1);
  $analyzer->suscribe($o2);
  $analyzer->suscribe($o3);

  my @arr = $analyzer->getObservers();
  is(scalar @arr, 3);

  $analyzer->remove($o3);
  $analyzer->remove($o1);
  @arr = $analyzer->getObservers();
  is(scalar @arr, 1);
};
subtest 'notificateAll' => sub {
  setup();
  my $o1=t::App::CodeGenerator::Generators::Fixture->new;
  my $o2=t::App::CodeGenerator::Generators::Fixture->new;
  my $o3=t::App::CodeGenerator::Generators::Fixture->new;
  $analyzer->suscribe($o1);
  $analyzer->suscribe($o2);
  $analyzer->suscribe($o3);

  my @arr = $analyzer->getObservers();
  is(scalar @arr, 3);

  $analyzer->notificateAll("A","B");
  is($o1->getUpdated(), "yes");
  is($o2->getUpdated(), "yes");
  is($o3->getUpdated(), "yes");
};
###########################################################
done_testing();

1;
