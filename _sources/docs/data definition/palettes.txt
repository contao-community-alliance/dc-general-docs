Palettes
========

History and basics
------------------

In Contao palettes are defined as array of strings like this:

.. code-block:: php

    'palettes' => array(
        '__selector__' => array('type'),
        'default' => '{title_legend},type,title;{published_legend:hide},published',
        'type_one' => '{title_legend},type,title;{experts_legend:hide},expert_option;{published_legend:hide},published',
    ),
    'subpalettes' => array(
        'published' => 'start,stop'
    ),

Which is very limited in every case. Strings make it difficult to manipulate palettes. And there is only two level of conditional fields, the palette selection and subpalettes. Because string based palettes are very limited, the `MetaPalettes <https://github.com/bit3/contao-meta-palettes>`_ extension tries to extend palettes by defining them as arrays of arrays like this:

.. code-block:: php

    'palettes' => array(
        '__selector__' => array('type')
    ),
    'metapalettes' => array(
        'default' => array(
            'title' => array('type', 'title'),
            'published' => array(':hide', published')
        ),
        'type_one' => array(
            'title' => array('type', 'title'),
            'experts' => array(':hide', 'expert_option'),
            'published' => array(':hide', published')
        )
    ),
    'metasubpalettes' => array(
        'published' => array('start', 'stop')
    ),

MetaPalettes make the definition and manipulation of palettes easier, but it is still hardly limited in fact it only generate string based palettes from the arrays. Everything else is done by Contao's DC_Table.

To break the known limitations, the DC General contains an object oriented palette system.

The palette object hierarchy
----------------------------

::

    Container
      \-1:1- PaletteCollection
              \-( contains a set of palettes )
              \-1:n- Palette
                      \-( contains a set of legends )
                      \-( can have a condition that define the active palette )
                      \-1:n- Legend
                              \-( contains a set of properties aka fields )
                              \-1:n- Property
                                      \-( a property aka field in a legend )
                                      \-( can have conditions that define if the property is visible and editable )

There is no place for subpalettes or something similar. Instead of use a direct hierarchical bounding between fields, each field can have a condition (or more through a chain) that define if the field is visible and/or editable.

Same for palettes, which will not selected by their name (the name is supported, but is marked as deprecated will be dropped in the future). Palettes even can have a condition (or more through a chain) that define if the palette is active or not.

Conditions
----------

Properties has two conditions. One for its visibility and one for the editable state. If no condition is set, the property is supposed to be visible and editable.

Palette conditions are a bit more complex, even if they have only one condition. To determinate the active palette, a matching count is calculated from the condition. The ``DefaultPaletteCondition`` produce a matching count of ``0`` (the lowest value by definition, negative values are not supported). Every other condition produce a matching count of ``1`` or greater. A ``PaletteConditionChain`` summarize all counts from its conditions. A ``false`` matching count means "no matching". The palette with the highest matching count is supposed as active palette.

PHP Example
-----------

The palettes are object oriented, that means you can directly create your palettes via PHP code.

.. code-block:: php
    :linenos:

    // main objects
    use DcGeneral\DataDefinition\Palette\PaletteCollection;
    use DcGeneral\DataDefinition\Palette\Palette;
    use DcGeneral\DataDefinition\Palette\Legend;
    use DcGeneral\DataDefinition\Palette\Property;

    // conditions for palettes
    use DcGeneral\DataDefinition\Palette\Condition\Palette\DefaultPaletteCondition;
    use DcGeneral\DataDefinition\Palette\Condition\Palette\PropertyValueCondition as PalettePropertyValueCondition;

    // conditions for properties
    use DcGeneral\DataDefinition\Palette\Condition\Property\PropertyValueCondition;

    // default palette
    {
      // create type property
      $typeProperty = new Property();
      $typeProperty->setName('type');

      // create title property
      $titleProperty = new Property();
      $titleProperty->setName('title');

      // create published property
      $publishedProperty = new Property();
      $publishedProperty->setName('published');

      // create start property
      $startProperty = new Property();
      $startProperty->setName('start');
      $startProperty->setCondition(new PropertyValueCondition('published', true));

      // create stop property
      $stopProperty = new Property();
      $stopProperty->setName('stop');
      $stopProperty->setCondition(new PropertyValueCondition('published', true));

      // create title legend
      $titleLegend = new Legend();
      $titleLegend->setName('title');
      $titleLegend->addProperty($typeProperty);
      $titleLegend->addProperty($titleProperty);

      // create published legend
      $publishedLegend = new Legend();
      $publishedLegend->setName('published');
      $publishedLegend->addProperty($publishedProperty);
      $publishedLegend->addProperty($startProperty);
      $publishedLegend->addProperty($stopProperty);

      // create default palette
      $defaultPalette = new Palette();
      $defaultPalette->setName('default');
      $defaultPalette->addLegend($titleLegend);
      $defaultPalette->addLegend($publishedLegend);
      $defaultPalette->setCondition(new DefaultPaletteCondition());
    }

    // type_one palette
    {
      // create type property
      $typeProperty = new Property();
      $typeProperty->setName('type');

      // create title property
      $titleProperty = new Property();
      $titleProperty->setName('title');

      // create expert option property
      $expertOptionProperty = new Property();
      $expertOptionProperty->setName('expert_option');

      // create published property
      $publishedProperty = new Property();
      $publishedProperty->setName('published');

      // create start property
      $startProperty = new Property();
      $startProperty->setName('start');
      $startProperty->setCondition(new PropertyValueCondition('published', true));

      // create stop property
      $stopProperty = new Property();
      $stopProperty->setName('stop');
      $stopProperty->setCondition(new PropertyValueCondition('published', true));

      // create title legend
      $titleLegend = new Legend();
      $titleLegend->setName('title');
      $titleLegend->addProperty($typeProperty);
      $titleLegend->addProperty($titleProperty);

      // create experts legend
      $expertsLegend = new Legend();
      $expertsLegend->setName('experts');
      $expertsLegend->addProperty($expertOptionProperty);

      // create published legend
      $publishedLegend = new Legend();
      $publishedLegend->setName('published');
      $publishedLegend->addProperty($publishedProperty);
      $publishedLegend->addProperty($startProperty);
      $publishedLegend->addProperty($stopProperty);

      // create default palette
      $defaultPalette = new Palette();
      $defaultPalette->setName('default');
      $defaultPalette->addLegend($titleLegend);
      $defaultPalette->addLegend($expertsLegend);
      $defaultPalette->addLegend($publishedLegend);
      $defaultPalette->setCondition(new PalettePropertyValueCondition('type', 'type_one'));
    }

    // create the palette collection and add all palettes
    $collection = new PaletteCollection();
    $collection->addPalette($defaultPalette);
    $collection->addPalette($typeOnePalette);

This create the same palette as the example in the first chapter `History and basics`_.

Palette Builder
---------------

The `PHP example`_ show how to create palettes by directly accessing the API. Using the API may result in a lot of code. If you need to use PHP, it is easier to use the :doc:`builder`.

.. code-block:: php
    :linenos:

    use DcGeneral\DataDefinition\Palette\PaletteBuilder;

    $collection = null;
    PaletteBuilder::create()
      ->createPalette('default')
        ->createLegend('title')
          ->createProperty('type', 'title')
            ->finishProperty()
          ->finishLegend()
          ->finishLegend()
        ->createLegend('published')
          ->createProperty('published')
            ->finishProperty()
          ->createProperty('start', 'stop')
            ->createPropertyValueCondition('published', true)
              ->finishCondition()
            ->finishProperty()
          ->finishLegend()
        ->finishPalette()
      ->createPalette('type_one')
        ->createPropertyValueCondition('type', 'type_one')
        ->createLegend('title')
          ->createProperty('type', 'title')
            ->finishProperty()
          ->finishLegend()
        ->createLegend('experts')
          ->createProperty('expert_option')
            ->finishProperty()
          ->finishLegend()
        ->createLegend('published')
          ->createProperty('published')
            ->finishProperty()
          ->createProperty('start', 'stop')
            ->createPropertyValueCondition('published', true)
              ->finishCondition()
            ->finishProperty()
          ->finishLegend()
        ->finishPalette()
      ->finishPaletteCollection($collection);

Using the build simplify the palette creation a lot. And can be more simplified by simply omitt the ``finishPalette()``, ``finishLegend()``, ``finishProperty()`` and ``finishCondition()`` calls. The ``finish*`` methods are only required in two situations. First if you need to "close" the current element to make sure the next call will be affect the previous element (this is required for ``create*Condition`` which can affect palettes or properties. And second if you want to "fetch" the build element, in the example this is done by ``finishPaletteCollection($collection)``. All ``finish*()`` methods "return" the created element by reference back into the parameter.

**Hint**: The ``createProperty`` method is a little special, because it accept multiple property names. If you pass multiple property names, they will be considered as a set of properties. All following calls will affect the complete set, not only the last property. This is useful if you need to add the same condition to multiple fields, like the ``start`` and ``stop`` properties in the example above.

Parser
------

Parsers are used to create palettes from other data formats than PHP.

**TODO** *there are currently no parsers exists, this chapter will be completed if there are any parsers*
