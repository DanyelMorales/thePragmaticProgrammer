# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator;

use strict;
use warnings;
use App::CodeGenerator::SyntacticAnalyzer;
use App::CodeGenerator::php::main;
use Module::Load;
use 5.010;

sub new{
  my $class = shift;
  my $output = shift(@_);
  my $self = bless {
	  output=> $output? $output : "output",
      NSLang => 'App::CodeGenerator::Generators::',
      NSLangParent=>'App::CodeGenerator::Interfaces::ILang',
      analyzer=>App::CodeGenerator::SyntacticAnalyzer->new(),
      php=>App::CodeGenerator::php::main->new(),
      modext=>qr/\.pm$/
  }, $class;
  return $self;
};

sub getAnalyzer{
  my $self = shift;
  return $self->{analyzer};
};

sub _getLangPath{
    my $self = shift;
    my $NS = shift(@_);
    my $cwd = $self->{php}->__CWD__() . "/lib/";
    my $normalized = $NS =~ s/::/\//gir;
    return $cwd . $normalized;
};

sub loadComponent{
  my $self = shift;
  my $lang = shift(@_);
  my $nsComponent = $self->{NSLang}.$lang;
  load $nsComponent;
  my $component = $nsComponent->new();
  if (!$component->isa($self->{NSLangParent})) {
    return 0;
  }
  $self->{analyzer}->suscribe($component);
  return $component;
};

sub getLangs{
    my $self = shift;
    my $path =  $self->_getLangPath(shift(@_)) ;
    my @langs = $self->{php}->list_files_in($path);
    if (scalar @langs == 0) {
      return 0;
    }
    return @langs;
};

# TODO error handling
sub loadLangs{
  my $self = shift;
  my @langs = $self->getLangs($self->{NSLang});
  load $self->{NSLangParent};
  foreach my $lang (@langs) {
    $lang =~ s/$self->{modext}//;
    if (!$self->loadComponent($lang)) {
      return 0;
    }
  }
  return 1;
};

sub readSources{
    my $self = shift;
    my ($path)= shift(@_);
	my @files = @_;
    foreach my $file_ (@files) {
        my @lines = $self->{php}->file_get_contents($path.$file_);
        if (scalar @lines <= 0) {
			die("Cannot read lines in $file_");
        }
        $self->{analyzer}->parse(@lines);
		$self->saveOutput($file_);
    }
    return 1;
};

sub saveOutput{
	my $self = shift;
	my $filename = shift(@_);
	foreach my $observer ($self->{analyzer}->getObservers()){
		my $_output = $self->{output} . "/" . $observer->getFileName($filename);
		$self->{php}->file_put_contents($_output, $observer->getLines());
	 }
};


#files
sub build{
  my $self = shift;
  my $path = shift(@_);
  my @files = $self->{php}->list_files_in($path);
  
  if (scalar @files <= 0) {
    return 0;
  }
  
  $self->readSources($path,@files);
  return 1;
};


1;
