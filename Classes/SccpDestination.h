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
@class SccpSubSystemNumber;

@interface SccpDestination : UMObject
{
    NSString        *_name;
    NSString        *_destination;
    /* one of these should be set but only one */
    SccpSubSystemNumber *_ssn;              /* send to internal subsystem. 0 if subsystem is 'any'    */
    UMMTP3PointCode *_dpc;              /* send to pointcode                */
    NSString        *_m3uaAs;           /* send to m3ua application servber */
    NSNumber        *_cost;             /* cost 1...64 of this route */
    NSNumber        *_weight;           /* weight of this route used for load distribution among equal priority entries */
    NSNumber        *_ntt;              /* new translation type   */
    NSNumber        *_callingNtt;       /* set new translation type on calling address   */
    NSString        *_addPrefix;
    NSNumber        *_allowConversion;  /* allow XUDT to UDT or vice versa conversion */
    UMLayerMTP3     *_mtp3;
    NSString        *_mtp3InstanceName;
    BOOL            _usePcssn;
    NSNumber        *_setGti;
    NSNumber        *_setNpi;
    NSNumber        *_setNai;
    NSNumber        *_setEncoding;
    NSNumber        *_setNational;
    NSNumber        *_ansiToItuConversion;
    NSNumber        *_ituToAnsiConversion;
}

@property(readwrite,strong,atomic)  NSString        *name;
@property(readwrite,strong,atomic)  NSString        *destination;
@property(readwrite,strong,atomic)  SccpSubSystemNumber *ssn;
@property(readwrite,strong,atomic)  UMMTP3PointCode *dpc;
@property(readwrite,strong,atomic)  NSString        *m3uaAs;
@property(readwrite,strong,atomic)  NSNumber        *cost;
@property(readwrite,strong,atomic)  NSNumber        *weight;
@property(readwrite,strong,atomic)  NSNumber        *ntt;
@property(readwrite,strong,atomic)  NSNumber        *callingNtt;
@property(readwrite,strong,atomic)  NSString        *addPrefix;
@property(readwrite,strong,atomic)  NSNumber        *allowConversion;
@property(readwrite,assign,atomic)  BOOL            usePcssn;
@property(readwrite,strong,atomic)  UMLayerMTP3     *mtp3;
@property(readwrite,strong,atomic)  NSString        *mtp3InstanceName;
@property(readwrite,strong,atomic)  NSNumber        *setGti;
@property(readwrite,strong,atomic)  NSNumber        *setNpi;
@property(readwrite,strong,atomic)  NSNumber        *setNai;
@property(readwrite,strong,atomic)  NSNumber        *setNational;
@property(readwrite,strong,atomic)  NSString        *conversion;
@property(readwrite,strong,atomic)  NSNumber        *ansiToItuConversion;
@property(readwrite,strong,atomic)  NSNumber        *ituToAnsiConversion;


- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (SccpDestination *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant;
- (SccpDestination *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant mtp3Instances:(UMSynchronizedDictionary *)dict;
- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant;
- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant mtp3Instances:(UMSynchronizedDictionary *)mtp3_instances;

- (NSString *)description;
- (UMSynchronizedSortedDictionary *)statusDict;

@end
