Events
======

The PaletteBuilder dispatch a lot of events for customisation.

Event reference
---------------

SetPaletteCollectionClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPaletteCollectionClassName

Is dispatched when the `PaletteCollection <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteCollectionInterface.php>`_ implementation class name is set.

SetPaletteClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPaletteClassName

Is dispatched when the `Palette <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteInterface.php>`_ implementation class name is set.

SetLegendClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetLegendClassName

Is dispatched when the `Legend <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/LegendInterface.php>`_ implementation class name is set.

SetPropertyClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPropertyClassName

Is dispatched when the `Property <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PropertyInterface.php>`_ implementation class name is set.

SetPaletteConditionChainClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPaletteConditionChainClassName

Is dispatched when the `PaletteConditionChain <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PaletteConditionChain.php>`_ implementation class name is set.

SetDefaultPaletteConditionClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetDefaultPaletteConditionClassName

Is dispatched when the `DefaultPaletteCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/DefaultPaletteCondition.php>`_ implementation class name is set.

SetPalettePropertyValueConditionClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPalettePropertyValueConditionClassName

Is dispatched when the `Palette PropertyValueCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PropertyValueCondition.php>`_ implementation class name is set.

SetPropertyConditionChainClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPropertyConditionChainClassName

Is dispatched when the `PropertyConditionChain <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyConditionChain.php>`_ implementation class name is set.

SetPropertyValueConditionClassNameEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\SetPropertyValueConditionClassName

Is dispatched when the `PropertyValueCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyValueCondition.php>`_ implementation class name is set.

CreatePaletteCollectionEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreatePaletteCollection

Is dispatched when a `PaletteCollection <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteCollectionInterface.php>`_ is created.

FinishPaletteCollectionEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\FinishPaletteCollection

Is dispatched when a `PaletteCollection <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteCollectionInterface.php>`_ is finished.

CreatePaletteEvent
~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreatePalette

Is dispatched when a `Palette <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteInterface.php>`_ is created.

FinishPaletteEvent
~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\FinishPalette

Is dispatched when a `Palette <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PaletteInterface.php>`_ is finished.

CreateLegendEvent
~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreateLegend

Is dispatched when a `Legend <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/LegendInterface.php>`_ is created.

FinishLegendEvent
~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\FinishLegend

Is dispatched when a `Legend <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/LegendInterface.php>`_ is finished.

CreatePropertyEvent
~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreateProperty

Is dispatched when a `Property <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PropertyInterface.php>`_ is created.

FinishPropertyEvent
~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\FinishProperty

Is dispatched when a `Property <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/PropertyInterface.php>`_ is finished.

CreatePaletteConditionChainEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreatePaletteConditionChain

Is dispatched when a `Palette\PaletteConditionChain <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PaletteConditionChain.php>`_ is created.

CreatePropertyConditionChainEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreatePropertyConditionChain

Is dispatched when a `Property\PropertyConditionChain <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyConditionChain.php>`_ is created.

CreateDefaultPaletteConditionEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreateDefaultPaletteCondition

Is dispatched when a `Palette\DefaultPaletteCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/DefaultPaletteCondition.php>`_ is created.

CreatePropertyValueConditionEvent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreatePropertyValueCondition

Is dispatched when a `Palette\PropertyValueCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PalettePropertyValueCondition.php>`_ or `Property\PropertyValueCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyValueCondition.php>`_ is created.

CreateConditionEvent
~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\CreateCondition

Is dispatched when a `Palette\PaletteCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PaletteConditionInterface.php>`_ or `Property\PropertyConditionInterface <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyConditionInterface.php>`_ is created.

FinishConditionEvent
~~~~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\FinishCondition

Is dispatched when a `Palette\PaletteCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PaletteConditionInterface.php>`_ or `Property\PropertyConditionInterface <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyConditionInterface.php>`_ is finished.

AddConditionEvent
~~~~~~~~~~~~~~~~~

::

    DcGeneral\DataDefinition\Palette\Builder\Event\AddCondition

Is dispatched when a `Palette\PaletteCondition <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Palette/PaletteConditionInterface.php>`_ or `Property\PropertyConditionInterface <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Palette/Condition/Property/PropertyConditionInterface.php>`_ is added to a palette or property.
