.. |nbsp| unicode:: 0xA0
   :trim:

.. |nl| unicode:: 0xA0

Legacy mapping
==============

The **legacy dca** aka **old dca** format is used in Contao 2 and Contao 3.
This page describe how this format is mapped into the DcGeneral :doc:`../container`.

Here is a typical **legacy dca** example:

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

You can access the basic section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BasicSectionInterface;

    $basicSection = $container->getSection(BasicSectionInterface::NAME);
    /** @var BasicSectionInterface $basicSection */

.. warning::
   | In legacy mode, the ``BasicSectionInterface::$rootDataProvider`` is always **root**,
   | the ``BasicSectionInterface::$parentDataProvider`` is always **parent** and
   | the ``BasicSectionInterface::$dataProvider`` is always **default**.

Mapping
~~~~~~~

+----------------------------------------------+----------------------------------------------------+
| .. code-block:: php                          | .. parsed-literal::                                |
|                                              |                                                    |
|     $GLOBALS['TL_DCA']['tl_example'] = array |     |nl|                                           |
|     (                                        |     |nl|                                           |
|         // List                              |     |nl|                                           |
|         'list' => array                      |     |nl|                                           |
|         (                                    |     |nl|                                           |
|             'sorting' => array               |     |nl|                                           |
|             (                                |     |nl|                                           |
|                 'mode' => 6,                 |     -> used as mode (``$basicSection->getMode()``) |
|             )                                |     |nl|                                           |
|         )                                    |     |nl|                                           |
|     );                                       |     |nl|                                           |
+----------------------------------------------+----------------------------------------------------+

Data provider mapping
---------------------

You can access the data provider section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\DataProviderSectionInterface;

    $dataProviderSection = $container->getSection(DataProviderSectionInterface::NAME);
    /** @var DataProviderSectionInterface $dataProviderSection */

Legacy mapping
~~~~~~~~~~~~~~

+---------------------------------------------------------+-----------------------------------------------------------------+
| .. code-block:: php                                     | .. parsed-literal::                                             |
|                                                         |                                                                 |
|     $GLOBALS['TL_DCA']['tl_example'] = array            |    -> create a data provider information called **default**,    |
|     (                                                   |       of type ``ContaoDataProviderInformation``,                |
|         // Config                                       |       with ``DcGeneral\Data\DefaultDriver`` as driver class,    |
|         'config' => array                               |       with table name **tl_example** as source                  |
|         (                                               |       (``$dataProviderSection->getInformation("default")``)     |
|             'ptable' => 'tl_parent',                    |    -> create a data provider information called **parent**,     |
|             'ctable' => array('tl_child1', 'tl_child2') |       of type ``ContaoDataProviderInformation``,                |
|         )                                               |       with ``DcGeneral\Data\DefaultDriver`` as driver class,    |
|     );                                                  |       with table name **tl_parent** as source                   |
|                                                         |       (``$dataProviderSection->getInformation("parent")``)      |
+---------------------------------------------------------+-----------------------------------------------------------------+

Extended mapping
~~~~~~~~~~~~~~~~

+----------------------------------------------------------------+--------------------------------------------------------------------------+
| .. code-block:: php                                            | .. parsed-literal::                                                      |
|                                                                |                                                                          |
|     $GLOBALS['TL_DCA']['tl_example'] = array                   |    |nl|                                                                  |
|     (                                                          |    |nl|                                                                  |
|         // DcGeneral config                                    |    |nl|                                                                  |
|         'dca_config' => array                                  |    |nl|                                                                  |
|         (                                                      |    |nl|                                                                  |
|             'data_provider' => array                           |    |nl|                                                                  |
|             (                                                  |    |nl|                                                                  |
|                 'my_name' => array(                            |    -> create a data provider information called **my_name**              |
|                                                                |       (``$dataProviderSection->getInformation("my_name")``)              |
|                     'type' => 'DcGeneral\DataDefinition\       |    -> (*optional*) the information type class name                       |
|                       DataProviderInformation\',               |                                                                          |
|                       ContaoDataProviderInformation',          |                                                                          |
|                     'factory' => 'DcGeneral\DataDefinition\    |    -> (*optional*) the information type factory class name               |
|                       DataProviderInformation\                 |                                                                          |
|                       ContaoDataProviderInformationFactory',   |                                                                          |
|                     'class' => 'DcGeneral\Data\DefaultDriver', |    -> (*optional*) the driver class name                                 |
|                     'source' => 'tl_table_name',               |    -> (*required*) the source (table) name                               |
|                 ),                                             |                                                                          |
|                 'root' => array(                               |    -> (*required in parented tree mode*)                                 |
|                     ...                                        |       **root** is a predefined name for the tree root data provider      |
|                 ),                                             |       (``$dataProviderSection->getInformation("root")``)                 |
|                 'parent' => array(                             |    -> (*required in parented list mode*)                                 |
|                     ...                                        |       **parent** is a predefined name for the parent data provider       |
|                 ),                                             |       (``$dataProviderSection->getInformation("parent")``)               |
|                 'default' => array(                            |    -> (*required*)                                                       |
|                     ...                                        |       **default** is a predefined name for the current data provider     |
|                 )                                              |       (``$dataProviderSection->getInformation("default")``)              |
|             )                                                  |                                                                          |
|         )                                                      |                                                                          |
|     );                                                         |                                                                          |
+----------------------------------------------------------------+--------------------------------------------------------------------------+

Backend view
------------

You can access the backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

Listing
~~~~~~~

You can access the listing options of the backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\ListingConfigInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

    $listingConfig = $backendViewSection->getListingConfig();
    /** @var ListingConfigInterface $listingConfig */

Mapping
^^^^^^^

+-------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------+
| .. code-block:: php                                                                                         | .. parsed-literal::                                                      |
|                                                                                                             |                                                                          |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                                                |    |nl|                                                                  |
|     (                                                                                                       |    |nl|                                                                  |
|         // List                                                                                             |    |nl|                                                                  |
|         'list' => array                                                                                     |    |nl|                                                                  |
|         (                                                                                                   |    |nl|                                                                  |
|             'sorting' => array                                                                              |    |nl|                                                                  |
|             (                                                                                               |    |nl|                                                                  |
|                 'fields'                  => array('published DESC', 'title', 'author'),                    |    |nl|                                                                  |
|                 'paste_button_callback'   => array('tl_example', 'pasteArticle'),                           |    |nl|                                                                  |
|                 'panelLayout'             => 'search'                                                       |    |nl|                                                                  |
|             ),                                                                                              |    |nl|                                                                  |
|             'label' => array                                                                                |    |nl|                                                                  |
|             (                                                                                               |    |nl|                                                                  |
|                 'fields'                  => array('title', 'inColumn'),                                    |    |nl|                                                                  |
|                 'format'                  => '%s <span style="color:#b3b3b3;padding-left:3px">[%s]</span>', |    |nl|                                                                  |
|                 'label_callback'          => array('tl_example', 'addIcon')                                 |    |nl|                                                                  |
|             ),                                                                                              |    |nl|                                                                  |
|         )                                                                                                   |    |nl|                                                                  |
|     );                                                                                                      |    |nl|                                                                  |
+-------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------+

Global operations
~~~~~~~~~~~~~~~~~

You can access the global operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

    $globalOperations = $backendViewSection->getGlobalOperations();
    /** @var OperationCollectionInterface $globalOperations */

Mapping
^^^^^^^

+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| .. code-block:: php                                                                                                                                                   |
|                                                                                                                                                                       |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                                                                                                          |
|     (                                                                                                                                                                 |
|         // Config                                                                                                                                                     |
|         'config' => array                                                                                                                                             |
|         (                                                                                                                                                             |
|             'dataContainer'               => 'General',                                                                                                               |
|             'ptable'                      => 'tl_parent',                                                                                                             |
|             'ctable'                      => array('tl_child1', 'tl_child2'),                                                                                         |
|             'switchToEdit'                => true,                                                                                                                    |
|             'enableVersioning'            => true,                                                                                                                    |
|             'onload_callback' => array                                                                                                                                |
|             (                                                                                                                                                         |
|                 array('tl_example', 'checkPermission'),                                                                                                               |
|                 array('tl_page', 'addBreadcrumb')                                                                                                                     |
|             ),                                                                                                                                                        |
|             'sql' => array                                                                                                                                            |
|             (                                                                                                                                                         |
|                 'keys' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'id' => 'primary',                                                                                                                                |
|                     'pid' => 'index',                                                                                                                                 |
|                     'alias' => 'index'                                                                                                                                |
|                 )                                                                                                                                                     |
|             )                                                                                                                                                         |
|         ),                                                                                                                                                            |
|         // List                                                                                                                                                       |
|         'list' => array                                                                                                                                               |
|         (                                                                                                                                                             |
|             'sorting' => array                                                                                                                                        |
|             (                                                                                                                                                         |
|                 'mode'                    => 6,                                                                                                                       |
|                 'fields'                  => array('published DESC', 'title', 'author'),                                                                              |
|                 'paste_button_callback'   => array('tl_example', 'pasteArticle'),                                                                                     |
|                 'panelLayout'             => 'search'                                                                                                                 |
|             ),                                                                                                                                                        |
|             'label' => array                                                                                                                                          |
|             (                                                                                                                                                         |
|                 'fields'                  => array('title', 'inColumn'),                                                                                              |
|                 'format'                  => '%s <span style="color:#b3b3b3;padding-left:3px">[%s]</span>',                                                           |
|                 'label_callback'          => array('tl_example', 'addIcon')                                                                                           |
|             ),                                                                                                                                                        |
|             'global_operations' => array                                                                                                                              |
|             (                                                                                                                                                         |
|                 'toggleNodes' => array                                                                                                                                |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['MSC']['toggleAll'],                                                                                |
|                     'href'                => '&amp;ptg=all',                                                                                                          |
|                     'class'               => 'header_toggle'                                                                                                          |
|                 ),                                                                                                                                                    |
|                 'all' => array                                                                                                                                        |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['MSC']['all'],                                                                                      |
|                     'href'                => 'act=select',                                                                                                            |
|                     'class'               => 'header_edit_all',                                                                                                       |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()" accesskey="e"'                                                                      |
|                 )                                                                                                                                                     |
|             ),                                                                                                                                                        |
|             'operations' => array                                                                                                                                     |
|             (                                                                                                                                                         |
|                 'edit' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['edit'],                                                                              |
|                     'href'                => 'table=tl_content',                                                                                                      |
|                     'icon'                => 'edit.gif',                                                                                                              |
|                     'button_callback'     => array('tl_example', 'editArticle')                                                                                       |
|                 ),                                                                                                                                                    |
|                 'editheader' => array                                                                                                                                 |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['editheader'],                                                                        |
|                     'href'                => 'act=edit',                                                                                                              |
|                     'icon'                => 'header.gif',                                                                                                            |
|                     'button_callback'     => array('tl_example', 'editHeader')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'copy' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['copy'],                                                                              |
|                     'href'                => 'act=paste&amp;mode=copy',                                                                                               |
|                     'icon'                => 'copy.gif',                                                                                                              |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()"',                                                                                   |
|                     'button_callback'     => array('tl_example', 'copyArticle')                                                                                       |
|                 ),                                                                                                                                                    |
|                 'cut' => array                                                                                                                                        |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['cut'],                                                                               |
|                     'href'                => 'act=paste&amp;mode=cut',                                                                                                |
|                     'icon'                => 'cut.gif',                                                                                                               |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()"',                                                                                   |
|                     'button_callback'     => array('tl_example', 'cutArticle')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'delete' => array                                                                                                                                     |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['delete'],                                                                            |
|                     'href'                => 'act=delete',                                                                                                            |
|                     'icon'                => 'delete.gif',                                                                                                            |
|                     'attributes'          => 'onclick="if(!confirm(\'' . $GLOBALS['TL_LANG']['MSC']['deleteConfirm'] . '\'))return false;Backend.getScrollOffset()"', |
|                     'button_callback'     => array('tl_example', 'deleteArticle')                                                                                     |
|                 ),                                                                                                                                                    |
|                 'toggle' => array                                                                                                                                     |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['toggle'],                                                                            |
|                     'icon'                => 'visible.gif',                                                                                                           |
|                     'attributes'          => 'onclick="Backend.getScrollOffset();return AjaxRequest.toggleVisibility(this,%s)"',                                      |
|                     'button_callback'     => array('tl_example', 'toggleIcon')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'show' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['show'],                                                                              |
|                     'href'                => 'act=show',                                                                                                              |
|                     'icon'                => 'show.gif'                                                                                                               |
|                 )                                                                                                                                                     |
|             )                                                                                                                                                         |
|         )                                                                                                                                                             |
|     );                                                                                                                                                                |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Item operations
~~~~~~~~~~~~~~~

You can access the item operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

    $itemOperations = $backendViewSection->getItemOperations();
    /** @var OperationCollectionInterface $itemOperations */

Mapping
^^^^^^^

+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| .. code-block:: php                                                                                                                                                   |
|                                                                                                                                                                       |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                                                                                                          |
|     (                                                                                                                                                                 |
|         // Config                                                                                                                                                     |
|         'config' => array                                                                                                                                             |
|         (                                                                                                                                                             |
|             'dataContainer'               => 'General',                                                                                                               |
|             'ptable'                      => 'tl_parent',                                                                                                             |
|             'ctable'                      => array('tl_child1', 'tl_child2'),                                                                                         |
|             'switchToEdit'                => true,                                                                                                                    |
|             'enableVersioning'            => true,                                                                                                                    |
|             'onload_callback' => array                                                                                                                                |
|             (                                                                                                                                                         |
|                 array('tl_example', 'checkPermission'),                                                                                                               |
|                 array('tl_page', 'addBreadcrumb')                                                                                                                     |
|             ),                                                                                                                                                        |
|             'sql' => array                                                                                                                                            |
|             (                                                                                                                                                         |
|                 'keys' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'id' => 'primary',                                                                                                                                |
|                     'pid' => 'index',                                                                                                                                 |
|                     'alias' => 'index'                                                                                                                                |
|                 )                                                                                                                                                     |
|             )                                                                                                                                                         |
|         ),                                                                                                                                                            |
|         // List                                                                                                                                                       |
|         'list' => array                                                                                                                                               |
|         (                                                                                                                                                             |
|             'sorting' => array                                                                                                                                        |
|             (                                                                                                                                                         |
|                 'mode'                    => 6,                                                                                                                       |
|                 'fields'                  => array('published DESC', 'title', 'author'),                                                                              |
|                 'paste_button_callback'   => array('tl_example', 'pasteArticle'),                                                                                     |
|                 'panelLayout'             => 'search'                                                                                                                 |
|             ),                                                                                                                                                        |
|             'label' => array                                                                                                                                          |
|             (                                                                                                                                                         |
|                 'fields'                  => array('title', 'inColumn'),                                                                                              |
|                 'format'                  => '%s <span style="color:#b3b3b3;padding-left:3px">[%s]</span>',                                                           |
|                 'label_callback'          => array('tl_example', 'addIcon')                                                                                           |
|             ),                                                                                                                                                        |
|             'global_operations' => array                                                                                                                              |
|             (                                                                                                                                                         |
|                 'toggleNodes' => array                                                                                                                                |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['MSC']['toggleAll'],                                                                                |
|                     'href'                => '&amp;ptg=all',                                                                                                          |
|                     'class'               => 'header_toggle'                                                                                                          |
|                 ),                                                                                                                                                    |
|                 'all' => array                                                                                                                                        |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['MSC']['all'],                                                                                      |
|                     'href'                => 'act=select',                                                                                                            |
|                     'class'               => 'header_edit_all',                                                                                                       |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()" accesskey="e"'                                                                      |
|                 )                                                                                                                                                     |
|             ),                                                                                                                                                        |
|             'operations' => array                                                                                                                                     |
|             (                                                                                                                                                         |
|                 'edit' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['edit'],                                                                              |
|                     'href'                => 'table=tl_content',                                                                                                      |
|                     'icon'                => 'edit.gif',                                                                                                              |
|                     'button_callback'     => array('tl_example', 'editArticle')                                                                                       |
|                 ),                                                                                                                                                    |
|                 'editheader' => array                                                                                                                                 |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['editheader'],                                                                        |
|                     'href'                => 'act=edit',                                                                                                              |
|                     'icon'                => 'header.gif',                                                                                                            |
|                     'button_callback'     => array('tl_example', 'editHeader')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'copy' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['copy'],                                                                              |
|                     'href'                => 'act=paste&amp;mode=copy',                                                                                               |
|                     'icon'                => 'copy.gif',                                                                                                              |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()"',                                                                                   |
|                     'button_callback'     => array('tl_example', 'copyArticle')                                                                                       |
|                 ),                                                                                                                                                    |
|                 'cut' => array                                                                                                                                        |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['cut'],                                                                               |
|                     'href'                => 'act=paste&amp;mode=cut',                                                                                                |
|                     'icon'                => 'cut.gif',                                                                                                               |
|                     'attributes'          => 'onclick="Backend.getScrollOffset()"',                                                                                   |
|                     'button_callback'     => array('tl_example', 'cutArticle')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'delete' => array                                                                                                                                     |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['delete'],                                                                            |
|                     'href'                => 'act=delete',                                                                                                            |
|                     'icon'                => 'delete.gif',                                                                                                            |
|                     'attributes'          => 'onclick="if(!confirm(\'' . $GLOBALS['TL_LANG']['MSC']['deleteConfirm'] . '\'))return false;Backend.getScrollOffset()"', |
|                     'button_callback'     => array('tl_example', 'deleteArticle')                                                                                     |
|                 ),                                                                                                                                                    |
|                 'toggle' => array                                                                                                                                     |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['toggle'],                                                                            |
|                     'icon'                => 'visible.gif',                                                                                                           |
|                     'attributes'          => 'onclick="Backend.getScrollOffset();return AjaxRequest.toggleVisibility(this,%s)"',                                      |
|                     'button_callback'     => array('tl_example', 'toggleIcon')                                                                                        |
|                 ),                                                                                                                                                    |
|                 'show' => array                                                                                                                                       |
|                 (                                                                                                                                                     |
|                     'label'               => &$GLOBALS['TL_LANG']['tl_example']['show'],                                                                              |
|                     'href'                => 'act=show',                                                                                                              |
|                     'icon'                => 'show.gif'                                                                                                               |
|                 )                                                                                                                                                     |
|             )                                                                                                                                                         |
|         )                                                                                                                                                             |
|     );                                                                                                                                                                |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Root entries mapping
--------------------

Parent-child condition mapping
------------------------------

Deprecated DcGeneral config
---------------------------

DCA mapping reference
=====================

+----------------------------------------------------------------------------------------+------------------------------------------+
| .. code-block:: php                                                                    | .. parsed-literal::                      |
|                                                                                        |                                          |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                           |     -> `Data provider mapping`_          |
|     (                                                                                  |                                          |
|         // Config                                                                      |                                          |
|         'config' => array                                                              |                                          |
|         (                                                                              |                                          |
|             'label'              => &$GLOBALS['TL_LANG']['tl_example']['headline'],    |     ->                                   |
|             'dataContainer'      => 'General',                                         |     ->                                   |
|             'ptable'             => 'tl_parent',                                       |     -> `Data provider mapping`_          |
|             'dynamicPtable'      => true, // require 'ptable'=>''                      |     -> *ignored*                         |
|             'ctable'             => array('tl_child1', 'tl_child2'),                   |     -> *ignored*                         |
|             'validFileTypes'     => 'jpg,png,gif',                                     |     ->                                   |
|             'uploadScript'       => '',                                                |     ->                                   |
|             'closed'             => true,                                              |     ->                                   |
|             'notEditable'        => true,                                              |     ->                                   |
|             'notDeletable'       => true,                                              |     ->                                   |
|             'switchToEdit'       => true,                                              |     ->                                   |
|             'enableVersioning'   => true,                                              |     ->                                   |
|             'doNotCopyRecords'   => true,                                              |     ->                                   |
|             'doNotDeleteRecords' => true,                                              |     -> *ignored*                         |
|             'onload_callback'    => array                                              |     ->                                   |
|             (                                                                          |        +                                 |
|                 array('<class name>', '<method name>')                                 |        +                                 |
|             ),                                                                         |        +                                 |
|             'onsubmit_callback'  => array                                              |     ->                                   |
|             (                                                                          |        +                                 |
|                 array('<class name>', '<method name>')                                 |        +                                 |
|             ),                                                                         |        +                                 |
|             'ondelete_callback'  => array                                              |     ->                                   |
|             (                                                                          |        +                                 |
|                 array('<class name>', '<method name>')                                 |        +                                 |
|             ),                                                                         |        +                                 |
|             'oncut_callback'     => array                                              |     ->                                   |
|             (                                                                          |        +                                 |
|                 array('<class name>', '<method name>')                                 |        +                                 |
|             ),                                                                         |        +                                 |
|             'oncopy_callback'    => array                                              |     ->                                   |
|             (                                                                          |        +                                 |
|                 array('<class name>', '<method name>')                                 |        +                                 |
|             ),                                                                         |        +                                 |
|             'sql'                => array                                              |     -> *ignored*                         |
|             (                                                                          |        +                                 |
|                 'keys' => array                                                        |        +                                 |
|                 (                                                                      |        +                                 |
|                     'id'    => 'primary',                                              |        +                                 |
|                     'pid'   => 'index',                                                |        +                                 |
|                     'alias' => 'index'                                                 |        +                                 |
|                 )                                                                      |        +                                 |
|             )                                                                          |        +                                 |
|         ),                                                                             |                                          |
|                                                                                        |                                          |
|         // DcGeneral config                                                            |                                          |
|         'dca_config' => array                                                          |     ->                                   |
|         (                                                                              |                                          |
|             'callback'       => 'DcGeneral\Callbacks\ContaoStyleCallbacks',            |     -> `Deprecated DcGeneral config`_    |
|             'controller'     => 'DcGeneral\Controller\DefaultController',              |     -> `Deprecated DcGeneral config`_    |
|             'view'           => 'DcGeneral\View\DefaultView',                          |     -> `Deprecated DcGeneral config`_    |
|             'data_provider'  => array                                                  |     -> `Data provider mapping`_          |
|             (                                                                          |        +                                 |
|                     'default' => array                                                 |        +                                 |
|                     (                                                                  |        +                                 |
|                             'type'    => '...\ContaoDataProviderInformation',          |        +                                 |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |        +                                 |
|                             'class'   => 'DcGeneral\Data\DefaultDriver',               |        +                                 |
|                             'source'  => 'tl_example'                                  |        +                                 |
|                     ),                                                                 |        +                                 |
|                     'parent'  => array                                                 |        +                                 |
|                     (                                                                  |        +                                 |
|                             'type'    => '...\ContaoDataProviderInformation',          |        +                                 |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |        +                                 |
|                             'class'  => 'DcGeneral\Data\DefaultDriver',                |        +                                 |
|                             'source' => 'tl_parent'                                    |        +                                 |
|                     )                                                                  |        +                                 |
|             ),                                                                         |        +                                 |
|             'rootEntries' => array(                                                    |     -> `Root entries mapping`_           |
|                 'tl_example' => array(                                                 |        +                                 |
|                     'setOn'  => array                                                  |        +                                 |
|                     (                                                                  |        +                                 |
|                         array(                                                         |        +                                 |
|                             'property' => 'id',                                        |        +                                 |
|                             'value'    => 0                                            |        +                                 |
|                         ),                                                             |        +                                 |
|                     ),                                                                 |        +                                 |
|                     'filter' => array                                                  |        +                                 |
|                     (                                                                  |        +                                 |
|                         array                                                          |        +                                 |
|                         (                                                              |        +                                 |
|                             'property'  => 'id',                                       |        +                                 |
|                             'value'     => 0,                                          |        +                                 |
|                             'operation' => '='                                         |        +                                 |
|                         )                                                              |        +                                 |
|                     )                                                                  |        +                                 |
|                 )                                                                      |        +                                 |
|             ),                                                                         |        +                                 |
|             'childCondition' => array(                                                 |     -> `Parent-child condition mapping`_ |
|                 array(                                                                 |        +                                 |
|                     'from'   => 'tl_parent',                                           |        +                                 |
|                     'to'     => 'tl_example',                                          |        +                                 |
|                     'setOn'  => array                                                  |        +                                 |
|                     (                                                                  |        +                                 |
|                         array(                                                         |        +                                 |
|                             'from_field' => 'id',                                      |        +                                 |
|                             'to_field'   => 'pid'                                      |        +                                 |
|                         ),                                                             |        +                                 |
|                     ),                                                                 |        +                                 |
|                     'filter' => array                                                  |        +                                 |
|                     (                                                                  |        +                                 |
|                         array                                                          |        +                                 |
|                         (                                                              |        +                                 |
|                             'remote'    => 'id',                                       |        +                                 |
|                             'local'     => 'pid',                                      |        +                                 |
|                             'operation' => '='                                         |        +                                 |
|                         )                                                              |        +                                 |
|                     )                                                                  |        +                                 |
|                 )                                                                      |        +                                 |
|             )                                                                          |        +                                 |
|         ),                                                                             |                                          |
|                                                                                        |                                          |
|         // List                                                                        |                                          |
|         'list' => array                                                                |     ->                                   |
|         (                                                                              |                                          |
|             'sorting' => array                                                         |     ->                                   |
|             (                                                                          |                                          |
|                 'mode'                  => 6,                                          |     -> `Basic config mapping`_           |
|                 'flag'                  => 6,                                          |     ->                                   |
|                 'panelLayout'           => 'filter;search,limit',                      |     ->                                   |
|                 'fields'                => array('published DESC', 'title', 'author'), |     ->                                   |
|                 'headerFields'          => array('title', 'headline', 'author'),       |     ->                                   |
|                 'icon'                  => 'path/to/icon.png',                         |     ->                                   |
|                 'root'                  => 6,                                          |     ->                                   |
|                 'filter'                => array(array('status=?', 'active')),         |     ->                                   |
|                 'disableGrouping'       => true,                                       |     ->                                   |
|                 'paste_button_callback' => array('<class name>', '<method name>'),     |     ->                                   |
|                 'child_record_callback' => array('<class name>', '<method name>'),     |     ->                                   |
|                 'child_record_class'    => 'css_class_name'                            |     ->                                   |
|             ),                                                                         |                                          |
|             'label' => array                                                           |     ->                                   |
|             (                                                                          |                                          |
|                 'fields'         => array('title', 'inColumn'),                        |     ->                                   |
|                 'format'         => '%s <span style="color:#b3b3b3">[%s]</span>',      |     ->                                   |
|                 'maxCharacters'  => 255,                                               |     ->                                   |
|                 'group_callback' => array('<class name>', '<method name>'),            |     ->                                   |
|                 'label_callback' => array('<class name>', '<method name>')             |     ->                                   |
|             ),                                                                         |                                          |
|             'global_operations' => array                                               |     ->                                   |
|             (                                                                          |        +                                 |
|                 'all' => array                                                         |        +                                 |
|                 (                                                                      |        +                                 |
|                     'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],           |        +                                 |
|                     'href'            => 'act=select',                                 |        +                                 |
|                     'class'           => 'header_edit_all',                            |        +                                 |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |        +                                 |
|                     'button_callback' => array('<class name>', '<method name>')        |        +                                 |
|                 )                                                                      |        +                                 |
|             ),                                                                         |        +                                 |
|             'operations' => array                                                      |     ->                                   |
|             (                                                                          |        +                                 |
|                 'delete' => array                                                      |        +                                 |
|                 (                                                                      |        +                                 |
|                     'label'           => &$GLOBALS['TL_LANG']['tl_example']['delete'], |        +                                 |
|                     'href'            => 'act=delete',                                 |        +                                 |
|                     'icon'            => 'delete.gif',                                 |        +                                 |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |        +                                 |
|                     'button_callback' => array('<class name>', '<method name>')        |        +                                 |
|                 ),                                                                     |        +                                 |
|             )                                                                          |        +                                 |
|         ),                                                                             |                                          |
|                                                                                        |                                          |
|         // Palettes                                                                    |                                          |
|         'palettes' => array                                                            |     ->                                   |
|         (                                                                              |                                          |
|             '__selector__' => array('protected'),                                      |     ->                                   |
|             'default'      => '{title_legend},title,alias,author;...'                  |     ->                                   |
|         ),                                                                             |                                          |
|                                                                                        |                                          |
|         // Subpalettes                                                                 |                                          |
|         'subpalettes' => array                                                         |     ->                                   |
|         (                                                                              |                                          |
|             'protected' => 'groups'                                                    |     ->                                   |
|         ),                                                                             |                                          |
|                                                                                        |                                          |
|         // Fields                                                                      |                                          |
|         'fields' => array                                                              |     ->                                   |
|         (                                                                              |                                          |
|             'title' => array                                                           |     ->                                   |
|             (                                                                          |                                          |
|                 'label'                => &$GLOBALS['TL_LANG']['tl_example']['title'], |     ->                                   |
|                 'default'              => 'default value',                             |     ->                                   |
|                 'exclude'              => true,                                        |     ->                                   |
|                 'search'               => true,                                        |     ->                                   |
|                 'sorting'              => true,                                        |     ->                                   |
|                 'filter'               => true,                                        |     ->                                   |
|                 'flag'                 => 12,                                          |     ->                                   |
|                 'length'               => 3,                                           |     ->                                   |
|                 'inputType'            => 'text',                                      |     ->                                   |
|                 'options'              => array('a', 'b', 'c'),                        |     ->                                   |
|                 'options_callback'     => array('<class name>', '<method name>'),      |     ->                                   |
|                 'foreignKey'           => 'tl_other_table.name',                       |     ->                                   |
|                 'reference'            => &$GLOBALS['TL_LANG']['tl_example']['title'], |     ->                                   |
|                 'explanation'          => &$GLOBALS['TL_LANG']['tl_example']['title'], |     ->                                   |
|                 'input_field_callback' => array('<class name>', '<method name>'),      |     ->                                   |
|                 'wizard'               => array('<class name>', '<method name>'),      |     ->                                   |
|                 'sql'                  => "varchar(255) NOT NULL default ''",          |     ->                                   |
|                 'relation'             => array('type'=>'hasOne', 'load'=>'eager'),    |     ->                                   |
|                 'load_callback'        => array                                        |     ->                                   |
|                 (                                                                      |        +                                 |
|                     array('<class name>', '<method name>')                             |        +                                 |
|                 ),                                                                     |        +                                 |
|                 'save_callback'        => array                                        |     ->                                   |
|                 (                                                                      |        +                                 |
|                     array('<class name>', '<method name>')                             |        +                                 |
|                 ),                                                                     |        +                                 |
|                 'eval'                 => array(                                       |     ->                                   |
|                     'helpwizard'         => true,                                      |        +                                 |
|                     'mandatory'          => true,                                      |        +                                 |
|                     'maxlength'          => 255,                                       |        +                                 |
|                     'minlength'          => 255,                                       |        +                                 |
|                     'fallback'           => true,                                      |        +                                 |
|                     'rgxp'               => 'friendly',                                |        +                                 |
|                     'cols'               => 12,                                        |        +                                 |
|                     'rows'               => 6,                                         |        +                                 |
|                     'wrap'               => 'hard',                                    |        +                                 |
|                     'multiple'           => true,                                      |        +                                 |
|                     'size'               => 6,                                         |        +                                 |
|                     'style'              => 'border:2px',                              |        +                                 |
|                     'rte'                => 'tinyFlash',                               |        +                                 |
|                     'submitOnChange'     => true,                                      |        +                                 |
|                     'nospace'            => true,                                      |        +                                 |
|                     'allowHtml'          => true,                                      |        +                                 |
|                     'preserveTags'       => true,                                      |        +                                 |
|                     'decodeEntities'     => true,                                      |        +                                 |
|                     'doNotSaveEmpty'     => true,                                      |        +                                 |
|                     'alwaysSave'         => true,                                      |        +                                 |
|                     'spaceToUnderscore'  => true,                                      |        +                                 |
|                     'unique'             => true,                                      |        +                                 |
|                     'encrypt'            => true,                                      |        +                                 |
|                     'trailingSlash'      => true,                                      |        +                                 |
|                     'files'              => true,                                      |        +                                 |
|                     'filesOnly'          => true,                                      |        +                                 |
|                     'extensions'         => 'jpg,png,gif',                             |        +                                 |
|                     'path'               => 'path/inside/of/contao',                   |        +                                 |
|                     'fieldType'          => 'checkbox',                                |        +                                 |
|                     'includeBlankOption' => true,                                      |        +                                 |
|                     'blankOptionLabel'   => '- none selected -',                       |        +                                 |
|                     'chosen'             => true,                                      |        +                                 |
|                     'findInSet'          => true,                                      |        +                                 |
|                     'datepicker'         => true,                                      |        +                                 |
|                     'colorpicker'        => true,                                      |        +                                 |
|                     'feEditable'         => true,                                      |        +                                 |
|                     'feGroup'            => 'contact',                                 |        +                                 |
|                     'feViewable'         => true,                                      |        +                                 |
|                     'doNotCopy'          => true,                                      |        +                                 |
|                     'hideInput'          => true,                                      |        +                                 |
|                     'doNotShow'          => true,                                      |        +                                 |
|                     'isBoolean'          => true,                                      |        +                                 |
|                     'disabled'           => true,                                      |        +                                 |
|                     'readonly'           => true,                                      |        +                                 |
|                 ),                                                                     |        +                                 |
|             ),                                                                         |                                          |
|         )                                                                              |                                          |
|     );                                                                                 |                                          |
+----------------------------------------------------------------------------------------+------------------------------------------+
