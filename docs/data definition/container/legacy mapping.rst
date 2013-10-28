Legacy mapping
==============

The *legacy dca* aka *old dca* format is used in Contao 2 and Contao 3.
This page describe how this format is mapped into the DcGeneral :doc:`../container`.

Here is a typical *legacy dca* example:

.. code-block:: php

    $GLOBALS['TL_DCA']['tl_example'] = array
    (
        // Config
        'config' => array
        (
            ...
        ),
        // DcGeneral config
        'dca_config' => array
        (
            'data_provider' => array
            (
                ...
            ),
        ),
        // List
        'list' => array
        (
            'sorting' => array
            (
                ...
            ),
            'label' => array
            (
                ...
            ),
            'global_operations' => array
            (
                ...
            ),
            'operations' => array
            (
                ...
            )
        ),
        // Palettes
        'palettes' => array
        (
            ...
        ),
        // Subpalettes
        'subpalettes' => array
        (
            ...
        ),
        // Fields
        'fields' => array
        (
            ...
        )
    );

Basic config mapping
--------------------

Legacy mapping
~~~~~~~~~~~~~~

+----------------------------------------------------------+------------------------------------------------------+
| .. code-block:: php                                      | ::                                                   |
|                                                          |                                                      |
|     $GLOBALS['TL_DCA']['tl_example'] = array             |     -> table name is used as *default* data provider |
|     (                                                    |     -                                                |
|         // Config                                        |     -                                                |
|         'config' => array                                |     -                                                |
|         (                                                |     -                                                |
|             'ptable' => 'tl_parent',                     |     -> used as *parent* data provider                |
|             'ctable' => array('tl_child1', 'tl_child2'), |     -                                                |
|         ),                                               |     -                                                |
|         // List                                          |     -                                                |
|         'list' => array                                  |     -                                                |
|         (                                                |     -                                                |
|             'sorting' => array                           |     -                                                |
|             (                                            |     -                                                |
|                 'mode' => 6,                             |     -> used as mode                                  |
|             ),                                           |     -                                                |
|         ),                                               |     -                                                |
|     );                                                   |     -                                                |
+----------------------------------------------------------+------------------------------------------------------+

Extended mapping
~~~~~~~~~~~~~~~~

+--------------------------------------------------+----------------------------------------+
| .. code-block:: php                              | ::                                     |
|                                                  |                                        |
|     $GLOBALS['TL_DCA']['tl_example'] = array     |     -                                  |
|     (                                            |     -                                  |
|         // DcGeneral config                      |     -                                  |
|         'dca_config' => array                    |     -                                  |
|         (                                        |     -                                  |
|             'data_provider' => array             |     -                                  |
|             (                                    |     -                                  |
|                 'root' => array(                 |     -> used as *root* data provider    |
|                     ...                          |     -                                  |
|                 ),                               |     -                                  |
|                 'parent' => array(               |     -> used as *parent* data provider  |
|                     ...                          |     -                                  |
|                 ),                               |     -                                  |
|                 'default' => array(              |     -> used as *default* data provider |
|                     ...                          |     -                                  |
|                 )                                |     -                                  |
|             ),                                   |     -                                  |
|         ),                                       |     -                                  |
|         // List                                  |     -                                  |
|         'list' => array                          |     -                                  |
|         (                                        |     -                                  |
|             'sorting' => array                   |     -                                  |
|             (                                    |     -                                  |
|                 'mode' => 6,                     |     -> used as mode                    |
|             ),                                   |     -                                  |
|         ),                                       |     -                                  |
|     );                                           |     -                                  |
+--------------------------------------------------+----------------------------------------+

full dca
========

.. code-block:: php

    $GLOBALS['TL_DCA']['tl_example'] = array
    (
        // Config
        'config' => array
        (
            'dataContainer'               => 'Table',
            'ptable'                      => 'tl_parent',
            'ctable'                      => array('tl_child1', 'tl_child2'),
            'switchToEdit'                => true,
            'enableVersioning'            => true,
            'onload_callback' => array
            (
                array('tl_example', 'checkPermission'),
                array('tl_page', 'addBreadcrumb')
            ),
            'sql' => array
            (
                'keys' => array
                (
                    'id' => 'primary',
                    'pid' => 'index',
                    'alias' => 'index'
                )
            )
        ),
        // List
        'list' => array
        (
            'sorting' => array
            (
                'mode'                    => 6,
                'fields'                  => array('published DESC', 'title', 'author'),
                'paste_button_callback'   => array('tl_example', 'pasteArticle'),
                'panelLayout'             => 'search'
            ),
            'label' => array
            (
                'fields'                  => array('title', 'inColumn'),
                'format'                  => '%s <span style="color:#b3b3b3;padding-left:3px">[%s]</span>',
                'label_callback'          => array('tl_example', 'addIcon')
            ),
            'global_operations' => array
            (
                'toggleNodes' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['MSC']['toggleAll'],
                    'href'                => '&amp;ptg=all',
                    'class'               => 'header_toggle'
                ),
                'all' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['MSC']['all'],
                    'href'                => 'act=select',
                    'class'               => 'header_edit_all',
                    'attributes'          => 'onclick="Backend.getScrollOffset()" accesskey="e"'
                )
            ),
            'operations' => array
            (
                'edit' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['edit'],
                    'href'                => 'table=tl_content',
                    'icon'                => 'edit.gif',
                    'button_callback'     => array('tl_example', 'editArticle')
                ),
                'editheader' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['editheader'],
                    'href'                => 'act=edit',
                    'icon'                => 'header.gif',
                    'button_callback'     => array('tl_example', 'editHeader')
                ),
                'copy' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['copy'],
                    'href'                => 'act=paste&amp;mode=copy',
                    'icon'                => 'copy.gif',
                    'attributes'          => 'onclick="Backend.getScrollOffset()"',
                    'button_callback'     => array('tl_example', 'copyArticle')
                ),
                'cut' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['cut'],
                    'href'                => 'act=paste&amp;mode=cut',
                    'icon'                => 'cut.gif',
                    'attributes'          => 'onclick="Backend.getScrollOffset()"',
                    'button_callback'     => array('tl_example', 'cutArticle')
                ),
                'delete' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['delete'],
                    'href'                => 'act=delete',
                    'icon'                => 'delete.gif',
                    'attributes'          => 'onclick="if(!confirm(\'' . $GLOBALS['TL_LANG']['MSC']['deleteConfirm'] . '\'))return false;Backend.getScrollOffset()"',
                    'button_callback'     => array('tl_example', 'deleteArticle')
                ),
                'toggle' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['toggle'],
                    'icon'                => 'visible.gif',
                    'attributes'          => 'onclick="Backend.getScrollOffset();return AjaxRequest.toggleVisibility(this,%s)"',
                    'button_callback'     => array('tl_example', 'toggleIcon')
                ),
                'show' => array
                (
                    'label'               => &$GLOBALS['TL_LANG']['tl_example']['show'],
                    'href'                => 'act=show',
                    'icon'                => 'show.gif'
                )
            )
        ),
        // Palettes
        'palettes' => array
        (
            ...
        ),
        // Subpalettes
        'subpalettes' => array
        (
            ...
        ),
        // Fields
        'fields' => array
        (
            ...
        )
    );
