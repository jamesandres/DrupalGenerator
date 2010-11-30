<?php

/**
 * Implementation of hook_default_page_manager_pages().
 */
function %title%_default_page_manager_pages() {
  $pages = array();

  foreach (glob(drupal_get_path('module', '%title%') . '/pages/*.inc') as $file) {
    include($file);
    $pages[$page->name] = $page;
  }

  return $pages;
}

/**
 * Implementation of hook_default_page_manager_handlers()
 */
function %title%_default_page_manager_handlers() {
  $page_handlers = array();

  foreach (glob(drupal_get_path('module', '%title%') . '/page_handlers/*.inc') as $file) {
    include($file);
    $page_handlers[$handler->name] = $handler;
  }

  return $page_handlers;
}
