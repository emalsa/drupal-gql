<?php

/**
 * @file
 */

use Drupal\node\Entity\Node;

$node = Node::load(1);
var_dump($node->get('field_wer')->value);
