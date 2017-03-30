//
//  SccpRoutingTable.h
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>

/* a GTT Selector is basically a SCCP routing table */

@class SccpApplicationGroup;
@class SccpNextHop;
@class SccpL3Provider;
@class SccpGttRoutingTable;

@interface SccpGttSelector : UMObject
{
    NSString        *_sccp_instance;
    int             _tt;
    int             _gti;
    int             _np;
    int             _nai;
    int             _external;
    int             _internal;
    SccpGttRoutingTable *_routingTable;
    SccpNextHop     *_defaultEntry;
    NSDictionary    *_statusOfProviders;
}

@property(readwrite,strong,atomic) NSString        *sccp_instance;

@property(readwrite,strong) SccpNextHop *defaultEntry;
-(SccpNextHop *) routeToProvider:(NSString *)digits;

@property(readwrite,strong,atomic)  NSString        *gtt_selector;
@property(readwrite,assign,atomic)  int             tt;
@property(readwrite,assign,atomic)  int             gti;
@property(readwrite,assign,atomic)  int             np;
@property(readwrite,assign,atomic)  int             nai;
@property(readwrite,assign,atomic)  int             external;
@property(readwrite,assign,atomic)  int             internal;
@property(readwrite,strong,atomic)  SccpGttRoutingTable *routingTable;
- (NSString *)selectorKey;
+ (NSString *)selectorKeyForTT:(int)tt gti:(int)gti np:(int)np nai:(int)nai;


- (SccpGttSelector *)initWithInstanceNameE164:(NSString *)name;

@end
