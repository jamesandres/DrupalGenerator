<?php
// $Id$

/**
 * @file %title%.admin.inc
 *  Administrative callbacks for the %title% module.
 */

/**
 * %Title% module settings form callback.
 **/
function %title%_admin() {
  $form = array();

  $form['%title%_settings'] = array(
    '#type' => 'textfield',
    '#title' => t('Example settings field'),
    '#size' => 60,
    '#maxlength' => 255,
    '#default_value' => variable_get('%title%_settings', 'default value'),
    '#required' => TRUE,
  );

  return system_settings_form($form);

  // NOTE: No need for validate or submit on this form since
  // system_settings_form() does that automatically.
}
