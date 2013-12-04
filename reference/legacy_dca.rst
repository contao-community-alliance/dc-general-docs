Legacy DCA
==========

This is a full **legacy dca** reference example with all known keys and example values.

.. code-block:: php

    $GLOBALS['TL_DCA']['tl_example'] = array
    (
        // Config
        'config' => array
        (
            'label'              => &$GLOBALS['TL_LANG']['tl_example']['headline'],
            'dataContainer'      => 'General',
            'ptable'             => 'tl_parent',
            'dynamicPtable'      => true, // require 'ptable'=>''
            'ctable'             => array('tl_child1', 'tl_child2'),
            'validFileTypes'     => 'jpg,png,gif',
            'uploadScript'       => '',
            'closed'             => true,
            'notEditable'        => true,
            'notDeletable'       => true,
            'switchToEdit'       => true,
            'enableVersioning'   => true,
            'doNotCopyRecords'   => true,
            'doNotDeleteRecords' => true,
            'onload_callback'    => array
            (
                array('<class name>', '<method name>')
            ),
            'onsubmit_callback'  => array
            (
                array('<class name>', '<method name>')
            ),
            'ondelete_callback'  => array
            (
                array('<class name>', '<method name>')
            ),
            'oncut_callback'     => array
            (
                array('<class name>', '<method name>')
            ),
            'oncopy_callback'    => array
            (
                array('<class name>', '<method name>')
            ),
            'sql'                => array
            (
                'keys' => array
                (
                    'id'    => 'primary',
                    'pid'   => 'index',
                    'alias' => 'index'
                )
            )
        ),

        // DcGeneral config
        'dca_config' => array
        (
            'callback'       => 'DcGeneral\Callbacks\ContaoStyleCallbacks',
            'controller'     => 'DcGeneral\Controller\DefaultController',
            'view'           => 'DcGeneral\View\DefaultView',
            'data_provider'  => array
            (
                    'default' => array
                    (
                            'class'  => 'DcGeneral\Data\DefaultDriver',
                            'source' => 'tl_example'
                    ),
                    'parent'  => array
                    (
                            'class'  => 'DcGeneral\Data\DefaultDriver',
                            'source' => 'tl_parent'
                    )
            ),
            'rootEntries' => array(
                'tl_example' => array(
                    'setOn'  => array
                    (
                        array(
                            'property' => 'id',
                            'value'    => 0
                        ),
                    ),
                    'filter' => array
                    (
                        array
                        (
                            'property'  => 'id',
                            'value'     => 0,
                            'operation' => '='
                        )
                    )
                )
            ),
            'childCondition' => array(
                array(
                    'from'   => 'tl_parent',
                    'to'     => 'tl_example',
                    'setOn'  => array
                    (
                        array(
                            'from_field' => 'id',
                            'to_field'   => 'pid'
                        ),
                    ),
                    'filter' => array
                    (
                        array
                        (
                            'remote'    => 'id',
                            'local'     => 'pid',
                            'operation' => '='
                        )
                    )
                )
            )
        ),

        // List
        'list' => array
        (
            'sorting' => array
            (
                'mode'                  => 6,
                'flag'                  => 6,
                'panelLayout'           => 'filter;search,limit',
                'fields'                => array('published DESC', 'title', 'author'),
                'headerFields'          => array('title', 'headline', 'author', 'inColumn', 'tstamp', 'showTeaser', 'published', 'start', 'stop'),
                'icon'                  => 'path/to/icon.png',
                'root'                  => 6,
                'filter'                => array(array('status=?', 'active')),
                'disableGrouping'       => true,
                'paste_button_callback' => array('<class name>', '<method name>'),
                'child_record_callback' => array('<class name>', '<method name>'),
                'child_record_class'    => 'css_class_name'
            ),
            'label' => array
            (
                'fields'         => array('title', 'inColumn'),
                'format'         => '%s <span style="color:#b3b3b3;padding-left:3px">[%s]</span>',
                'maxCharacters'  => 255,
                'group_callback' => array('<class name>', '<method name>'),
                'label_callback' => array('<class name>', '<method name>')
            ),
            'global_operations' => array
            (
                'all' => array
                (
                    'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],
                    'href'            => 'act=select',
                    'class'           => 'header_edit_all',
                    'attributes'      => 'onclick="Backend.getScrollOffset()" accesskey="e"',
                    'button_callback' => array('<class name>', '<method name>')
                )
            ),
            'operations' => array
            (
                'delete' => array
                (
                    'label'           => &$GLOBALS['TL_LANG']['tl_example']['delete'],
                    'href'            => 'act=delete',
                    'icon'            => 'delete.gif',
                    'attributes'      => 'onclick="if(!confirm(\'' . $GLOBALS['TL_LANG']['MSC']['deleteConfirm'] . '\'))return false;Backend.getScrollOffset()"',
                    'button_callback' => array('<class name>', '<method name>')
                ),
            )
        ),

        // Palettes
        'palettes' => array
        (
            '__selector__' => array('protected'),
            'default'      => '{title_legend},title,alias,author;...'
        ),

        // Subpalettes
        'subpalettes' => array
        (
            'protected' => 'groups'
        ),

        // Fields
        'fields' => array
        (
            'title' => array
            (
                'label'                => &$GLOBALS['TL_LANG']['tl_example']['title'],
                'default'              => 'default value',
                'exclude'              => true,
                'search'               => true,
                'sorting'              => true,
                'filter'               => true,
                'flag'                 => 12,
                'length'               => 3,
                'inputType'            => 'text',
                'options'              => array('a', 'b', 'c'),
                'options_callback'     => array('<class name>', '<method name>'),
                'foreignKey'           => 'tl_other_table.name',
                'reference'            => &$GLOBALS['TL_LANG']['tl_example']['title'],
                'explanation'          => &$GLOBALS['TL_LANG']['tl_example']['title'],
                'input_field_callback' => array('<class name>', '<method name>'),
                'wizard'               => array('<class name>', '<method name>'),
                'sql'                  => "varchar(255) NOT NULL default ''",
                'relation'             => array('type'=>'hasOne', 'load'=>'eager'),
                'load_callback'        => array
                (
                    array('<class name>', '<method name>')
                ),
                'save_callback'        => array
                (
                    array('<class name>', '<method name>')
                ),
                'xlabel'               => array
                (
                    array('<class name>', '<method name>')
                ),
                'eval'                 => array(
                    'helpwizard'         => true,
                    'mandatory'          => true,
                    'maxlength'          => 255,
                    'minlength'          => 255,
                    'fallback'           => true,
                    'rgxp'               => 'friendly',
                    'cols'               => 12,
                    'rows'               => 6,
                    'wrap'               => 'hard',
                    'multiple'           => true,
                    'size'               => 6,
                    'style'              => 'border:2px',
                    'rte'                => 'tinyFlash',
                    'submitOnChange'     => true,
                    'nospace'            => true,
                    'allowHtml'          => true,
                    'preserveTags'       => true,
                    'decodeEntities'     => true,
                    'doNotSaveEmpty'     => true,
                    'alwaysSave'         => true,
                    'spaceToUnderscore'  => true,
                    'unique'             => true,
                    'encrypt'            => true,
                    'trailingSlash'      => true,
                    'files'              => true,
                    'filesOnly'          => true,
                    'extensions'         => 'jpg,png,gif',
                    'path'               => 'path/inside/of/contao',
                    'fieldType'          => 'checkbox',
                    'includeBlankOption' => true,
                    'blankOptionLabel'   => '- none selected -',
                    'chosen'             => true,
                    'findInSet'          => true,
                    'datepicker'         => true,
                    'colorpicker'        => true,
                    'feEditable'         => true,
                    'feGroup'            => 'contact',
                    'feViewable'         => true,
                    'doNotCopy'          => true,
                    'hideInput'          => true,
                    'doNotShow'          => true,
                    'isBoolean'          => true,
                    'disabled'           => true,
                    'readonly'           => true,
                ),
            ),
        )
    );
