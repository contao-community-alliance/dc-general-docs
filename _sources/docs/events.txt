Events
======

TODO

Indexed events
--------------

In addition to the regular event name, some events also dispatched under a named/indexed event name.
That means, the event name is suffixed with an index, embedded in square brackets.

Whenever the regular event name is ``dc-general.event-name``, the indexed event name is ``dc-general.event-name[index]``.
The index value depends on the event type.

For example every :class:`DcGeneral\\Event\\CommandEvent` is dispatched with the regular event name ``dc-general.command``
**and** the indexed event name ``dc-general.command[name]`` where *name* is the command name.
