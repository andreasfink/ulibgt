//
//  SccpDestination.m
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpDestination.h"
#import "SccpDestinationGroup.h"
#import "SccpL3RoutingTable.h"
#import <ulibmtp3/ulibmtp3.h>
#import "SccpL3RouteStatus.h"

@implementation SccpDestination

- (SccpDestination *)init
{
    self = [super init];
    if(self)
    {
        _priority = 4;
        _weight   = 100;
    }
    return self;
}

- (SccpDestination *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant
{
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]];
    if(array.count==0)
    {
        return NULL;
    }
    else if(array.count==1)
    {
        self = [super init];
        if(self)
        {
            _priority = 4;
            _weight   = 100;
            _dpc = [[UMMTP3PointCode alloc]initWithString:array[0] variant:variant];
        }
        return self;
    }
    else
    {
        return [[SccpDestinationGroup alloc]initWithDpcString:string variant:variant];
    }
}

- (UMMTP3PointCode *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt
{
    SccpL3RouteStatus status = [rt getStatusForPointCode:self.dpc];
    if(status==SccpL3RouteStatus_unavailable)
    {
        return NULL;
    }
    return self.dpc;
}

@end
