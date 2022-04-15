<?php

namespace Drupal\test_graphql\Plugin\GraphQL\Schema;

use Drupal\graphql\Plugin\GraphQL\Schema\ComposableSchema;

/**
 * @Schema(
 *   id = "composable",
 *   name = "Custom Composable Example schema",
 *   extensions = "composable",
 * )
 */
class ComposableSchemaExample extends ComposableSchema {

}
