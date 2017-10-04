# bin/script.pl
#!/usr/bin/env perl
package  App::CodeGenerator::Interfaces::IObservable;

sub new{
  my $class = shift;
  my $self = bless {
  }, $class;
    die "You cannot create an instance of me directly\n";
  return $self;
};
sub suscribe{
    die "You cannot create an instance of me directly\n";
};
sub remove{
    die "You cannot create an instance of me directly\n";
};
sub notificateAll{
    die "You cannot create an instance of me directly\n";
};


1;
