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

- (void)setStatus:(SccpL3RouteStatus)status forPointCode:(UMMTP3PointCode *)pointCode
{
    SccpL3RoutingTableEntry *entry = [self getEntryForPointCode:pointCode];
    entry.status = status;
}

- (SccpL3RouteStatus )getStatusForPointCode:(UMMTP3PointCode *)pointCode
{
    SccpL3RoutingTableEntry *entry = [self getEntryForPointCode:pointCode];
    return entry.status;
}


- (SccpL3RoutingTableEntry *)getEntryForPointCode:(UMMTP3PointCode *)pointCode
{
    SccpL3RoutingTableEntry *entry = _entries[pointCode.stringValue];
    if(entry==NULL)
    {
        entry = [[SccpL3RoutingTableEntry alloc]init];
        entry.pc = pointCode;
        entry.status = SccpL3RouteStatus_available;
        _entries[pointCode.stringValue] = entry;
    }
    return  entry;
}

- (UMSynchronizedSortedDictionary *)status
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];

    NSArray *allKeys = [_entries allKeys];

    for(NSString *key in allKeys)
    {
        SccpL3RoutingTableEntry *entry = _entries[key];
        NSString *pc = entry.pc.stringValue;
        switch(entry.status)
        {
            case SccpL3RouteStatus_available:
                dict[pc] = @"available";
                break;
            case SccpL3RouteStatus_restricted:
                dict[pc] = @"restricted";
                break;
            case SccpL3RouteStatus_unavailable:
                dict[pc] = @"unavailable";
                break;
            default:
                dict[pc] = @"unknown";
                break;
        }
    }
    return dict;
}

@end
