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
|                                                         |       backend modules to certain tables and prune unparented data- |
|                                                         |       sets in Contao and considered harmful by the developers of   |
|     );                                                  |       DCGeneral.                                                   |
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
|     );                                                         |    |nl|                                                                    |
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
    /** @var BackendViewSectionInterface $backendViewSection */

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
    /** @var BackendViewSectionInterface $backendViewSection */

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
|                 'format'         => '%s [%s]',                 |    -> (*optional*) used for ``ListItemFormatter::$format``          |
|                                                                |                                                                     |
|                 'maxCharacters'  => 255,                       |    -> (*optional*) used for ``ListItemFormatter::$maxLength``       |
|                                                                |                                                                     |
|                 'group_callback' => array(                     |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                     '<class name>', '<method name>'            |       event depends on the view,                                    |
|                 )                                              |       for details, see the `Callbacks`_ chapter.                    |
|                                                                |                                                                     |
|                 'label_callback' => array()                    |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                     '<class name>', '<method name>'            |       event depends on the view,                                    |
|                 )                                              |       for details, see the `Callbacks`_ chapter.                    |
|             )                                                  |    |nl|                                                             |
|     );                                                         |    |nl|                                                             |
+----------------------------------------------------------------+---------------------------------------------------------------------+

.. _panel-layout-mapping:

Panel layout mapping
~~~~~~~~~~~~~~~~~~~~

You can access the panel layout of the backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\PanelLayoutInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $backendViewSection */

    $panelLayout = $backendViewSection->getPanelLayout();
    /** @var PanelLayoutInterface $panelLayout */

+--------------------------------------------------------+-------------------------------------------------------------------+
| .. code-block:: php                                    | .. parsed-literal::                                               |
|                                                        |                                                                   |
|     $GLOBALS['TL_DCA']['tl_example'] = array           |    |nl|                                                           |
|     (                                                  |    |nl|                                                           |
|         // List                                        |    |nl|                                                           |
|         'list' => array                                |    |nl|                                                           |
|         (                                              |    |nl|                                                           |
|             'sorting' => array                         |    |nl|                                                           |
|             (                                          |    |nl|                                                           |
|                 'panelLayout' => 'filter;search,limit' |    -> (*optional*) will be parsed and used as panel layout array. |
|             )                                          |       ``$panelLayout->getRows()`` will return                     |
|         )                                              |       ``array(array('filter'), array('search', 'limit'))``        |
|     );                                                 |    |nl|                                                           |
+--------------------------------------------------------+-------------------------------------------------------------------+


Global operations mapping
~~~~~~~~~~~~~~~~~~~~~~~~~

Global operations are mapped as :ref:`container scoped commands <container-scoped-commands>`.

To see how the operations are mapped, see the `Operation mapping`_ chapter.

You can access the global operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $backendViewSection */

    $globalOperations = $backendViewSection->getGlobalOperations();
    /** @var OperationCollectionInterface $globalOperations */

Model operations mapping
~~~~~~~~~~~~~~~~~~~~~~~~

Model operations are mapped as :ref:`model scoped commands <model-scoped-commands>`.

To see how the operations are mapped, see the `Operation mapping`_ chapter.

You can access the item operations defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\BackendViewSectionInterface;
    use DcGeneral\DataDefinition\Section\View\OperationCollectionInterface;

    $backendViewSection = $container->getSection(BackendViewSectionInterface::NAME);
    /** @var BackendViewSectionInterface $backendViewSection */

    $itemOperations = $backendViewSection->getItemOperations();
    /** @var OperationCollectionInterface $itemOperations */

.. _operation-mapping:

Operation mapping
~~~~~~~~~~~~~~~~~

In DcGeneral all operations are used as :doc:`../commands`.

+---------------------------------------------------------------------+---------------------------------------------------------------------+
| .. code-block:: php                                                 | .. parsed-literal::                                                 |
|                                                                     |                                                                     |
|     'all' => array                                                  |    -> (*optional*) used as operation's command name                 |
|     (                                                               |       ``$operation->getName()``                                     |
|                                                                     |                                                                     |
|         'parameters'      => array(),                               |    -> (*optional*) used as operation's command parameters           |
|                                                                     |       ``$operation->getParameters()``                               |
|                                                                     |                                                                     |
|         'href'            => 'act=select',                          |    -> (*deprecated*) the query string is parsed and used as command |
|                                                                     |       parameters, if the query contain a parameter named ``act``,   |
|                                                                     |       the value is used as command name                             |
|                                                                     |                                                                     |
|         'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],    |    -> (*optional*) used as operation label (human readable name)    |
|                                                                     |       ``$operation->getLabel()``                                    |
|                                                                     |                                                                     |
|         'description'     => &$GLOBALS['TL_LANG']['MSC']['all'],    |    -> (*optional*) used as operation description (tooltip)          |
|                                                                     |       ``$operation->getDescription()``                              |
|                                                                     |                                                                     |
|         'icon'            => 'delete.gif',                          |    -> (*optional*) will be added to *extra* data                    |
|                                                                     |       ``$operation->getExtra()['icon']``                            |
|                                                                     |                                                                     |
|         'class'           => 'header_edit_all',                     |    -> (*optional*) will be added to *extra* data                    |
|                                                                     |       ``$operation->getExtra()['class']``                           |
|                                                                     |                                                                     |
|         'attributes'      => 'onclick="Backend.getScrollOffset()"', |    -> (*optional*) will be added to *extra* data                    |
|                                                                     |       ``$operation->getExtra()['attributes']``                      |
|                                                                     |                                                                     |
|         '<extra data>'    => <mixed>,                               |    -> (*optional*) all extra data will be mapped into the           |
|                                                                     |       operations extra data array. The usage depends on the view    |
|                                                                     |       ``$operation->getExtra()``                                    |
|                                                                     |                                                                     |
|         'button_callback' => array('<class name>', '<method name>') |    -> (*deprecated*) use an event listener instead, the dispatched  |
|                                                                     |       event depends on the view,                                    |
|     )                                                               |       for details, see the `Callbacks`_ chapter.                    |
+---------------------------------------------------------------------+---------------------------------------------------------------------+

Palettes mapping
----------------

Palettes define the arrangement of properties in the view.
The :class:`DcGeneral\\DataDefinition\\Section\\PalettesSectionInterface` itself is a subclass of :class:`DcGeneral\\DataDefinition\\Palette\\PaletteCollectionInterface`.

You can access the palettes defined in backend view section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\PalettesSectionInterface;

    $palettesSection = $container->getSection(PalettesSectionInterface::NAME);
    /** @var PalettesSectionInterface $palettesSection */

Mapping
~~~~~~~

+-----------------------------------------------------------------------+----------------------------------------------------------------+
| .. code-block:: php                                                   | .. parsed-literal::                                            |
|                                                                       |                                                                |
|     $GLOBALS['TL_DCA']['tl_example'] = array                          |    |nl|                                                        |
|     (                                                                 |    |nl|                                                        |
|         // Palettes                                                   |    |nl|                                                        |
|         'palettes' => array                                           |    |nl|                                                        |
|         (                                                             |    |nl|                                                        |
|             '__selector__' => array('protected'),                     |    -> (*deprecated*) define selectors is not required,         |
|                                                                       |       the selector list will be used to generate the           |
|                                                                       |       corresponding palette conditions.                        |
|                                                                       |                                                                |
|             'default'      => '{title_legend},title,alias,author;...' |    -> (*deprecated*) will be parsed into legends from          |
|         ),                                                            |       the ``{*_legend}`` parts and property collections        |
|                                                                       |       from the fields list.                                    |
|         // Subpalettes                                                |                                                                |
|         'subpalettes' => array                                        |    -> (*deprecated*) the generated palettes will be extended   |
|         (                                                             |       with the subpalette properties, each subpalette property |
|             'protected' => 'groups'                                   |       gain a corresponding property condition.                 |
|         )                                                             |    |nl|                                                        |
|     );                                                                |    |nl|                                                        |
+-----------------------------------------------------------------------+----------------------------------------------------------------+

See the :doc:`../palettes` document for details about the new palettes system.

Properties (fka fields) mapping
-------------------------------

Properties formally known as fields, define certain meta informations of model's properties.
Every model property, that is not defined here, is ignored by DcGeneral.

These meta informations can have different effects on the properties value (like transformation), the load and store process (similar to triggers) and the view (like display formation).

You can access the properties section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\PropertiesSectionInterface;

    $propertiesSection = $container->getSection(PropertiesSectionInterface::NAME);
    /** @var PropertiesSectionInterface $propertiesSection */

You can access a single property from the properties section with this snippet:

.. code-block:: php

    use DcGeneral\DataDefinition\Section\Palette\PropertyInterface;

    $titleProperty = $propertiesSection->getProperty('title');
    /** @var PropertyInterface $titleProperty */

+------------------------------------------------------------------------------+----------------------------------------------------------------+
| .. code-block:: php                                                          | .. parsed-literal::                                            |
|                                                                              |                                                                |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                 |    |nl|                                                        |
|     (                                                                        |    |nl|                                                        |
|         // Fields                                                            |    |nl|                                                        |
|         'fields' => array                                                    |    |nl|                                                        |
|         (                                                                    |    |nl|                                                        |
|             'title' => array                                                 |    -> (*required*) used as property name.                      |
|             (                                                                |       ``$property->getName()``                                 |
|                                                                              |                                                                |
|                 'label' => &$GLOBALS['TL_LANG']['...']['title'],             |    -> (*required*) used as property label.                     |
|                                                                              |       if it is an array, only the first item                   |
|                                                                              |       is used as label.                                        |
|                                                                              |       ``$property->getLabel()``                                |
|                                                                              |                                                                |
|                 'description' => &$GLOBALS['TL_LANG']['...']['description'], |    -> (*optional*) used as property description.               |
|                                                                              |       if **label** is an array, the second item                |
|                                                                              |       is used as description.                                  |
|                                                                              |       ``$property->getDescription()``                          |
|                                                                              |                                                                |
|                 'default' => 'default value',                                |    -> (*optional*) used as property default value.             |
|                                                                              |       ``$property->getDefaultValue()``                         |
|                                                                              |                                                                |
|                 'exclude' => true,                                           |    -> (*optional*) define if this property can be              |
|                                                                              |       excluded from an editors view.                           |
|                                                                              |       ``$property->isExcluded()``                              |
|                                                                              |                                                                |
|                 'search' => true,                                            |    -> (*optional*) define if this property is searchable       |
|                                                                              |       ``$property->isSearchable()``                            |
|                                                                              |                                                                |
|                 'sorting' => true,                                           |    -> (*optional*) define if this property is sortable         |
|                                                                              |       ``$property->isSortable()``                              |
|                                                                              |                                                                |
|                 'filter' => true,                                            |    -> (*optional*) define if this property is filterable       |
|                                                                              |       ``$property->isFilterable()``                            |
|                                                                              |                                                                |
|                 'flag' => 12,                                                |    -> (*deprecated*) define the sort and group mode            |
|                                                                              |       ``$property->getGroupingMode()``                         |
|                                                                              |       ``$property->getSortingMode()``                          |
|                                                                              |                                                                |
|                 'length' => 3,                                               |    -> (*optional*) define the count of signs used              |
|                                                                              |       for grouping                                             |
|                                                                              |       ``$property->getGroupingLength()``                       |
|                                                                              |                                                                |
|                 'inputType' => 'text',                                       |    -> (*optional*) define the input type (widget type)         |
|                                                                              |       of this property. How the widget type is interpreted     |
|                                                                              |       depends on the view.                                     |
|                                                                              |       ``$property->getWidgetType()``                           |
|                                                                              |                                                                |
|                 'options' => array('a', 'b', 'c'),                           |    -> (*optional*) The valid values of this property,          |
|                                                                              |       formally used by selectable input types.                 |
|                                                                              |       ``$property->getOptions()``                              |
|                                                                              |                                                                |
|                 'options_callback' => array(...),                            |    -> (*deprecated*) define a callback that produce the        |
|                                                                              |       valid values of this property.                           |
|                                                                              |       for details, see the `Callbacks`_ chapter.               |
|                                                                              |                                                                |
|                 'foreignKey' => 'tl_other_table.name',                       |    -> (*deprecated*) define a foreign key that are used        |
|                                                                              |       as valid values of this property.                        |
|                                                                              |                                                                |
|                 'reference' => &$GLOBALS['TL_LANG']['...']['title'],         |    -> (*deprecated*) language array with translations          |
|                                                                              |       for the valid values.                                    |
|                                                                              |                                                                |
|                 'explanation' => &$GLOBALS['TL_LANG']['...']['title'],       |    -> (*optional*) the explanation of the property, is         |
|                                                                              |       used in property overview.                               |
|                                                                              |       ``$property->getExplanation()``                          |
|                                                                              |                                                                |
|                 'input_field_callback' => array(...),                        |    -> (*deprecated*) define a callback that produce the        |
|                                                                              |       widget html code, if this is used depends on the         |
|                                                                              |       view.                                                    |
|                                                                              |       for details, see the `Callbacks`_ chapter.               |
|                                                                              |                                                                |
|                 'wizard' => array('<class name>', '<method name>'),          |    -> (*deprecated*) define a callback that produce the        |
|                                                                              |       wizard html code, if this is used depends on the         |
|                                                                              |       view.                                                    |
|                                                                              |       for details, see the `Callbacks`_ chapter.               |
|                                                                              |                                                                |
|                 'relation' => array('type'=>'hasOne', 'load'=>'eager'),      |    -> (*ignored*) the relations are only used by the           |
|                                                                              |       Contao models (don't confuse with the DcGeneral models!) |
|                                                                              |                                                                |
|                 'load_callback' => array                                     |    -> (*deprecated*) define a callback that is called after    |
|                 (                                                            |       loading the data from the model.                         |
|                     array('<class name>', '<method name>')                   |       for details, see the `Callbacks`_ chapter.               |
|                 ),                                                           |                                                                |
|                                                                              |                                                                |
|                 'save_callback' => array                                     |    -> (*deprecated*) define a callback that is called before   |
|                 (                                                            |       saving the data to the model.                            |
|                     array('<class name>', '<method name>')                   |       for details, see the `Callbacks`_ chapter.               |
|                 ),                                                           |                                                                |
|                                                                              |                                                                |
|                 'eval' => array(                                             |    -> (*optional*) any additional configuration data,          |
|                     ...                                                      |       if this data is used depends on the view, widget type    |
|                 ),                                                           |       and event listeners.                                     |
|                                                                              |       ``$property->getExtra()``                                |
|                                                                              |                                                                |
|                 'sql' => "varchar(255) NOT NULL default ''"                  |    -> (:ref:`*ignored* <sql>`) the sql is used by              |
|             )                                                                |       Contao's DcaExtractor                                    |
|         )                                                                    |    |nl|                                                        |
|     );                                                                       |    |nl|                                                        |
+------------------------------------------------------------------------------+----------------------------------------------------------------+

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

TODO add an example

.. _ctable:

ctable
~~~~~~

Defining the child tables is not necessary at all, but can be done by a :ref:`parent-child condition <parent-child-condition>`.

TODO add an example

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

.. _sql:

sql
~~~

DcGeneral does not do any sql updated, so there is no need to parse this informations.

DCA mapping reference
---------------------

+----------------------------------------------------------------------------------------+---------------------------------------------+
| .. code-block:: php                                                                    | .. parsed-literal::                         |
|                                                                                        |                                             |
|     $GLOBALS['TL_DCA']['tl_example'] = array                                           |    -> `Data provider mapping`_              |
|     (                                                                                  |                                             |
|         // Config                                                                      |                                             |
|         'config' => array                                                              |                                             |
|         (                                                                              |                                             |
|             'label'              => &$GLOBALS['TL_LANG']['tl_example']['headline'],    |    -> `Listing mapping`_                    |
|             'dataContainer'      => 'General',                                         |    -> :ref:`*ignored* <dataContainer>`      |
|             'ptable'             => 'tl_parent',                                       |    -> `Data provider mapping`_              |
|             'dynamicPtable'      => true, // require 'ptable'=>''                      |    -> :ref:`*ignored* <dynamicPtable>`      |
|             'ctable'             => array('tl_child1', 'tl_child2'),                   |    -> :ref:`*ignored* <ctable>`             |
|             'validFileTypes'     => 'jpg,png,gif',                                     |    -> :ref:`*ignored* <validFileTypes>`     |
|             'uploadScript'       => '',                                                |    -> :ref:`*ignored* <uploadScript>`       |
|             'closed'             => true,                                              |    ->                                       |
|             'notEditable'        => true,                                              |    ->                                       |
|             'notDeletable'       => true,                                              |    ->                                       |
|             'switchToEdit'       => true,                                              |    ->                                       |
|             'enableVersioning'   => true,                                              |    ->                                       |
|             'doNotCopyRecords'   => true,                                              |    ->                                       |
|             'doNotDeleteRecords' => true,                                              |    -> :ref:`*ignored* <doNotDeleteRecords>` |
|             'onload_callback'    => array                                              |    ->                                       |
|             (                                                                          |       ^                                     |
|                 array('<class name>', '<method name>')                                 |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'onsubmit_callback'  => array                                              |    ->                                       |
|             (                                                                          |       ^                                     |
|                 array('<class name>', '<method name>')                                 |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'ondelete_callback'  => array                                              |    ->                                       |
|             (                                                                          |       ^                                     |
|                 array('<class name>', '<method name>')                                 |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'oncut_callback'     => array                                              |    ->                                       |
|             (                                                                          |       ^                                     |
|                 array('<class name>', '<method name>')                                 |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'oncopy_callback'    => array                                              |    ->                                       |
|             (                                                                          |       ^                                     |
|                 array('<class name>', '<method name>')                                 |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'sql'                => array                                              |    -> :ref:`*ignored* <sql>`                |
|             (                                                                          |       ^                                     |
|                 'keys' => array                                                        |       ^                                     |
|                 (                                                                      |       ^                                     |
|                     'id'    => 'primary',                                              |       ^                                     |
|                     'pid'   => 'index',                                                |       ^                                     |
|                     'alias' => 'index'                                                 |       ^                                     |
|                 )                                                                      |       ^                                     |
|             )                                                                          |       ^                                     |
|         ),                                                                             |                                             |
|                                                                                        |                                             |
|         // DcGeneral config                                                            |                                             |
|         'dca_config' => array                                                          |    ->                                       |
|         (                                                                              |                                             |
|             'callback'       => 'DcGeneral\Callbacks\ContaoStyleCallbacks',            |    -> `Deprecated DcGeneral config`_        |
|             'controller'     => 'DcGeneral\Controller\DefaultController',              |    -> `Deprecated DcGeneral config`_        |
|             'view'           => 'DcGeneral\View\DefaultView',                          |    -> `Deprecated DcGeneral config`_        |
|             'data_provider'  => array                                                  |    -> `Data provider mapping`_              |
|             (                                                                          |       ^                                     |
|                     'default' => array                                                 |       ^                                     |
|                     (                                                                  |       ^                                     |
|                             'type'    => '...\ContaoDataProviderInformation',          |       ^                                     |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |       ^                                     |
|                             'class'   => 'DcGeneral\Data\DefaultDriver',               |       ^                                     |
|                             'source'  => 'tl_example'                                  |       ^                                     |
|                     ),                                                                 |       ^                                     |
|                     'parent'  => array                                                 |       ^                                     |
|                     (                                                                  |       ^                                     |
|                             'type'    => '...\ContaoDataProviderInformation',          |       ^                                     |
|                             'factory' => '...\ContaoDataProviderInformationFactory',   |       ^                                     |
|                             'class'  => 'DcGeneral\Data\DefaultDriver',                |       ^                                     |
|                             'source' => 'tl_parent'                                    |       ^                                     |
|                     )                                                                  |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'rootEntries' => array(                                                    |    -> `Root entries mapping`_               |
|                 'tl_example' => array(                                                 |       ^                                     |
|                     'setOn'  => array                                                  |       ^                                     |
|                     (                                                                  |       ^                                     |
|                         array(                                                         |       ^                                     |
|                             'property' => 'id',                                        |       ^                                     |
|                             'value'    => 0                                            |       ^                                     |
|                         ),                                                             |       ^                                     |
|                     ),                                                                 |       ^                                     |
|                     'filter' => array                                                  |       ^                                     |
|                     (                                                                  |       ^                                     |
|                         array                                                          |       ^                                     |
|                         (                                                              |       ^                                     |
|                             'property'  => 'id',                                       |       ^                                     |
|                             'value'     => 0,                                          |       ^                                     |
|                             'operation' => '='                                         |       ^                                     |
|                         )                                                              |       ^                                     |
|                     )                                                                  |       ^                                     |
|                 )                                                                      |       ^                                     |
|             ),                                                                         |       ^                                     |
|             'childCondition' => array(                                                 |    -> `Parent-child condition mapping`_     |
|                 array(                                                                 |       ^                                     |
|                     'from'   => 'tl_parent',                                           |       ^                                     |
|                     'to'     => 'tl_example',                                          |       ^                                     |
|                     'setOn'  => array                                                  |       ^                                     |
|                     (                                                                  |       ^                                     |
|                         array(                                                         |       ^                                     |
|                             'from_field' => 'id',                                      |       ^                                     |
|                             'to_field'   => 'pid'                                      |       ^                                     |
|                         ),                                                             |       ^                                     |
|                     ),                                                                 |       ^                                     |
|                     'filter' => array                                                  |       ^                                     |
|                     (                                                                  |       ^                                     |
|                         array                                                          |       ^                                     |
|                         (                                                              |       ^                                     |
|                             'remote'    => 'id',                                       |       ^                                     |
|                             'local'     => 'pid',                                      |       ^                                     |
|                             'operation' => '='                                         |       ^                                     |
|                         )                                                              |       ^                                     |
|                     )                                                                  |       ^                                     |
|                 )                                                                      |       ^                                     |
|             )                                                                          |       ^                                     |
|         ),                                                                             |                                             |
|                                                                                        |                                             |
|         // List                                                                        |                                             |
|         'list' => array                                                                |    -> `Backend view mapping`_               |
|         (                                                                              |                                             |
|             'sorting' => array                                                         |                                             |
|             (                                                                          |                                             |
|                 'mode'                  => 6,                                          |    -> `Basic config mapping`_               |
|                 'flag'                  => 6,                                          |    -> `Listing mapping`_                    |
|                 'panelLayout'           => 'filter;search,limit',                      |    -> `Panel layout mapping`_               |
|                 'fields'                => array('published DESC', 'title', 'author'), |    -> `Listing mapping`_                    |
|                 'headerFields'          => array('title', 'headline', 'author'),       |       ^                                     |
|                 'header_callback'       => array('<class name>', '<method name>'),     |       ^                                     |
|                 'icon'                  => 'path/to/icon.png',                         |       ^                                     |
|                 'root'                  => 6,                                          |    ->                                       |
|                 'filter'                => array(array('status=?', 'active')),         |    ->                                       |
|                 'disableGrouping'       => true,                                       |    -> `Listing mapping`_                    |
|                 'paste_button_callback' => array('<class name>', '<method name>'),     |    ->                                       |
|                 'child_record_callback' => array('<class name>', '<method name>'),     |    -> `Listing mapping`_                    |
|                 'child_record_class'    => 'css_class_name'                            |       ^                                     |
|             ),                                                                         |                                             |
|             'label' => array                                                           |    -> `Listing mapping`_                    |
|             (                                                                          |       ^                                     |
|                 'fields'         => array('title', 'inColumn'),                        |       ^                                     |
|                 'format'         => '%s <span style="color:#b3b3b3">[%s]</span>',      |       ^                                     |
|                 'maxCharacters'  => 255,                                               |       ^                                     |
|                 'group_callback' => array('<class name>', '<method name>'),            |       ^                                     |
|                 'label_callback' => array('<class name>', '<method name>')             |       ^                                     |
|             ),                                                                         |                                             |
|             'global_operations' => array                                               |    -> `Global operations mapping`_          |
|             (                                                                          |                                             |
|                 'all' => array                                                         |    -> `Operation mapping`_                  |
|                 (                                                                      |       ^                                     |
|                     'label'           => &$GLOBALS['TL_LANG']['MSC']['all'],           |       ^                                     |
|                     'href'            => 'act=select',                                 |       ^                                     |
|                     'class'           => 'header_edit_all',                            |       ^                                     |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |       ^                                     |
|                     'button_callback' => array('<class name>', '<method name>')        |       ^                                     |
|                 )                                                                      |       ^                                     |
|             ),                                                                         |                                             |
|             'operations' => array                                                      |    -> `Model operations mapping`_           |
|             (                                                                          |                                             |
|                 'delete' => array                                                      |    -> `Operation mapping`_                  |
|                 (                                                                      |       ^                                     |
|                     'label'           => &$GLOBALS['TL_LANG']['tl_example']['delete'], |       ^                                     |
|                     'href'            => 'act=delete',                                 |       ^                                     |
|                     'icon'            => 'delete.gif',                                 |       ^                                     |
|                     'attributes'      => 'onclick="Backend.getScrollOffset()"',        |       ^                                     |
|                     'button_callback' => array('<class name>', '<method name>')        |       ^                                     |
|                 ),                                                                     |       ^                                     |
|             )                                                                          |                                             |
|         ),                                                                             |                                             |
|                                                                                        |                                             |
|         // Palettes                                                                    |                                             |
|         'palettes' => array                                                            |    -> `Palettes mapping`_                   |
|         (                                                                              |       ^                                     |
|             '__selector__' => array('protected'),                                      |       ^                                     |
|             'default'      => '{title_legend},title,alias,author;...'                  |       ^                                     |
|         ),                                                                             |       ^                                     |
|                                                                                        |       ^                                     |
|         // Subpalettes                                                                 |       ^                                     |
|         'subpalettes' => array                                                         |       ^                                     |
|         (                                                                              |       ^                                     |
|             'protected' => 'groups'                                                    |       ^                                     |
|         ),                                                                             |       ^                                     |
|                                                                                        |                                             |
|         // Fields                                                                      |                                             |
|         'fields' => array                                                              |    -> `Properties (fka fields) mapping`_    |
|         (                                                                              |       ^                                     |
|             'title' => array                                                           |       ^                                     |
|             (                                                                          |       ^                                     |
|                 'label'                => &$GLOBALS['TL_LANG']['tl_example']['title'], |       ^                                     |
|                 'default'              => 'default value',                             |       ^                                     |
|                 'exclude'              => true,                                        |       ^                                     |
|                 'search'               => true,                                        |       ^                                     |
|                 'sorting'              => true,                                        |       ^                                     |
|                 'filter'               => true,                                        |       ^                                     |
|                 'flag'                 => 12,                                          |       ^                                     |
|                 'length'               => 3,                                           |       ^                                     |
|                 'inputType'            => 'text',                                      |       ^                                     |
|                 'options'              => array('a', 'b', 'c'),                        |       ^                                     |
|                 'options_callback'     => array('<class name>', '<method name>'),      |       ^                                     |
|                 'foreignKey'           => 'tl_other_table.name',                       |       ^                                     |
|                 'reference'            => &$GLOBALS['TL_LANG']['tl_example']['title'], |       ^                                     |
|                 'explanation'          => &$GLOBALS['TL_LANG']['tl_example']['title'], |       ^                                     |
|                 'input_field_callback' => array('<class name>', '<method name>'),      |       ^                                     |
|                 'wizard'               => array('<class name>', '<method name>'),      |       ^                                     |
|                 'relation'             => array('type'=>'hasOne', 'load'=>'eager'),    |       ^                                     |
|                 'load_callback'        => array                                        |       ^                                     |
|                 (                                                                      |       ^                                     |
|                     array('<class name>', '<method name>')                             |       ^                                     |
|                 ),                                                                     |       ^                                     |
|                 'save_callback'        => array                                        |       ^                                     |
|                 (                                                                      |       ^                                     |
|                     array('<class name>', '<method name>')                             |       ^                                     |
|                 ),                                                                     |       ^                                     |
|                 'eval'                 => array(                                       |       ^                                     |
|                     'helpwizard'         => true,                                      |       ^                                     |
|                     'mandatory'          => true,                                      |       ^                                     |
|                     'maxlength'          => 255,                                       |       ^                                     |
|                     'minlength'          => 255,                                       |       ^                                     |
|                     'fallback'           => true,                                      |       ^                                     |
|                     'rgxp'               => 'friendly',                                |       ^                                     |
|                     'cols'               => 12,                                        |       ^                                     |
|                     'rows'               => 6,                                         |       ^                                     |
|                     'wrap'               => 'hard',                                    |       ^                                     |
|                     'multiple'           => true,                                      |       ^                                     |
|                     'size'               => 6,                                         |       ^                                     |
|                     'style'              => 'border:2px',                              |       ^                                     |
|                     'rte'                => 'tinyFlash',                               |       ^                                     |
|                     'submitOnChange'     => true,                                      |       ^                                     |
|                     'nospace'            => true,                                      |       ^                                     |
|                     'allowHtml'          => true,                                      |       ^                                     |
|                     'preserveTags'       => true,                                      |       ^                                     |
|                     'decodeEntities'     => true,                                      |       ^                                     |
|                     'doNotSaveEmpty'     => true,                                      |       ^                                     |
|                     'alwaysSave'         => true,                                      |       ^                                     |
|                     'spaceToUnderscore'  => true,                                      |       ^                                     |
|                     'unique'             => true,                                      |       ^                                     |
|                     'encrypt'            => true,                                      |       ^                                     |
|                     'trailingSlash'      => true,                                      |       ^                                     |
|                     'files'              => true,                                      |       ^                                     |
|                     'filesOnly'          => true,                                      |       ^                                     |
|                     'extensions'         => 'jpg,png,gif',                             |       ^                                     |
|                     'path'               => 'path/inside/of/contao',                   |       ^                                     |
|                     'fieldType'          => 'checkbox',                                |       ^                                     |
|                     'includeBlankOption' => true,                                      |       ^                                     |
|                     'blankOptionLabel'   => '- none selected -',                       |       ^                                     |
|                     'chosen'             => true,                                      |       ^                                     |
|                     'findInSet'          => true,                                      |       ^                                     |
|                     'datepicker'         => true,                                      |       ^                                     |
|                     'colorpicker'        => true,                                      |       ^                                     |
|                     'feEditable'         => true,                                      |       ^                                     |
|                     'feGroup'            => 'contact',                                 |       ^                                     |
|                     'feViewable'         => true,                                      |       ^                                     |
|                     'doNotCopy'          => true,                                      |       ^                                     |
|                     'hideInput'          => true,                                      |       ^                                     |
|                     'doNotShow'          => true,                                      |       ^                                     |
|                     'isBoolean'          => true,                                      |       ^                                     |
|                     'disabled'           => true,                                      |       ^                                     |
|                     'readonly'           => true,                                      |       ^                                     |
|                 ),                                                                     |       ^                                     |
|                 'sql' => 'varchar(255) NOT NULL default '''                            |    -> :ref:`*ignored* <sql>`                |
|             )                                                                          |    |nl|                                     |
|         )                                                                              |    |nl|                                     |
|     );                                                                                 |    |nl|                                     |
+----------------------------------------------------------------------------------------+---------------------------------------------+
