//
//  SccpL3RoutingTableEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 19.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpL3RoutingTableEntry.h"


@implementation SccpL3RoutingTableEntry


- (UMSynchronizedSortedDictionary *)statusDict
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"point-code"] = [_pc stringValue];
    switch(_status)
    {
        case SccpL3RouteStatus_unknown:
            dict[@"status"] = @"unknown";
            break;
        case SccpL3RouteStatus_available:
            dict[@"status"] = @"available";
            break;
        case SccpL3RouteStatus_restricted:
            dict[@"status"] = @"restricted";
            break;
        case SccpL3RouteStatus_unavailable:
            dict[@"status"] = @"unavailable";
            break;
        default:
            dict[@"status"] = @(_status);
    }
    return dict;
}


@end
