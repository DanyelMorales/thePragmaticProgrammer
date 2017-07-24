<?php
function loadOperation($operation, $configuration, $argv){
  $opfile = "$operation.php";
  if (file_exists($opfile)) {
     $method = "do_$operation";
     include $opfile;
     $method(getXML($configuration["tmp"]["output"]),$configuration, $argv);
     return true;
  }
  die("OPERATION HANDLER NOT FOUND: $opfile");
  return false;
}

function printHelp($allowed, $msg = "[+]"){
    echo $msg;
    print join(",", $allowed);
}

function getPath($configuration, $xmlfile){
  $file = $configuration['books']."$xmlfile.xml";
    return realpath($file);
}

function getXML($xmlfile){
  return  new SimpleXMLElement(file_get_contents($xmlfile));
}

function print_item($items){
    $str  = join("\t\t",$items);
    print($str) . "\n";
    print str_repeat("-", 80 ) . "\n";
}

function saveXML($xml, $path){
    file_put_contents($path,$xml->asXML());
}
