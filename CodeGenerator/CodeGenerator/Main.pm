use strict;
use warnings;
use App::CodeGenerator;
use App::CodeGenerator::php::main;

my $output = $ARGV[0];
my $source = $ARGV[1];
my $analyzer=App::CodeGenerator->new($output); 
$analyzer->loadLangs();
my $resp =  $analyzer->build($source);

print ($resp?"DONE IN OUTPUT FOLDER":"ERROR");