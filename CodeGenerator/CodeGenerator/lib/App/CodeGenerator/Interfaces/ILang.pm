# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Interfaces::ILang;

sub new{
  my $class = shift;
  my $self = bless {
  }, $class;
    die "You cannot create an instance of me directly\n";
  return $self;
};

sub getFileName{
    die "You cannot create an instance of me directly\n";
};

sub getGeneratedCode{
    die "You cannot create an instance of me directly\n";
};

sub getMetaData{
    die "You cannot create an instance of me directly\n";
};

1;
