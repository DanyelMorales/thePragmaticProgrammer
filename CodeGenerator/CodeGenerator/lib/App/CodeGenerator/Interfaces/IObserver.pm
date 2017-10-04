# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Interfaces::IObserver;

sub new{
  my $class = shift;
  my $self = bless {
  }, $class;
    die "You cannot create an instance of me directly\n";
  return $self;
};

sub update{
    die "You cannot create an instance of me directly\n";
};

1;
