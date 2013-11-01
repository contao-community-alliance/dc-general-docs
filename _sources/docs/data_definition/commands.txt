Commands (fka Operations)
=========================

In Contao 2 and Contao 3 operations are normal buttons with a url.
In DcGeneral, operations are more like `commands <http://en.wikipedia.org/wiki/Command_pattern>`_.

If a command is triggered by user action in the view, the command will be dispatched as :class:`DcGeneral\\Event\\CommandEvent` on the server side.
Each listener must now decide what he need to do on the command.
If a listener handle the event, he might stop it's propagation.

Here is an extreme simplified pseudo example of the default item edit listener.

.. code-block:: php

   function defaultItemEditHandler(DcGeneral\Event\ItemCommandEvent $event) {
       $model       = $event->getItem();
       $view        = $event->getEnvironment()->getView();

       $view->redirect('contao/main.php?act=edit&id=' . $model->getId());
       $event->stopPropagation();
   }

See :class:`DcGeneral\\Event\\CommandEvent` and all of it's sub-classes for reference about command events.

Predefinition
-------------

The priority of default command listeners, that handle the default behaviour is **0**.
If you want to overwrite the default behaviour, register your listener with a priority greater than **0**.
If you want to post process the default behaviour (keep in mind that some commands stop event propagation), register your listener with a priority smaller than **0**.

Scopes
------

.. _container-scoped-commands:

Container scope
~~~~~~~~~~~~~~~

Container scoped commands are related to the data definition container and do some action on it.

Event: :class:`DcGeneral\\Event\\CommandEvent <DcGeneral\\Event\\CommandEvent>`

.. _model-scoped-commands:

Model scope
~~~~~~~~~~~

Model scoped commands are related to a model and do some action on it.

Event: :class:`DcGeneral\\Event\\ModelCommandEvent <DcGeneral\\Event\\ModelCommandEvent>`

Indexed command events
----------------------

Command events are indexed with the container name or with command name or with container name and command name.
The event name will be ``dc-general.command[<container name>]``, ``dc-general.command[<command name>]`` or ``dc-general.command[<container name>][<command name>]``,
e.g. ``dc-general.command[tl_example]``, ``dc-general.command[edit]`` and ``dc-general.command[tl_example][edit]``.

Read more about indexed events in the :doc:`../events` chapter.

Examples
--------

listen on edit command event on tl_example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php

   $GLOBALS['TL_EVENTS'][DcGeneral\Event\CommandEvent::NAME][] = function(DcGeneral\Event\CommandEvent $event) {
       if ($event->getName() == 'edit') {
           $environment = $event->getEnvironment();
           $container   = $environment->getDataDefinition();
           if ($container->getName() == 'tl_example') {
               ...
           }
       }
   }

listen on indexed edit command event on tl_example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php

   $GLOBALS['TL_EVENTS'][DcGeneral\Event\Command::NAME . '[tl_example][edit]'][] = function(DcGeneral\Event\CommandEvent $event) {
       // the name check is not needed anymore
       $environment = $event->getEnvironment();
       $container   = $environment->getDataDefinition();
       // the container name check is not needed anymore
       ...
   }

listen on all indexed command events for tl_example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php

   $GLOBALS['TL_EVENTS'][DcGeneral\Event\Command::NAME . '[tl_example]'][] = function(DcGeneral\Event\CommandEvent $event) {
       // if necessary, do a command name check here
       $environment = $event->getEnvironment();
       $container   = $environment->getDataDefinition();
       // the container name check is not needed anymore
       ...
   }

listen on all indexed edit command events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php

   $GLOBALS['TL_EVENTS'][DcGeneral\Event\Command::NAME . '[edit]'][] = function(DcGeneral\Event\CommandEvent $event) {
       // the name check is not needed anymore
       $environment = $event->getEnvironment();
       $container   = $environment->getDataDefinition();
       // if necessary, do a container name check here
       ...
   }
