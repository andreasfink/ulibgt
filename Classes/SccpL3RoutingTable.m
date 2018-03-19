//
//  SccpL3RoutingTable.m
//  ulibgt
//
//  Created by Andreas Fink on 19.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpL3RoutingTable.h"
#import "SccpL3RoutingTableEntry.h"

@implementation SccpL3RoutingTable

- (id)init
{
    self = [super init];
    if(self)
    {
        _entries =[[UMSynchronizedDictionary alloc]init];
    }
    return self;
}
- (void)setStatus:(SccpL3RouteStatus) status forPointCode:(UMMTP3PointCode *)pointCode
{
    SccpL3RoutingTableEntry *entry = _entries[pointCode.stringValue];
    if(entry==NULL)
    {
        entry = [[SccpL3RoutingTableEntry alloc]init];
        entry.pc = pointCode;
    }
    entry.status = status;
}

- (SccpL3RouteStatus )getStatusForPointCode:(UMMTP3PointCode *)pointCode
{
    SccpL3RoutingTableEntry *entry = _entries[pointCode.stringValue];
    if(entry==NULL)
    {
        entry = [[SccpL3RoutingTableEntry alloc]init];
        entry.pc = pointCode;
        entry.status = SccpL3RouteStatus_available;
    }
    return entry.status;
}

@end
