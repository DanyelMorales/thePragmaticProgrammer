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

sub isStrictable {
  my $line = shift(@_);
  my $hasStrict = shift(@_);
  if (!isComment($line) && !isStrict($line) && !$hasStrict) {
    return 1;
  }
  return 0;
};

sub readFile{
	my $filename = shift(@_);
	my $hasStrict = 0;
	my $tmpFile = "$filename.tmp";
	open FILE, "<$filename" or die $!;
	while (<FILE>) {
	  chomp;
	  my $line = $_;
	  if (isStrictable($line, $hasStrict)) {
		$hasStrict = 1;
	  }
	  elsif(isStrict($line)){
		$hasStrict = 1;
	  }
	  writeTempFile($tmpFile, $line);
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
