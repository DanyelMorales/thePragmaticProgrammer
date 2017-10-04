#!/usr/local/bin/perl
package t::App::CodeGenerator::Map;

use strict;
use warnings;
use Test::More;
use App::CodeGenerator::Map;

my $map=undef;
sub setup {
  $map=App::CodeGenerator::Map->new;
};

sub tearDown {

};

###########################################################
subtest 'get' => sub {
  setup();
  ok($map->get("Langs"));
};

subtest 'testIndexWithLine' => sub {
  setup();
  my @resp = $map->testIndexWithLine("Class_", "M a");
  is(scalar @resp, 1);
  @resp =  $map->testIndexWithLine("Class_", "aaa");
  is(scalar @resp, 0);
};
subtest 'properties' => sub {
  setup();
  my @resp = $map->getProperties();
  ok(scalar @resp > 1);
};
subtest 'test' => sub {
  setup();
  my @resp = $map->test("M a");
  my $token  = shift(@resp);
  is($token, "Class_");
  @resp = $map->test("sxa");
  $token  = shift(@resp);
  is($token, 0);

};
subtest 'tokens' => sub {
  setup();
  my @resp = $map->test("E");
  my $token  = shift(@resp);
  is($token, "EndOfClass");

  @resp = $map->test("# comments ");
  $token  = shift(@resp);
  is($token, "SingleComment");
  is(join("",@resp), "comments ");

  @resp = $map->test("Langs c,pl");
  $token  = shift(@resp);
  is($token, "Langs");
  is(join("",@resp), "c,pl");

  @resp = $map->test("F myvar int[12]");
  $token  = shift(@resp);
  is($token, "Field");
  is($resp[0], "myvar");
  is($resp[1], "int");
  is($resp[2], "12");
  is(join("",@resp), "myvarint12");

};
###########################################################
done_testing();

1;
