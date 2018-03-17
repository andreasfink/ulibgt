ulibgt helps to do routing of SCCP messages and defines
some basic objects used by ulibsccp. It is independent of ulibsccp
so it can be used for non active processing such as in a tracefile analayzer
or config tool which does not have any active links.


The GT routing logic is as following


1. on a incoming MTP3 linkset, a SCCP message comes in.
The linkset can add a translation type mapping using a SccpTTMap object

2. The message is routed to the SCCP layer which then calls a SccpGttRegistry
object to route the SCCP message.

3. The SccpGttRegistry then goes through its list of selctors and choose the
matching one for the tt and number types.

4. A number translation table for premodification might be called to mangle
with the numbers before processing


5. The SccpGttSelector is holding a SccpGttRoutingTable which is a digit tree
it will walk through digit by digit. Every entry is a SccpGttRoutingTableEntry
object and can have an route attached.

6. An route then maps to a SccpDestination which can point to a m3ua application server or a mtp3 pointcode.

7. A SccpDestination specifies where to forward the message next.
A SccpDestinationGroup is basically a list of SccpDestination objects
with priorities


8. A post number modification is being applied if specified.

9 Once the next hop is clear, it will be forwarded to that next hop and another
SccpTTMap on the outbound link might be applied.
