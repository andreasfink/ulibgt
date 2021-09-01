//
//  SccpGttRoutingTableEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

@class SccpGttRoutingTableAction;
@class SccpDestinationGroup;
@class SccpNumberTranslation;
@class SccpL3RoutingTable;

@interface SccpGttRoutingTableEntry : UMObject
{
    BOOL                    _hasSubentries;
    NSArray                 *_subentries;
    NSString                *_name;
    NSString                *_table;
    NSString                *_digits;
    SccpDestinationGroup    *_routeTo;
    NSString                *_routeToName;
    BOOL                    _deliverLocal;
    NSString                *_postTranslationName;
    SccpNumberTranslation   *_postTranslation;
	UMThroughputCounter     *_incomingSpeed;
    BOOL                    _enabled;
    UMLogLevel              _logLevel;
    NSNumber                *_tcapTransactionRangeStart;
    NSNumber                *_tcapTransactionRangeEnd;
    NSArray<NSNumber *>     *_calledSSNs;
    NSArray<NSNumber *>     *_calledOpcodes;
    NSArray<NSString *>     *_appContexts;
}

@property(readwrite,atomic,assign)  BOOL                    hasSubentries;
@property(readwrite,atomic,strong)  NSArray                 *subentries;
@property(readwrite,atomic,strong)  NSString                *name;
@property(readwrite,atomic,strong)  NSString                *table;
@property(readwrite,atomic,assign)  BOOL                    deliverLocal;

@property(readwrite,atomic,strong)  NSString *digits;
@property(readwrite,atomic,strong)  SccpDestinationGroup    *routeTo;
@property(readwrite,atomic,strong)  NSString                *routeToName;
@property(readwrite,atomic,strong)  NSString    *postTranslationName;
@property(readwrite,atomic,strong)  SccpNumberTranslation *postTranslation;
@property(readwrite,atomic,strong)  UMThroughputCounter *incomingSpeed;
@property(readwrite,atomic,assign)  BOOL        enabled;
@property(readwrite,atomic,assign)  UMLogLevel  logLevel;
@property(readwrite,atomic,strong)  NSNumber  *tcapTransactionRangeStart;
@property(readwrite,atomic,strong)  NSNumber  *tcapTransactionRangeEnd;
@property(readwrite,atomic,strong) NSArray<NSNumber *>     *calledSSNs;
@property(readwrite,atomic,strong) NSArray<NSNumber *>     *calledOpcodes;
@property(readwrite,atomic,strong) NSArray<NSString *>     *appContext;

- (SccpGttRoutingTableEntry *)initWithConfig:(NSDictionary *)cfg;
- (UMSynchronizedSortedDictionary *)config;
- (NSString *)getStatistics;
- (UMSynchronizedSortedDictionary *)status;
- (UMSynchronizedSortedDictionary *)statusForL3RoutingTable:(SccpL3RoutingTable *)rt;
+ (NSString *)entryNameForGta:(NSString *)gta tableName:(NSString *)tableName;
- (SccpGttRoutingTableEntry *)findSubentryByTransactionNumber:(NSNumber *)tid
                                                          ssn:(NSNumber *)ssn
                                                       opcode:(NSNumber *)op
                                                   appcontext:(NSString *)ac;
- (void)addSubentry:(SccpGttRoutingTableEntry *)subentry;
- (BOOL) matchingTransactionNumber:(NSNumber *)tid;

@end

