<?php
function do_read($xmlobject,$configuration, $arg){
  print_columns($xmlobject);
  print_rows($xmlobject);
}

function print_columns($xml){
  if (!array_key_exists("thead",$xml) || sizeof($xml->thead) == 0) {
    die("COLUMNS NOT FOUND");
  }
  $titles = (array) $xml->thead[0]->td;
  print_item($titles);
}


function print_rows($xml){
  if (!array_key_exists("tbody",$xml) || sizeof($xml->tbody) == 0) {
    die("ROWS NOT FOUND");
  }
  foreach ( $xml->xpath("./tbody/tr") as $key => $tr) {
    $td = (array) $tr->xpath("./td");
    print_item($td);
  }

}
