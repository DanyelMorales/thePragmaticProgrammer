%commands = (
	P => "[0-9]+",
	D => "",
	COLOR => " *([a-zA-Z])* +([a-zA-Z])*",
	W => "[0-9]+",
	N => "[0-9]+",
	E => "[0-9]+", 
	S => "[0-9]+",
	U => ""
);

sub do_COLOR{
	my ($value, $rule) = @_;
	my @capture = @_; 
	my @colors = split / /, $value;
	
	if(!@colors){
		return 0;
	}
	
	my $color = sprintf "'%s','%s'", $colors[1], $colors[2];
	my $code = "turtle.color($color)";
	addPythoner($code);
	return 1;
};

sub do_P{
	my ($value, $rule) = @_;
	my @capture = @_;
	$code = "turtle.pensize(".$capture[0].")";
	addPythoner($code);
	return 1;
};

sub do_D{
	my ($value, $rule) = @_;
	my @capture = @_;
	$code = "turtle.pendown()";
	addPythoner($code);
	return 1;
};

sub do_W{
	my ($value, $rule) = @_;
	my @capture = @_;
	my $scale = getScale($capture[0]);
	addPythoner("turtle.seth(180)");
	addPythoner("turtle.forward(".$scale.")");
	return 1;
};

sub do_N{
	my ($value, $rule) = @_;
	my @capture = @_;	
	my $scale = getScale($capture[0]);
	addPythoner("turtle.seth(90 )");
	addPythoner("turtle.forward(".$scale.")");
	return 1;
};

sub do_E{
	my ($value, $rule) = @_;
	my @capture = @_;	
	my $scale = getScale($capture[0]);
	addPythoner("turtle.seth(0)");
	addPythoner("turtle.forward(".$scale.")");
	return 1;
};

sub do_S{
	my ($value, $rule) = @_;
	my @capture = @_;	
	my $scale = getScale($capture[0]);
	addPythoner("turtle.seth(270)");
	addPythoner("turtle.forward(".$scale.")");
	return 1;
};

sub do_U{
	my ($value, $rule) = @_;
	my @capture = @_;
	$code = "turtle.penup()";
	addPythoner($code);
	return 1;
};

return 1;