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

@interface SccpDestinationGroup : SccpDestination
{
    UMSynchronizedArray *_entries;
}

- (void)addEntry:(SccpDestination *)dst;
- (SccpDestination *)entryAtIndex:(int)idx;

- (SccpDestinationGroup *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant;
- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (void)setConfig:(NSDictionary *)cfg applicationContext:(id)appContext;
@end