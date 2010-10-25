<?php
// $Id$

/**
 * @file %title%.pages.inc
 *  Page callbacks for %title% module.
 */

/**
 * Prints a %title% listing.
 */
function %title%_page($tid = 0) {
  $topics = '';
  $%title%_per_page = variable_get('%title%_per_page', 25);
  $sortby = variable_get('%title%_order', 1);

  $%title%s = %title%_get_%title%s($tid);
  $parents = taxonomy_get_parents_all($tid);
  if ($tid && !in_array($tid, variable_get('%title%_containers', array()))) {
    $topics = %title%_get_topics($tid, $sortby, $%title%_per_page);
  }

  return theme('%title%s', $%title%s, $topics, $parents, $tid, $sortby, $%title%_per_page);
}
