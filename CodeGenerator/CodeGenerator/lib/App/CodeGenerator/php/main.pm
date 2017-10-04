#!/usr/local/bin/perl
package App::CodeGenerator::php::main;
use strict;
use warnings;
use Cwd;
use File::Spec;
use File::Basename;

sub new{
  my $class = shift;
  my $self = bless {
  }, $class;
  return $self;
};

sub list_files_in{
  my $self = shift;
  my ($path) = shift(@_);
  opendir(DIR, $path) or die $!;
  my @langs = ();
  while (my $file = readdir(DIR)) {
     next unless (-f "$path/$file");
     push @langs, $file;
 }
 closedir(DIR);
 return @langs;
};
sub file_get_contents{
  my $self = shift;
  my $filename = shift(@_);
	open my $FILE, "<$filename" or die $!."==>".$filename;
  chomp(my @lines = <$FILE>);
	close($FILE);
  return @lines;
};

sub file_put_contents{
  my $self = shift;
  my $filename = shift(@_);
  my @content = @_;
  
	open my $FILE, ">$filename" or die $!."==>".$filename;
	foreach my $line (@content){
		print $FILE $line."\n";
	}
	close($FILE);
};

sub DIRECTORY_SEPARATOR{
  return File::Spec->catfile('', '');
};

sub __CWD__{
  return  getcwd();
};

sub __DIRECTORY__{
    return dirname(__FILE__);
};

return 1;
