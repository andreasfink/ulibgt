//
//  SccpDestination.h
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
- (SccpDestinationGroup *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant;
- (UMMTP3PointCode *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
@end
