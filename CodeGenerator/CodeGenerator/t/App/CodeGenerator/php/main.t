#!/usr/local/bin/perl
package t::App::CodeGenerator::php::main;

use strict;
use warnings;
use Test::More;
use App::CodeGenerator::php::main;
use t::App::CodeGenerator::test::Util;

my $php = undef;
my $testUtil = undef;
sub setup {
  $php = App::CodeGenerator::php::main->new;
  $testUtil =  t::App::CodeGenerator::test::Util->new;
};

sub tearDown {

};

###########################################################
subtest 'DIRECTORY SEPARATOR' => sub {
  setup();
  my $ds = $php->DIRECTORY_SEPARATOR();
  is($ds, '/');
};

subtest '__CWD__ SEPARATOR' => sub {
  setup();
  my $cwd = $php->__CWD__();
  like($cwd, qr/CodeGenerator/);
};

subtest '__DIRECTORY__' => sub {
  setup();
  my $cwd = $php->__DIRECTORY__();
  like($cwd, qr/php/);
};

subtest 'getPath' => sub {
  setup();
  my $path = $testUtil->getPath("t/Fixture/foo.txt");
  like($path, qr/t\/Fixture\/foo.txt/);
};

subtest 'file_get_contents' => sub {
  setup();
  ok(-e $testUtil->getPath("t/Fixture/foo.txt"));
  my $filename = $testUtil->getPath("t/Fixture/foo.txt");
  my @content = $php->file_get_contents($filename);
  like(join('\n',@content), qr/bar/);
};

subtest 'file_put_contents' => sub {
  setup();
  my $filename = $testUtil->getPath("t/Fixture/foo_123.txt");
  my @content = ("1","2","3");
  $php->file_put_contents($filename, @content);
  ok(-e $testUtil->getPath("t/Fixture/foo_123.txt"));
};

###########################################################
done_testing();

1;
