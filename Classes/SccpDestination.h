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
    /* one of these should be set but only one */
    NSNumber        *_ssn;              /* send to internal subsystem. 0 if subsystem is 'any'    */
    UMMTP3PointCode *_dpc;              /* send to pointcode                */
    NSString        *_m3uaAs;           /* send to m3ua application servber */
    int             _priority;          /* priority group 0...7 of this route */
    int             _weight;            /* weight of this route used for load distribution among equal priority entries */
}

@property(readwrite,strong,atomic)  NSString        *name;
@property(readwrite,strong,atomic)  NSNumber        *ssn;
@property(readwrite,strong,atomic)  UMMTP3PointCode *dpc;
@property(readwrite,strong,atomic)  NSString        *m3uaAs;
@property(readwrite,assign,atomic)  int             priority;
@property(readwrite,assign,atomic)  int             weight;

- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (SccpDestination *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant;
- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant;
- (NSString *)description;

@end
