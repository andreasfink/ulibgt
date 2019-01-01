//
//  SccpL3RoutingTable.h
//  ulibgt
//
//  Created by Andreas Fink on 19.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulibmtp3/ulibmtp3.h>
#import "SccpL3RouteStatus.h"
@class SccpL3RoutingTableEntry;

@interface SccpL3RoutingTable : UMObject
{
    UMSynchronizedDictionary *_entries;
}

- (SccpL3RoutingTableEntry *)getEntryForPointCode:(UMMTP3PointCode *)pointCode;
- (void)setStatus:(SccpL3RouteStatus) status forPointCode:(UMMTP3PointCode *)pointCode;
- (SccpL3RouteStatus )getStatusForPointCode:(UMMTP3PointCode *)pointCode;
- (UMSynchronizedSortedDictionary *)status;

@end
