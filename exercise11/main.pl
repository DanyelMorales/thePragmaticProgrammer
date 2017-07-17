#!/usr/bin/perl

use strict;
use warnings;

sub getOutputPath{
  my $filename = shift(@_);
  my $ext = shift(@_);
  my $path  = "$filename";
  my $file = "$filename.$ext";   mkdir $path;
  if (!-e $path) {
    mkdir $path;
  }
  return  "$path/$file";
};
sub writeHead {
    my $filename = shift(@_);
    my @body = @_;
    my $head = "extern const char* %s_names[];\ntypedef enum {\n\t%s\n}%s;\n";

    my $code = sprintf $head, $filename,  getBodyOfCode(@body), $filename;
    my $newFile = getOutputPath($filename,"h");
    writeFile($newFile, $code);
};

sub writeCode {
    my $filename = shift(@_);
    my @body = @_;
    my $head = "const char* %s_names[] = \n{\n\t%s\n};\n";
    my @tmp = map {"\"$_\""} @body;
    my $code = sprintf $head, $filename, getBodyOfCode(@tmp);
    my $newFile = getOutputPath($filename,"c");
    writeFile($newFile, $code);
};

sub getBodyOfCode{
    my @body = @_;
    return join(",\n\t", @body) . ",";
};
sub writeFile{
  my $filename = shift(@_);
  my $content = shift(@_);
  open FILE, ">$filename" or die $!;
  print FILE $content;
  close(FILE);
};

sub readFile{
	my $filename = shift(@_);
	open my $FILE, "<$filename" or die $!;
  chomp(my @lines = <$FILE>);
	close($FILE);
  return @lines;
};

sub readFiles{
	 my $path = shift(@_);
	 my @files = < $path >;
	 foreach my $file_ (@files) {
		my @lines = readFile($file_);
    my $name = (shift  @lines);
    $name =~ tr/[[:lower:]]/[[:upper:]]/;
    writeCode($name,@lines);
    writeHead($name,@lines);
	 }
};

readFiles($ARGV[0]);
