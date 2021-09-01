//
//  SccpGttSelector.h
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

@class SccpGttRoutingTable;
@class SccpDestination;
@class SccpL3RoutingTable;
@class SccpNumberTranslation;
@class SccpAddress;
@class SccpDestinationGroup;
@class SccpGttRoutingTableEntry;


@interface SccpGttSelector : UMObject
{
    NSString                *_name;
    NSString                *_sccp_instance;
    int                     _tt;
    int                     _gti;
    int                     _np;
    int                     _nai;
    int                     _external;
    int                     _internal;
    SccpGttRoutingTable     *_routingTable;
    NSDictionary            *_statusOfProviders;
    NSString                *_preTranslationName;
    NSString                *_postTranslationName;
    SccpNumberTranslation   *_preTranslation;
    SccpNumberTranslation   *_postTranslation;
	BOOL 		  	        _active;
    UMLogLevel              _logLevel;
}

@property(readwrite,strong,atomic) NSString               *name;
@property(readwrite,strong,atomic) NSString               *sccp_instance;
@property(readwrite,strong,atomic)  NSString              *preTranslationName;
@property(readwrite,strong,atomic)  NSString              *postTranslationName;
@property(readwrite,strong,atomic)  SccpNumberTranslation *preTranslation;
@property(readwrite,strong,atomic)  SccpNumberTranslation *postTranslation;
@property(readwrite,strong,atomic) id getSCCPDestinationDelegate;


- (SccpGttRoutingTableEntry *)findNextHopForDestination:(SccpAddress *)dst
                                      transactionNumber:(NSNumber *)tid
                                                    ssn:(NSNumber *)ssn
                                              operation:(NSNumber *)op
                                             appContext:(NSString *)ac;

- (SccpGttRoutingTableEntry *)chooseNextHopWithL3RoutingTable:(SccpL3RoutingTable *)rt
                                                  destination:(SccpAddress **)dst
                                              incomingLinkset:(NSString *)incomingLinkset
                                            transactionNumber:(NSNumber *)tid
                                                    operation:(NSNumber *)op
                                                   appContext:(NSString *)ac;

@property(readwrite,strong,atomic)  NSString        *gtt_selector;
@property(readwrite,assign,atomic)  int             tt;
@property(readwrite,assign,atomic)  int             gti;
@property(readwrite,assign,atomic)  int             np;
@property(readwrite,assign,atomic)  int             nai;
@property(readwrite,assign,atomic)  int             external;
@property(readwrite,assign,atomic)  int             internal;
@property(readwrite,strong,atomic)  SccpGttRoutingTable *routingTable;
@property(readwrite,assign,atomic)  BOOL            active;
@property(readwrite,assign,atomic)  UMLogLevel      logLevel;


- (NSString *)selectorKey;
+ (NSString *)selectorKeyForTT:(int)tt gti:(int)gti np:(int)np nai:(int)nai;

- (SccpGttSelector *)initWithInstanceName:(NSString *)name;
- (SccpGttSelector *)initWithInstanceNameE164:(NSString *)name;
- (SccpGttSelector *)initWithConfig:(NSDictionary *)config;

- (UMSynchronizedSortedDictionary *)config;

- (UMSynchronizedSortedDictionary *)statisticalInfo;

- (void)activate:(BOOL)on;

@end
