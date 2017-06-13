@pythoner = ();

sub getScale{
	my $integer = shift(@_);
	return $integer * 100;
};

sub initPythoner{
	@pythoner = ();
	push @pythoner , "import turtle";
	push @pythoner , "turtle.color('red', 'yellow')";
	push @pythoner , "turtle.begin_fill()";
};

sub addPythoner{
	my $value = shift(@_);
	push @pythoner, $value;
};

sub closePythoner{
	push @pythoner, "turtle.end_fill()";
	push @pythoner, "turtle.done()";
};
sub getPythoner{
	closePythoner();
	return @pythoner;
};

sub getPythonerCode{
	return join("\n", getPythoner());
};

return 1;