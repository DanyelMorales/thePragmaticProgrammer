<?php
require "util.php";
/* deleting index 0*/
array_shift($argv);
$operation = array_shift($argv);
$book = array_shift($argv);
$configuration = require "configuration.php";
$allowed =  $configuration["allowed"];

if (in_array($operation, $allowed)) {
  $path = getPath($configuration, $book);
  $configuration["tmp"]["output"]=$path;
  loadOperation($operation,$configuration, $argv);
  return 1;
}

printHelp($allowed, "OPERATION $operation NOT ALLOWED, ALLOWED: ");
return 0;
