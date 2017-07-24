<?php
function do_insert($xmlobject, $configuration, $arg){
  $type = array_shift($arg);
  if (!in_array($type, $configuration["insertions"])) {
    die("INSERTION FAILED!");
  }
  $method = "insert_".$type;
  $method($xmlobject, $arg);
  saveXML($xmlobject, $configuration["tmp"]["output"]);
}


function insert_col($xml, $arg){
    $titles = $xml->thead[0];
    foreach ($arg as  $value) {
       $titles->addChild("td",$value);
    }
}

function insert_row($xml, $arg){
  $titles = $xml->tbody;
  $tr = $titles->addChild("tr");
  foreach ($arg as  $value) {
      $tr->addChild("td",$value);
  }
}
