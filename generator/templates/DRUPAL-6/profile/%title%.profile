<?php
// $Id$

/**
 * @file %title%.profile
 *  Drupal install profile for %Title%.
 **/

// NOTE: The cck, nodes, and views directories are for housing exports.
//       See the node_export, content_copy, and view_ui modules.

/**
 * Implementation of hook_profile_details().
 */
function %title%_profile_details() {
  return array(
    'name' => '%Title%',
    'description' => st('Drupal install profile for %Title%.'),
  );
}

/**
 * Implementation of hook_profile_modules().
 */
function %title%_profile_modules() {
  $core = array(
    // Required core modules.
    'block', 'filter', 'node', 'system', 'user',

    // Optional core modules.
    'dblog', 'help', 'menu', 'search', 'taxonomy', 'update', 'path',
    'comment', 'profile',

    // More optional core modules
    /* 'contact', 'translation', 'locale', */
  );

  $contrib = array(
    // TODO: Put required contrib modules here
    // EXAMPLES:
    // // Makes install profile setup less painful
    // 'install_profile_api', 'export',
    // 
    // // Allows cron to run on "simple" hosts
    // 'poormanscron',
    // 
    // // SEO
    // 'token', 'pathauto',
    // 
    // // Security, access control, etc.
    // 'tac_lite',
    // 
    // // Internationalization modules
    // 'i18n', 'i18nstrings', 'i18nblocks', 'i18nmenu', 'languageicons',
    // 'i18ncontent', 'i18nprofile', 'i18nsync', 'i18ntaxonomy',
    // 'translation_overview',
    // 
    // // CCK modules.
    // 'content', 'content_copy', 'text', 'date',
    // 'fieldgroup', 'optionwidgets', 'filefield',
    // 
    // // News, Pictures, Galleries, and other content
    // 'image', 'image_gallery', 'taxonomy_defaults',
    // 'wysiwyg', 'img_assist',
    // 
    // // Custom pages and layouts
    // 'views', 'views_ui',
  );

  return array_merge($core, $contrib);
}

/**
 * Implementation of hook_profile_tasks().
 */
function %title%_profile_tasks(&$task, $url) {
  install_include(%title%_profile_modules());

  // General site setup
  _%title%_setup_general();

  // Change the theme
  _%title%_setup_theme();

  // Setup CCK types
  _%title%_setup_content_types();

  // Setup Taxonomy
  _%title%_setup_taxonomy();

  // Setup accounts, roles, profile fields and permissions
  _%title%_setup_roles();
  _%title%_setup_permissions();
  _%title%_setup_profile_fields();
  _%title%_setup_user_1();

  // Development mode helpers, debug helpers, etc.
  if (variable_get('development', FALSE)) {
   _%title%_setup_development_helpers();
  }

  // Setup pre-fab nodes
  _%title%_setup_nodes();

  // Setup views
  _%title%_setup_views();

  // Install and setup the menu and navigation
  // _%title%_setup_menu();

  // Setup blocks
  _%title%_setup_blocks();

  // Rebuild node permissions, required by content_access
  node_access_rebuild(FALSE);

  // Update search index
  if (function_exists('search_cron')) {
    search_cron();
  }

  // Clear the page cache.
  drupal_flush_all_caches();
}

/**
 * Implementation of hook_form_alter()
 */
function %title%_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure') {
    // TODO: Alter the Drupal configuration form.

    // EXAMPLES:
    // $form['site_information']['site_name']['#default_value'] = '%Title%';
    // $form['site_information']['site_mail']['#default_value'] = 'info@%title%.com';
    // $form['admin_account']['account']['name']['#default_value'] = 'admin';
    // $form['admin_account']['account']['mail']['#default_value'] = 'info@%title%.com';
  }
}

/**
 * General site setup.
 **/
function _%title%_setup_general() {
  // EXAMPLES:
  // variable_set('site_frontpage', 'home');
}

/**
 * Setup the theme.
 **/
function _%title%_setup_theme() {
  install_enable_theme('%title%');
  install_default_theme('%title%');
  // install_admin_theme('velocity_admin');
}

/**
 * Setup Taxonomy, and Taxonomy defaults
 **/
function _%title%_setup_taxonomy() {
  // EXAMPLES:
  // $node_types = node_get_types();
  // $all_node_types = array_keys($node_types);
  // install_taxonomy_add_vocabulary(
  //   'Tags',
  //   drupal_map_assoc($all_node_types),
  //   array('module' => 'taxonomy', 'required' => 0, 'tags' => 1)
  // );
}

/**
 * Setup user roles.
 **/
function _%title%_setup_roles() {
  global $%title%_roles;    // Keep roles on hand
  $%title%_roles = array(); // for later use

  // EXAMPLES:
  // $%title%_roles['Admin']        = install_add_role('Admin');
  // $%title%_roles['Editor']       = install_add_role('Editor');
}

/**
 * Setup base user permissions
 **/
function _%title%_setup_permissions() {
  global $%title%_roles;

  // EXAMPLES:
  // // Nothing to do for the Anonymous user, defaults are fine ..
  // install_add_permissions(DRUPAL_ANONYMOUS_RID, array(
  //   'access site-wide contact form',
  //   'access content',
  //   'search content',
  // ));
  // 
  // // Authenticated user
  // install_add_permissions(DRUPAL_AUTHENTICATED_RID, array(
  //   'access comments',
  //   'post comments',
  //   'post comments without approval',
  //   'access site-wide contact form',
  //   'access content',
  //   'search content',
  // ));
  // 
  // // Add permissions to the Editor
  // install_add_permissions($%title%_roles['Editor'], array(
  //   'create images',
  //   'edit own images',
  //   'view original images',
  //   'administer images',
  //   'create url aliases',
  //   'use advanced search',
  //   'translate content',
  //   'access user profiles',
  //   'change own username',
  //   'access all images',
  //   'access img_assist',
  // ));
  // 
  // // Add permissions to the Administrator
  // install_add_permissions($%title%_roles['Admin'], array(
  //   'administer comments',
  //   'administer site-wide contact form',
  //   'Use PHP input for field settings (dangerous - grant with care)',
  //   'create images',
  //   'edit images',
  //   'edit own images',
  //   'view original images',
  //   'administer images',
  //   'administer nodes',
  //   'create page content',
  //   'delete any page content',
  //   'delete own page content',
  //   'delete revisions',
  //   'edit any page content',
  //   'edit own page content',
  //   'revert revisions',
  //   'view revisions',
  //   'administer url aliases',
  //   'create url aliases',
  //   'administer search',
  //   'use advanced search',
  //   'access administration pages',
  //   'access site reports',
  //   'administer files',
  //   'administer site configuration',
  //   'select different theme',
  //   'administer taxonomy',
  //   'translate content',
  //   'access user profiles',
  //   'administer users',
  //   'change own username',
  //   'administer all languages',
  //   'administer languages',
  //   'translate interface',
  //   'access all images',
  //   'access img_assist',
  //   'use original size',
  // ));
}

/**
 * Setup profile fields
 **/
function _%title%_setup_profile_fields() {
  // install_profile_field_add(array(
  //   'title' => 'Date of Birth',
  //   'name' => 'profile_dob',
  //   'category' => 'Profile',
  //   'type' => 'date',
  //   'required' => 1,
  //   'register' => 1,
  //   'visibility' => PROFILE_PRIVATE,
  //   'weight' => 0,
  // ));
}

/**
 * Setup Drupal user #1.
 **/
function _%title%_setup_user_1() {
  // TODO: Tasks related to Drupal user #1
}

/**
 * Setup site for development.
 **/
function _%title%_setup_development_helpers() {
  // TODO: Put any development helpers here.
}

/**
 * Setup basic CCK types.
 **/
function _%title%_setup_content_types() {
  // Path to content_copy CCK dumps
  $content_copy = 'profiles/%title%/cck';

  // EXAMPLES:
  // install_content_copy_import_from_file($content_copy . '/my_cck_type.inc');
}

/**
 * Import exported nodes.
 **/
function _%title%_setup_nodes() {
  // Path to node_export dumps
  $node_export = 'profiles/%title%/nodes';

  // EXAMPLES:
  // $nodes = install_node_export_import_from_file($node_export . '/my_cck_type-first_node.inc');
}

/**
 * Setup views.
 **/
function _%title%_setup_views() {
  // Path to views exports
  $views_export = 'profiles/%title%/views_export';

  // EXAMPLES:
  // install_views_ui_import_from_file($views_export . '/my_view.inc');
}

/**
 * Setup blocks.
 **/
function _%title%_setup_blocks() {
  global $%title%_roles;

  $theme = '%title%';

  // EXAMPLES:
  // // Move the navigation block
  // install_set_block('user', 1, $theme, 'header', -10, NULL, NULL, NULL, NULL, '<none>');
  // // Add the user login box on the front page
  // install_set_block('user', 0, $theme, 'content_bottom', -9, 1, '<front>');
}
