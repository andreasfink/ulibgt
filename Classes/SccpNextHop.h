//
//  SccpNextHop.h
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.
#if 0
#import <ulib/ulib.h>
#import <ulibmtp3/ulibmtp3.h>

@class SccpL3Provider;

/* this identifies the next hop of a SCCP message */
@interface SccpNextHop : UMObject
{
    BOOL            sendToSubsystem;    /* send it to internal subsystem */
    int             ssn;                /* which subsystem number to use */
    int             priority;           /* priority group 0...7 of this route */
    int             weight;             /* weight of this route */
    UMMTP3PointCode *opc;
    UMMTP3PointCode *dpc;
    int             ntt;                /* new translation type to use outbound, -1 for unchanged */
    NSString        *l3provider;        /* which MTP3 or M3UA instance to send it to */
    SccpL3Provider  *provider;
    NSString        *name;
}

@property(readwrite,assign) BOOL    sendToSubsystem;
@property(readwrite,assign) int     ssn;
@property(readwrite,assign) int     priority;
@property(readwrite,assign) int     weight;
@property(readwrite,strong) NSString *l3provider;
@property(readwrite,strong) UMMTP3PointCode *opc;
@property(readwrite,strong) UMMTP3PointCode *dpc;
@property(readwrite,strong) SccpL3Provider  *provider;
@property(readwrite,assign) int      ntt;
@property(readwrite,strong) NSString *name;


- (BOOL)isAvailable;
- (double)currentLoad;
- (BOOL)isGroup;
- (SccpNextHop *)pickHopUsingProviders:(UMSynchronizedDictionary *)allProviders;

@end
#endif

