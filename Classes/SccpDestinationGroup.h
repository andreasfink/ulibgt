//
//  SccpDestinationGroup.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulibmtp3/ulibmtp3.h>
#import "SccpDestination.h"
#import "SccpL3RoutingTable.h"

typedef enum SccpDestinationGroupDistributionMethod
{
    SccpDestinationGroupDistributionMethod_cost = 0,    /* equal distribution on lowest cost entries */
    SccpDestinationGroupDistributionMethod_share = 1,   /* equal distribution on all entries */
    SccpDestinationGroupDistributionMethod_wrr = 2,     /* weighted distribution on lowest cost entries */
    SccpDestinationGroupDistributionMethod_cgpa = 3,    /* not implemented yet */
} SccpDestinationGroupDistributionMethod;

@interface SccpDestinationGroup : UMObject
{
    NSString *_name;
    UMSynchronizedArray *_entries;
    SccpDestinationGroupDistributionMethod _distributionMethod;
    BOOL _class1LoadBalance;
    BOOL _distributeSccpSequencedNegate;
    NSString *_dpcInstance;
    int _lastIndex;
}

@property(readwrite,strong,atomic)  NSString *name;
@property(readwrite,assign,atomic)  SccpDestinationGroupDistributionMethod distributionMethod;
@property(readwrite,assign,atomic)  BOOL class1LoadBalance;
@property(readwrite,assign,atomic)  BOOL distributeSccpSequencedNegate;
@property(readwrite,strong,atomic)  NSString *dpcInstance;

- (void)addEntry:(SccpDestination *)dst;
- (SccpDestination *)entryAtIndex:(int)idx;

//- (SccpDestinationGroup *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant;
- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (void)setConfig:(NSDictionary *)cfg applicationContext:(id)appContext;
- (SccpDestination *)pickRandom;
- (UMSynchronizedSortedDictionary *)status;
- (UMSynchronizedSortedDictionary *)statusForL3RoutingTable:(SccpL3RoutingTable *)rt;

@end
