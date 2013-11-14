Bootstrapping and initialisation process
========================================

Nearly the complete bootstrapping and initialisation process is fully event driven.
The process can be split into four phases, which will be described here.

Creation process
----------------

The :class:`DcGeneral\\Factory\\DcGeneralFactoryInterface <DcGeneral\\Factory\\DcGeneralFactoryInterface>` factory and it's default implementation :class:`DcGeneral\\Factory\\DcGeneralFactory <DcGeneral\\Factory\\DcGeneralFactory>` start the creation process. When the :method:`DcGeneral\\Factory\\DcGeneralFactory::createDcGeneral()` method is called, it