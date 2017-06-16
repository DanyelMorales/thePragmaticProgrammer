$time = $ARGV[0];
###
#4pm    valido
#3:16am valido
#7:38pm valido
#23:42  valido
#3:16   valido
#32:56  NO VALIDO
###
if($time =~ m/((([01][0-9]|\b[2]?[0-3]):[0-5][0-9])\b)|(([1-9][0-2]|[1-9])(:[0-5][0-9])?(pm|am))/gi){
	print "LA HORA ES VALIDA";
}
else{
	print "FORMATO INVALIDO";
}