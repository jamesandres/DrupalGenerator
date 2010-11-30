<?php

/**
 * Implementation of hook_views_default_views().
 */
function %title%_views_default_views() {
  $views = array();

  foreach (glob(drupal_get_path('module', '%title%') . '/views/*.inc') as $file) {
    // Skip all overridden views
    if (preg_match('/^overridden-/', basename($file))) continue;

    include($file);
    $views[$view->name] = $view;
  }

  return $views;
}

