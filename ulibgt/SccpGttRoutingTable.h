//
//  SccpGttRoutingTable.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.2017
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>
#import <ulibdb/ulibdb.h>
#import <ulibgt/SccpGttRoutingTableEntry.h>
#import <ulibgt/SccpGttRoutingTableDigitNode.h>

/* 
 Entries are stored twice. Once by number in a dictionary so its easy to print and read from a file.
 Secondly in a optimized digit tree for faster processing
*/

@interface SccpGttRoutingTable : UMObject
{
    UMLogLevel                      _logLevel;
    UMSynchronizedSortedDictionary *_entries;
    SccpGttRoutingTableDigitNode   *_rootNode;
    NSString                       *_name;
}


@property(readwrite,strong,atomic) SccpGttRoutingTableDigitNode   *rootNode;
@property(readwrite,assign,atomic) UMLogLevel                     logLevel;

- (SccpGttRoutingTable *)initWithName:(NSString *)name;
- (void)entriesToDigitTree;

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
                              transactionNumber:(NSNumber *)tid
                                            ssn:(NSNumber *)ssn
                                      operation:(NSNumber *)op
                                     appContext:(NSString *)ac;

- (SccpGttRoutingTableEntry *)findEntryByName:(NSString *)name;
//- (void)deleteEntryByName:(NSString *)name;
//- (void)deleteEntryByDigits:(NSString *)digits;


- (void)addEntry:(SccpGttRoutingTableEntry *)entry;

-(UMSynchronizedSortedDictionary *)list;

+ (UMDbTableDefinition *)routingTableDbDefinition;
@end
