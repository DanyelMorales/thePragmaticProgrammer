#!/usr/bin/perl

use strict;
use warnings;

sub isComment {
  my $line = shift(@_);
  my $commentRegex = qr/^(?: *)?#+/;
  if ($line =~ $commentRegex) {
    return 1;
  } else {
    return 0;
  }
};

sub isStrict {
  my $line = shift(@_);
  my $strictRegex = qr/use strict/;
  if ($line =~$strictRegex) {
    return 1;
  }

  return 0;
};

sub writeTempFile {
  my $tempFile = shift(@_);
  my $line = shift(@_);
  open TMP, ">>$tempFile" or die $!;
  print TMP "$line\n";
  close(TMP);
};

sub verifyStrict{
	 my $line = shift(@_);
	 my $hasStrict = shift(@_);
	 my $tmpFile  = shift(@_);

	  if(isStrict($line) && $hasStrict){
			return 1;
	  }
	  elsif(isStrict($line) && !$hasStrict){
		$hasStrict = 1;
	  }
	  elsif (!isComment($line) && !isStrict($line) && !$hasStrict) {
		$hasStrict = 1;
		writeTempFile($tmpFile, "use strict;");
	  }
	  writeTempFile($tmpFile, $line);
	  return $hasStrict;
};

sub readFile{
	my $filename = shift(@_);
	my $hasStrict = 0;
	my $tmpFile = "$filename.tmp";
	open FILE, "<$filename" or die $!;
	while (<FILE>) {
	  chomp;
	  my $line = $_;
	  $hasStrict = verifyStrict($line, $hasStrict, $tmpFile);
	}
	close(FILE);
	rename $tmpFile,$filename;
};

sub readFiles{
	 my $path = shift(@_);
	 my @files = < $path >;
	 foreach my $file_ (@files) {
		readFile($file_);
	 }
};

readFiles($ARGV[0]);
