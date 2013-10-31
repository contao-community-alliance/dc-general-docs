.. |nbsp| unicode:: 0xA0
   :trim:

.. |nl| unicode:: 0xA0

Legacy mapping
==============

The **legacy dca** aka **old dca** format is used in Contao 2 and Contao 3.
This page describe how this format is mapped into the DcGeneral :doc:`../container`.

For a full dca example and mapping description, see the `DCA mapping reference`_ chapter.

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

+---------------------------------------------------------+--------------------------------------------------------------------+
| .. code-block:: php                                     | .. parsed-literal::                                                |
|                                                         |                                                                    |
|     $GLOBALS['TL_DCA']['tl_example'] = array            |    -> create a data provider information called **tl_example**,    |
|     (                                                   |       of type ``ContaoDataProviderInformation``,                   |
|                                                         |       with ``DcGeneral\Data\DefaultDriver`` as driver class,       |
|                                                         |       with table name **tl_example** as source                     |
|                                                         |       Retrieve it like the following:                              |
|                                                         |       ``$parentDriver = $dataProviderSection->getInformation(``    |
|         // Config                                       |         ``$container->getBasicSection()->getDataProvider()``       |
|         'config' => array                               |       ``);``                                                       |
|         (                                               |                                                                    |
|             'ptable' => 'tl_parent',                    |    -> create a data provider information called **tl_parent**,     |
|                                                         |       of type ``ContaoDataProviderInformation``,                   |
|                                                         |       with ``DcGeneral\Data\DefaultDriver`` as driver class,       |
|                                                         |       with table name **tl_parent** as source                      |
|                                                         |       ``$parentDriver = $dataProviderSection->getInformation(``    |
|                                                         |         ``$container->getBasicSection()->getParentDataProvider()`` |
|                                                         |       ``);``                                                       |
|                                                         |                                                                    |
|             'ctable' => array('tl_child1', 'tl_child2') |    -> get's ignored in DCGeneral as we refuse to destroy the data  |
|         )                                               |       without the users notice. This is only used to restrict      |
|     );                                                  |       backend modules to certain tables and prune unparented data- |
|                                                         |       sets in Contao and considered harmful by the developers of   |
|                                                         |       DCGeneral.                                                   |
|                                                         |                                                                    |
+---------------------------------------------------------+--------------------------------------------------------------------+

Extended mapping
~~~~~~~~~~~~~~~~

+----------------------------------------------------------------+----------------------------------------------------------------------------+
| .. code-block:: php                                            | .. parsed-literal::                                                        |
|                                                                |                                                                            |
|     $GLOBALS['TL_DCA']['tl_example'] = array                   |    |nl|                                                                    |
|     (                                                          |    |nl|                                                                    |
|         // DcGeneral config                                    |    |nl|                                                                    |
|         'dca_config' => array                                  |    |nl|                                                                    |
|         (                                                      |    |nl|                                                                    |
|             'data_provider' => array                           |    |nl|                                                                    |
|             (                                                  |    |nl|                                                                    |
|                 array(                                         |    -> create a data provider information called **tl_table_name**          |
|                                                                |       (See comment for "source" key)                                       |
|                                                                |                                                                            |
|                     'factory' => 'DcGeneral\DataDefinition\    |    -> (*optional*) the information type factory class name                 |
|                       DataProviderInformation\                 |                                                                            |
|                       ContaoDataProviderInformationFactory',   |                                                                            |
|                                                                |                                                                            |
|                     'type' => 'DcGeneral\DataDefinition\       |    -> (*optional*) the information type class name. This is ignored by     |
|                       DataProviderInformation\                 |       the ``ExtendedLegacyDcaDataDefinitionBuilder`` when a factory is     |
|                       ContaoDataProviderInformation',          |       defined but the factory might non the less use it.                   |
|                                                                |                                                                            |
|                     'class' => 'DcGeneral\Data\DefaultDriver', |    -> (*optional*) the driver class name, note that this is only inter-    |
|                                                                |       preted by the default ``DataProviderPopulator`` and other popula-    |
|                                                                |       tors might ignore it.                                                |
|                                                                |                                                                            |
|                     'source' => 'tl_table_name',               |    -> (*required*) the source (table) name.                                |
|                                                                |       *NOTE:* This will also get used as the name for the information.     |
|                                                                |                                                                            |
|                      ...                                       |    -> Any optional data that can be interpreted by any registered builder  |
|                                                                |       or factory.                                                          |
|                 ),                                             |                                                                            |
|                 'root' => array(                               |    -> (*required in (parented) tree mode*)                                 |
|                     ...                                        |       Root elements for tree view will get fetched from this provider.     |
|                                                                |       ``$dataProviderSection->getInformation(``                            |
|                 ),                                             |         ``$basicSection()->getRootDataProvider()``                         |
|                                                                |       ``);``                                                               |
|                                                                |                                                                            |
|                 'parent' => array(                             |    -> (*required in parented list and parented tree mode*)                 |
|                     ...                                        |       This defines the parent element the root elements (when in tree mode)|
|                                                                |       or the current elements (when in list mode must be children of.      |
|                                                                |       ``$dataProviderSection->getInformation(``                            |
|                 ),                                             |         ``$basicSection()->getParentDataProvider()``                       |
|                                                                |       ``);``                                                               |
|                                                                |                                                                            |
|                                                                |                                                                            |
|                 'default' => array(                            |    -> (*required*)                                                         |
|                     ...                                        |       The current data provider, this is the data we really work on.       |
|                                                                |       ``$dataProviderSection->getInformation(``                            |
|                 ),                                             |         ``$basicSection()->getDataProvider()``                             |
|                                                                |       ``);``                                                               |
|                                                                |                                                                            |
|                 'default' => 'tl_table_name'                   |    -> Any of the named keys (root, parent, current) can be aliased to each |
|             )                                                  |       other. In this example default is an alias of the parent and there-  |
|         )                                                      |       fore both will use the same driver.                                  |
|     );                                                         |                                                                            |
+----------------------------------------------------------------+----------------------------------------------------------------------------+

Root entries mapping
--------------------

.. _parent-child-condition:

Parent-child condition mapping
------------------------------

Backend view mapping
--------------------

Normally the DcGeneral support multiple views on the container.
The legacy dca will be mapped into backend view, which is the default for the Contao backend editing.

You can access the backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

There is no special mapping from DCA parts into the backend view.
The backend view will be filled with :ref:`a listing <listing-mapping>`, :ref:`a panel layout <panel-layout-mapping>` and :ref:`operations <operation-mapping>`.

.. _listing-mapping:

Listing mapping
~~~~~~~~~~~~~~~

The listing contain all informations how to list the models.

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

+----------------------------------------------------------------+---------------------------------------------------------------------+
| .. code-block:: php                                            | .. parsed-literal::                                                 |
|                                                                |                                                                     |
|     $GLOBALS['TL_DCA']['tl_example'] = array                   |    |nl|                                                             |
|     (                                                          |    |nl|                                                             |
|         // List                                                |    |nl|                                                             |
|         'list' => array                                        |    |nl|                                                             |
|         (                                                      |    |nl|                                                             |
|             'sorting' => array                                 |    |nl|                                                             |
|             (                                                  |    |nl|                                                             |
|                 'flag'                  => 6,                  |    -> (*optional*) define the default sorting and grouping mode     |
|                                                                |       ``$listingConfig->getGroupingMode()``                         |
|                                                                |       ``$listingConfig->getSortingMode()``                          |
|                                                                |                                                                     |
|                 'fields'                => array(              |    -> (*optional*) define the initial default sorting fields        |
|                     'published DESC', 'title', 'author'        |       ``$listingConfig->getDefaultSortingFields()``                 |
|                 ),                                             |                                                                     |
|                 'headerFields'          => array(              |    -> (*required in parented view*) define the fields of the        |
|                     'title', 'headline', 'author'              |       parent element which are shown above the item list            |
|                 ),                                             |       ``$listingConfig->getHeaderPropertyNames()``                  |
|                                                                |                                                                     |
|                 'icon'                  => 'path/to/icon.png', |    -> (*optional*) path to an icon that is used as tree root icon   |
|                                                                |       ``$listingConfig->getRootIcon()``                             |
|                                                                |                                                                     |
|                 'disableGrouping'       => true,               |    -> (*deprecated*) define whether items are grouped or not,       |
|                                                                |       this enforce ``$listingConfig->getGroupingMode()`` to be      |
|                                                                |       ``ListingConfigInterface::GROUP_NONE`` when ``false``         |
|                                                                |                                                                     |
|                 'child_record_callback' => array(              |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                     '<class name>', '<method name>'            |       event depends on the view,                                    |
|                 )                                              |       for details, see the `Callbacks`_ chapter.                    |
|                                                                |                                                                     |
|                 'child_record_class'    => 'css_class_name'    |    -> (*optional*) used as item container css class                 |
|                                                                |       ``$listingConfig->getItemCssClass()``                         |
|             ),                                                 |                                                                     |
|             'label' => array                                   |    -> (*required*) this part is converted into an                   |
|             (                                                  |       :class:`DcGeneral\\View\\BackendView\\LabelFormatter``        |
|                                                                |       ``$listingConfig->getLabelFormatter()``                       |
|                                                                |                                                                     |
|                 'fields'         => array('title', 'alias'),   |    -> (*required*) used for ``ListItemFormatter::$propertyNames``   |
|                                                                |                                                                     |
|                                                                |                                                                     |
|                 'format'         => '%s [%s]',                 |    -> (*optional*) used for ``ListItemFormatter::$format``          |
|                                                                |                                                                     |
|                                                                |                                                                     |
|                 'maxCharacters'  => 255,                       |    -> (*optional*) used for ``ListItemFormatter::$maxLength``       |
|                                                                |                                                                     |
|                                                                |                                                                     |
|                 'group_callback' => array(                     |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                     '<class name>', '<method name>'            |       event depends on the view,                                    |
|                 )                                              |       for details, see the `Callbacks`_ chapter.                    |
|                                                                |                                                                     |
|                 'label_callback' => array()                    |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                     '<class name>', '<method name>'            |       event depends on the view,                                    |
|                 )                                              |       for details, see the `Callbacks`_ chapter.                    |
|             )                                                  |                                                                     |
|     );                                                         |                                                                     |
+----------------------------------------------------------------+---------------------------------------------------------------------+

.. _panel-layout-mapping:

Panel layout mapping
~~~~~~~~~~~~~~~~~~~~


.. _operation-mapping:

Operation mapping
~~~~~~~~~~~~~~~~~

In DcGeneral all operations are used as :doc:`../commands`.

+---------------------------------------------------------------------+---------------------------------------------------------------------+
| .. code-block:: php                                                 | .. parsed-literal::                                                 |
|                                                                     |                                                                     |
|     'all' => array                                                  |    -> (*optional*) used as operation name                           |
|     (                                                               |       ``$operation->getName()``                                     |
|                                                                     |                                                                     |
|         'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],    |    -> (*optional*) used as operation label (human readable name)    |
|                                                                     |       ``$operation->getLabel()``                                    |
|                                                                     |                                                                     |
|         'description'     => &$GLOBALS['TL_LANG']['MSC']['all'],    |    -> (*optional*) used as operation description (tooltip)          |
|                                                                     |       ``$operation->getDescription()``                              |
|                                                                     |                                                                     |
|         'command'         => 'select',                              |    -> (*optional*) used as operation command name                   |
|                                                                     |       ``$operation->getAction()``                                   |
|                                                                     |                                                                     |
|         'parameters'      => array(),                               |    -> (*optional*) used as operation's command parameters           |
|                                                                     |       ``$operation->getActionProperties()``                         |
|                                                                     |                                                                     |
|         'href'            => 'act=select',                          |    -> (*deprecated*) the query string is parsed and used as command |
|                                                                     |       parameters, if the query contain a parameter named ``act``,   |
|                                                                     |       the value is used as command name                             |
|                                                                     |                                                                     |
|         'icon'            => 'delete.gif',                          |    -> (*optional*) the path to the icon                             |
|                                                                     |       ``$operation->getIcon()``                                     |
|                                                                     |                                                                     |
|         'class'           => 'header_edit_all',                     |    -> (*deprecated*) will be added to *attributes*                  |
|                                                                     |                                                                     |
|         'attributes'      => 'onclick="Backend.getScrollOffset()"', |    -> (*optional*) string or array of html attributes               |
|                                                                     |       ``$operation->getHtmlAttributes()``                           |
|                                                                     |                                                                     |
|         'button_callback' => array('<class name>', '<method name>') |    -> (*deprecated*) use an event listener instead, the dispatched  |
|     )                                                               |       event depends on the view,                                    |
|                                                                     |       for details, see the `Callbacks`_ chapter.                    |
+---------------------------------------------------------------------+---------------------------------------------------------------------+

Global operations mapping
~~~~~~~~~~~~~~~~~~~~~~~~~

Global operations are mapped als *global* :doc:`../commands`.
These commands are dispatched in container scope.

To see how the operations are mapped, see the `Operation mapping`_ chapter.

You can access the global operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

    $globalOperations = $backendViewSection->getGlobalOperations();
    /** @var OperationCollectionInterface $globalOperations */

Item operations mapping
~~~~~~~~~~~~~~~~~~~~~~~

Item operations are mapped als *item* :doc:`../commands`.
These commands are dispatched in model scope.

To see how the operations are mapped, see the `Operation mapping`_ chapter.

You can access the item operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $basicSection */

    $itemOperations = $backendViewSection->getItemOperations();
    /** @var OperationCollectionInterface $itemOperations */

Palettes mapping
----------------

Subpalettes mapping
~~~~~~~~~~~~~~~~~~~

Properties (fka fields) mapping
-------------------------------

Additional configuration
~~~~~~~~~~~~~~~~~~~~~~~~

Deprecations
------------

Callbacks
~~~~~~~~~

Callbacks are still supported for compatibility reason, but the complete DcGeneral is fully event driven and all
callbacks are only triggered through a *legacy callback event listener*. For full functionality, you should use
custom :doc:`event <../../events>` listeners.

To find out the responsible event, have a look into the :namespace:`DcGeneral\\DataDefinition\\Builder\\Event <DcGeneral\\DataDefinition\\Builder\\Event>` namespace.

Deprecated DcGeneral config
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ignored parts
-------------

.. _dataContainer:

dataContainer
~~~~~~~~~~~~~

The ``dataContainer`` parts is only necessary for contao to know which data container driver should be used.
This must be ``General``.

.. _dynamicPtable:

dynamicPtable
~~~~~~~~~~~~~

The dynamic ptable can be solved over the `Parent-child condition mapping`_.

.. _ctable:

ctable
~~~~~~

Defining the child tables is not necessary at all, but can be done by a :ref:`parent-child condition <parent-child-condition>`.

.. _validFileTypes:

validFileTypes
~~~~~~~~~~~~~~

TODO

.. _uploadScript:

uploadScript
~~~~~~~~~~~~

TODO

.. _doNotDeleteRecords:

doNotDeleteRecords
~~~~~~~~~~~~~~~~~~

TODO

DCA mapping reference
---------------------

+----------------------------------------------------------------------------------------+----------------------------------------------+
| .. code-block:: php                                                                    | .. parsed-literal::                          |
|                                                                                        |                                              |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                           |     -> `Data provider mapping`_              |
|     (                                                                                  |                                              |
|         // Config                                                                      |                                              |
|         'config' => array                                                              |                                              |
|         (                                                                              |                                              |
|             'label'              => &$GLOBALS['TL_LANG']['tl_example']['headline'],    |     -> `Listing mapping`_                    |
|             'dataContainer'      => 'General',                                         |     -> :ref:`*ignored* <dataContainer>`      |
|             'ptable'             => 'tl_parent',                                       |     -> `Data provider mapping`_              |
|             'dynamicPtable'      => true, // require 'ptable'=>''                      |     -> :ref:`*ignored* <dynamicPtable>`      |
|             'ctable'             => array('tl_child1', 'tl_child2'),                   |     -> :ref:`*ignored* <ctable>`             |
|             'validFileTypes'     => 'jpg,png,gif',                                     |     -> :ref:`*ignored* <validFileTypes>`     |
|             'uploadScript'       => '',                                                |     -> :ref:`*ignored* <uploadScript>`       |
|             'closed'             => true,                                              |     ->                                       |
|             'notEditable'        => true,                                              |     ->                                       |
|             'notDeletable'       => true,                                              |     ->                                       |
|             'switchToEdit'       => true,                                              |     ->                                       |
|             'enableVersioning'   => true,                                              |     ->                                       |
|             'doNotCopyRecords'   => true,                                              |     ->                                       |
|             'doNotDeleteRecords' => true,                                              |     -> :ref:`*ignored* <doNotDeleteRecords>` |
|             'onload_callback'    => array                                              |     ->                                       |
|             (                                                                          |        ^                                     |
|                 array('<class name>', '<method name>')                                 |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'onsubmit_callback'  => array                                              |     ->                                       |
|             (                                                                          |        ^                                     |
|                 array('<class name>', '<method name>')                                 |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'ondelete_callback'  => array                                              |     ->                                       |
|             (                                                                          |        ^                                     |
|                 array('<class name>', '<method name>')                                 |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'oncut_callback'     => array                                              |     ->                                       |
|             (                                                                          |        ^                                     |
|                 array('<class name>', '<method name>')                                 |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'oncopy_callback'    => array                                              |     ->                                       |
|             (                                                                          |        ^                                     |
|                 array('<class name>', '<method name>')                                 |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'sql'                => array                                              |     -> *ignored*                             |
|             (                                                                          |        ^                                     |
|                 'keys' => array                                                        |        ^                                     |
|                 (                                                                      |        ^                                     |
|                     'id'    => 'primary',                                              |        ^                                     |
|                     'pid'   => 'index',                                                |        ^                                     |
|                     'alias' => 'index'                                                 |        ^                                     |
|                 )                                                                      |        ^                                     |
|             )                                                                          |        ^                                     |
|         ),                                                                             |                                              |
|                                                                                        |                                              |
|         // DcGeneral config                                                            |                                              |
|         'dca_config' => array                                                          |     ->                                       |
|         (                                                                              |                                              |
|             'callback'       => 'DcGeneral\Callbacks\ContaoStyleCallbacks',            |     -> `Deprecated DcGeneral config`_        |
|             'controller'     => 'DcGeneral\Controller\DefaultController',              |     -> `Deprecated DcGeneral config`_        |
|             'view'           => 'DcGeneral\View\DefaultView',                          |     -> `Deprecated DcGeneral config`_        |
|             'data_provider'  => array                                                  |     -> `Data provider mapping`_              |
|             (                                                                          |        ^                                     |
|                     'default' => array                                                 |        ^                                     |
|                     (                                                                  |        ^                                     |
|                             'type'    => '...\ContaoDataProviderInformation',          |        ^                                     |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |        ^                                     |
|                             'class'   => 'DcGeneral\Data\DefaultDriver',               |        ^                                     |
|                             'source'  => 'tl_example'                                  |        ^                                     |
|                     ),                                                                 |        ^                                     |
|                     'parent'  => array                                                 |        ^                                     |
|                     (                                                                  |        ^                                     |
|                             'type'    => '...\ContaoDataProviderInformation',          |        ^                                     |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |        ^                                     |
|                             'class'  => 'DcGeneral\Data\DefaultDriver',                |        ^                                     |
|                             'source' => 'tl_parent'                                    |        ^                                     |
|                     )                                                                  |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'rootEntries' => array(                                                    |     -> `Root entries mapping`_               |
|                 'tl_example' => array(                                                 |        ^                                     |
|                     'setOn'  => array                                                  |        ^                                     |
|                     (                                                                  |        ^                                     |
|                         array(                                                         |        ^                                     |
|                             'property' => 'id',                                        |        ^                                     |
|                             'value'    => 0                                            |        ^                                     |
|                         ),                                                             |        ^                                     |
|                     ),                                                                 |        ^                                     |
|                     'filter' => array                                                  |        ^                                     |
|                     (                                                                  |        ^                                     |
|                         array                                                          |        ^                                     |
|                         (                                                              |        ^                                     |
|                             'property'  => 'id',                                       |        ^                                     |
|                             'value'     => 0,                                          |        ^                                     |
|                             'operation' => '='                                         |        ^                                     |
|                         )                                                              |        ^                                     |
|                     )                                                                  |        ^                                     |
|                 )                                                                      |        ^                                     |
|             ),                                                                         |        ^                                     |
|             'childCondition' => array(                                                 |     -> `Parent-child condition mapping`_     |
|                 array(                                                                 |        ^                                     |
|                     'from'   => 'tl_parent',                                           |        ^                                     |
|                     'to'     => 'tl_example',                                          |        ^                                     |
|                     'setOn'  => array                                                  |        ^                                     |
|                     (                                                                  |        ^                                     |
|                         array(                                                         |        ^                                     |
|                             'from_field' => 'id',                                      |        ^                                     |
|                             'to_field'   => 'pid'                                      |        ^                                     |
|                         ),                                                             |        ^                                     |
|                     ),                                                                 |        ^                                     |
|                     'filter' => array                                                  |        ^                                     |
|                     (                                                                  |        ^                                     |
|                         array                                                          |        ^                                     |
|                         (                                                              |        ^                                     |
|                             'remote'    => 'id',                                       |        ^                                     |
|                             'local'     => 'pid',                                      |        ^                                     |
|                             'operation' => '='                                         |        ^                                     |
|                         )                                                              |        ^                                     |
|                     )                                                                  |        ^                                     |
|                 )                                                                      |        ^                                     |
|             )                                                                          |        ^                                     |
|         ),                                                                             |                                              |
|                                                                                        |                                              |
|         // List                                                                        |                                              |
|         'list' => array                                                                |     -> `Backend view mapping`_               |
|         (                                                                              |                                              |
|             'sorting' => array                                                         |                                              |
|             (                                                                          |                                              |
|                 'mode'                  => 6,                                          |     -> `Basic config mapping`_               |
|                 'flag'                  => 6,                                          |     -> `Listing mapping`_                    |
|                 'panelLayout'           => 'filter;search,limit',                      |     -> `Panel layout mapping`_               |
|                 'fields'                => array('published DESC', 'title', 'author'), |     -> `Listing mapping`_                    |
|                 'headerFields'          => array('title', 'headline', 'author'),       |        ^                                     |
|                 'icon'                  => 'path/to/icon.png',                         |        ^                                     |
|                 'root'                  => 6,                                          |     ->                                       |
|                 'filter'                => array(array('status=?', 'active')),         |     ->                                       |
|                 'disableGrouping'       => true,                                       |     -> `Listing mapping`_                    |
|                 'paste_button_callback' => array('<class name>', '<method name>'),     |     ->                                       |
|                 'child_record_callback' => array('<class name>', '<method name>'),     |     -> `Listing mapping`_                    |
|                 'child_record_class'    => 'css_class_name'                            |        ^                                     |
|             ),                                                                         |                                              |
|             'label' => array                                                           |     -> `Listing mapping`_                    |
|             (                                                                          |        ^                                     |
|                 'fields'         => array('title', 'inColumn'),                        |        ^                                     |
|                 'format'         => '%s <span style="color:#b3b3b3">[%s]</span>',      |        ^                                     |
|                 'maxCharacters'  => 255,                                               |        ^                                     |
|                 'group_callback' => array('<class name>', '<method name>'),            |        ^                                     |
|                 'label_callback' => array('<class name>', '<method name>')             |        ^                                     |
|             ),                                                                         |                                              |
|             'global_operations' => array                                               |     -> `Global operations mapping`_          |
|             (                                                                          |                                              |
|                 'all' => array                                                         |     -> `Operation mapping`_                  |
|                 (                                                                      |        ^                                     |
|                     'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],           |        ^                                     |
|                     'href'            => 'act=select',                                 |        ^                                     |
|                     'class'           => 'header_edit_all',                            |        ^                                     |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |        ^                                     |
|                     'button_callback' => array('<class name>', '<method name>')        |        ^                                     |
|                 )                                                                      |        ^                                     |
|             ),                                                                         |                                              |
|             'operations' => array                                                      |     -> `Item operations mapping`_            |
|             (                                                                          |                                              |
|                 'delete' => array                                                      |     -> `Operation mapping`_                  |
|                 (                                                                      |        ^                                     |
|                     'label'           => &$GLOBALS['TL_LANG']['tl_example']['delete'], |        ^                                     |
|                     'href'            => 'act=delete',                                 |        ^                                     |
|                     'icon'            => 'delete.gif',                                 |        ^                                     |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |        ^                                     |
|                     'button_callback' => array('<class name>', '<method name>')        |        ^                                     |
|                 ),                                                                     |        ^                                     |
|             )                                                                          |                                              |
|         ),                                                                             |                                              |
|                                                                                        |                                              |
|         // Palettes                                                                    |                                              |
|         'palettes' => array                                                            |     -> `Palettes mapping`_                   |
|         (                                                                              |        ^                                     |
|             '__selector__' => array('protected'),                                      |        ^                                     |
|             'default'      => '{title_legend},title,alias,author;...'                  |        ^                                     |
|         ),                                                                             |        ^                                     |
|                                                                                        |                                              |
|         // Subpalettes                                                                 |                                              |
|         'subpalettes' => array                                                         |     -> `Subpalettes mapping`_                |
|         (                                                                              |        ^                                     |
|             'protected' => 'groups'                                                    |        ^                                     |
|         ),                                                                             |        ^                                     |
|                                                                                        |                                              |
|         // Fields                                                                      |                                              |
|         'fields' => array                                                              |     -> `Properties (fka fields) mapping`_    |
|         (                                                                              |        ^                                     |
|             'title' => array                                                           |        ^                                     |
|             (                                                                          |        ^                                     |
|                 'label'                => &$GLOBALS['TL_LANG']['tl_example']['title'], |        ^                                     |
|                 'default'              => 'default value',                             |        ^                                     |
|                 'exclude'              => true,                                        |        ^                                     |
|                 'search'               => true,                                        |        ^                                     |
|                 'sorting'              => true,                                        |        ^                                     |
|                 'filter'               => true,                                        |        ^                                     |
|                 'flag'                 => 12,                                          |        ^                                     |
|                 'length'               => 3,                                           |        ^                                     |
|                 'inputType'            => 'text',                                      |        ^                                     |
|                 'options'              => array('a', 'b', 'c'),                        |        ^                                     |
|                 'options_callback'     => array('<class name>', '<method name>'),      |        ^                                     |
|                 'foreignKey'           => 'tl_other_table.name',                       |        ^                                     |
|                 'reference'            => &$GLOBALS['TL_LANG']['tl_example']['title'], |        ^                                     |
|                 'explanation'          => &$GLOBALS['TL_LANG']['tl_example']['title'], |        ^                                     |
|                 'input_field_callback' => array('<class name>', '<method name>'),      |        ^                                     |
|                 'wizard'               => array('<class name>', '<method name>'),      |        ^                                     |
|                 'sql'                  => "varchar(255) NOT NULL default ''",          |        ^                                     |
|                 'relation'             => array('type'=>'hasOne', 'load'=>'eager'),    |        ^                                     |
|                 'load_callback'        => array                                        |        ^                                     |
|                 (                                                                      |        ^                                     |
|                     array('<class name>', '<method name>')                             |        ^                                     |
|                 ),                                                                     |        ^                                     |
|                 'save_callback'        => array                                        |        ^                                     |
|                 (                                                                      |        ^                                     |
|                     array('<class name>', '<method name>')                             |        ^                                     |
|                 ),                                                                     |        ^                                     |
|                 'eval'                 => array(                                       |     -> `Additional configuration`_           |
|                     'helpwizard'         => true,                                      |        ^                                     |
|                     'mandatory'          => true,                                      |        ^                                     |
|                     'maxlength'          => 255,                                       |        ^                                     |
|                     'minlength'          => 255,                                       |        ^                                     |
|                     'fallback'           => true,                                      |        ^                                     |
|                     'rgxp'               => 'friendly',                                |        ^                                     |
|                     'cols'               => 12,                                        |        ^                                     |
|                     'rows'               => 6,                                         |        ^                                     |
|                     'wrap'               => 'hard',                                    |        ^                                     |
|                     'multiple'           => true,                                      |        ^                                     |
|                     'size'               => 6,                                         |        ^                                     |
|                     'style'              => 'border:2px',                              |        ^                                     |
|                     'rte'                => 'tinyFlash',                               |        ^                                     |
|                     'submitOnChange'     => true,                                      |        ^                                     |
|                     'nospace'            => true,                                      |        ^                                     |
|                     'allowHtml'          => true,                                      |        ^                                     |
|                     'preserveTags'       => true,                                      |        ^                                     |
|                     'decodeEntities'     => true,                                      |        ^                                     |
|                     'doNotSaveEmpty'     => true,                                      |        ^                                     |
|                     'alwaysSave'         => true,                                      |        ^                                     |
|                     'spaceToUnderscore'  => true,                                      |        ^                                     |
|                     'unique'             => true,                                      |        ^                                     |
|                     'encrypt'            => true,                                      |        ^                                     |
|                     'trailingSlash'      => true,                                      |        ^                                     |
|                     'files'              => true,                                      |        ^                                     |
|                     'filesOnly'          => true,                                      |        ^                                     |
|                     'extensions'         => 'jpg,png,gif',                             |        ^                                     |
|                     'path'               => 'path/inside/of/contao',                   |        ^                                     |
|                     'fieldType'          => 'checkbox',                                |        ^                                     |
|                     'includeBlankOption' => true,                                      |        ^                                     |
|                     'blankOptionLabel'   => '- none selected -',                       |        ^                                     |
|                     'chosen'             => true,                                      |        ^                                     |
|                     'findInSet'          => true,                                      |        ^                                     |
|                     'datepicker'         => true,                                      |        ^                                     |
|                     'colorpicker'        => true,                                      |        ^                                     |
|                     'feEditable'         => true,                                      |        ^                                     |
|                     'feGroup'            => 'contact',                                 |        ^                                     |
|                     'feViewable'         => true,                                      |        ^                                     |
|                     'doNotCopy'          => true,                                      |        ^                                     |
|                     'hideInput'          => true,                                      |        ^                                     |
|                     'doNotShow'          => true,                                      |        ^                                     |
|                     'isBoolean'          => true,                                      |        ^                                     |
|                     'disabled'           => true,                                      |        ^                                     |
|                     'readonly'           => true,                                      |        ^                                     |
|                 ),                                                                     |        ^                                     |
|             ),                                                                         |                                              |
|         )                                                                              |                                              |
|     );                                                                                 |                                              |
+----------------------------------------------------------------------------------------+----------------------------------------------+
