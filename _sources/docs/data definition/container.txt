Container
=========

The container is the reflection of the data definition configuration.
It is split into configuration sections. Each section is a small couple of configuration options, that belongs to each other.

For example, the `Basic section`_ contains basic container settings like the mode and data provider names.
The `Legacy view section`_ contains all view settings related to the old dca format that is used in Contao.

Each DcGeneral instance can only handle one data definition container.

.. toctree::
   :glob:

   container/*

Bootstrap and building process
------------------------------

The container is created when the DcGeneral get created through the ``DcGeneralFactory``.
In the create event processing, multiple builders get triggered and fill the container with the sections.
Different to Contao, the data definition must not defined in a DCA. The definition source depends on the builder.
For example MetaModels use a custom builder, that fill the container directly from the database.

Default sections
----------------

You find the default section interfaces and implementations in the :namespace:`DcGeneral\\DataDefinition\\Section` namespace.

Basic section
~~~~~~~~~~~~~

The `Basic section <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Section/BasicSectionInterface.php>`_
contains the basic general configuration of the container.

Data provider section
~~~~~~~~~~~~~~~~~~~~~

The `Data provider section <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Section/DataProviderSectionInterface.php>`_
contains the data provider configuration of the container.

Legacy view section
~~~~~~~~~~~~~~~~~~~

The `Legacy view section <https://github.com/MetaModels/DC_General/tree/master/system/modules/generalDriver/DcGeneral/DataDefinition/Section/LegacyViewSectionInterface.php>`_
contains the view configuration of the container, provided by the *old* dca format.
