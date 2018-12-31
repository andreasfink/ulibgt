//
//  SccpDestination.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulibmtp3/ulibmtp3.h>
@class UMMTP3PointCode;
@class UMLayerSCCP;
@class SccpL3RoutingTableEntry;
@class SccpL3RoutingTable;

@interface SccpDestination : UMObject
{
    NSString        *_name;
    NSString        *_destination;
    /* one of these should be set but only one */
    NSNumber        *_ssn;              /* send to internal subsystem. 0 if subsystem is 'any'    */
    UMMTP3PointCode *_dpc;              /* send to pointcode                */
    NSString        *_m3uaAs;           /* send to m3ua application servber */
    NSNumber        *_priority;          /* priority group 0...7 of this route */
    NSNumber        *_weight;            /* weight of this route used for load distribution among equal priority entries */
    NSNumber        *_ntt;              /* send to internal subsystem. 0 if subsystem is 'any'    */
    NSString        *_addPrefix;           /* send to m3ua application servber */

}

@property(readwrite,strong,atomic)  NSString        *name;
@property(readwrite,strong,atomic)  NSString        *destination;
@property(readwrite,strong,atomic)  NSNumber        *ssn;
@property(readwrite,strong,atomic)  UMMTP3PointCode *dpc;
@property(readwrite,strong,atomic)  NSString        *m3uaAs;
@property(readwrite,strong,atomic)  NSNumber        *priority;
@property(readwrite,strong,atomic)  NSNumber        *weight;
@property(readwrite,strong,atomic)  NSNumber        *ntt;
@property(readwrite,strong,atomic)  NSString        *addPrefix;

- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (SccpDestination *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant;
- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant;
- (NSString *)description;
- (UMSynchronizedSortedDictionary *)statusDict;

@end
