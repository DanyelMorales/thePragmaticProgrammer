my @c_lexer = (
	"int" => "LongInt",
	"(?<type>\s+)\[(?<arrayLen>\d*)\]" => "array[0..%arrayLen%] of %type%",
	"" => "",
);
my @c_sintac = (
	"" => "",
	"" => "",
	"" => "",
	);