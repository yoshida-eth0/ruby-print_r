<?php

$arr = array(
  "string" => "HelloWorld!\nHelloWorld!\nHelloWorld!",
  "integer" => 123,
  "float" => 123.456,
  "true" => true,
  "false" => false,
  "null" => null,
  "array" => array(
    "value1",
    "value2",
    "value3",
  ),
  "hash" => array(
    "key1" => "value1",
    "key2" => "value2",
    "key3" => "value3",
  ),
);

$obj = new stdClass();
$obj->key1 = "value1";
$obj->key2 = "value2";
$obj->key3 = "value3";
$arr["object"] = $obj;

$arr["deep"] = $arr;

print_r($arr);
