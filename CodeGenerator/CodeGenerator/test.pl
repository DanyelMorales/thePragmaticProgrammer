#!/usr/local/bin/perl
package App::Gchlog;
use App::Gchlog::Shared::CommonDKLib;
use Module::Load;

# ALIAS DE USE
# *NSTypes:: = *App::Gchlog::Shared::Loader::NSTypes::;
load "App::Gchlog::Formater::FileFormater::FileFormater";

$myFormater = "App::Gchlog::Formater::FileFormater::FileFormater";

my @collection = ("Merge ","MERGE ","fix");
my $notAllowed =   App::Gchlog::Shared::CommonDKLib::getOptionalsRgx(@collection);
my $newFileFormater = $myFormater->new('rawlog.txt', $notAllowed);

if ($newFileFormater->isa("App::Gchlog::Shared::Interfaces::Formater::BaseDKFormater") || $newFileFormater->can("getChangeLog")) {
  print $newFileFormater->noVerbose(0)->getChangeLog();
}

1;
