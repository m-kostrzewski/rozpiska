<?php
defined("_VALID_ACCESS") || die('Direct access forbidden');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class rozpiskaCommon extends ModuleCommon {

    public static function menu() {
		return array(__('Module') => array('__submenu__' => 1, __('Rozpiska') => array(
	    	'__icon__'=>'umowa.png','__icon_small__'=>'umowa.png'
			)));
    }
}