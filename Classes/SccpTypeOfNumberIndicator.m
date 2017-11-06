//
//  SccpTypeOfNumberIndicator.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpTypeOfNumberIndicator.h"

@implementation SccpTypeOfNumberIndicator

@synthesize ton;

- (SccpTypeOfNumberIndicator *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        ton = i;
    }
    return self;
}

- (NSString *)description
{
    NSString *str = @"";
    switch (ton)
    {
        case SCCP_TON_UNKNOWN:
            str = @"UNKNOWN";
            break;
        case SCCP_TON_INTERNATIONAL:
            str = @"INTERNATIONAL";
            break;
        case SCCP_TON_NATIONAL:
            str = @"NATIONAL";
            break;
        case SCCP_TON_NETWORK_SPECIFIC:
            str = @"NETWORK_SPECIFIC";
            break;
        case SCCP_TON_SUBSCRIBER:
            str = @"SUBSCRIBER";
            break;
        case SCCP_TON_ALPHANUMERIC:
            str = @"ALPHANUMERIC";
            break;
        case SCCP_TON_ABBREVIATED:
            str = @"ABBREVIATED";
            break;
        case SCCP_TON_RESERVED:
            str = @"RESERVED";
            break;
        case SCCP_TON_IMSI:
            str = @"IMSI";
            break;
        case SCCP_TON_URL:
            str = @"URL";
            break;
        case SCCP_TON_EMAIL:
            str = @"EMAIL";
            break;
        case SCCP_TON_POINTCODE:
            str = @"POINTCODE";
            break;
        case SCCP_TON_EMPTY:
            str = @"EMPTY";
            break;
        case SCCP_TON_MISSING:
            str = @"MISSING";
            break;
        default:
            return [NSString stringWithFormat:@"TON_%d",ton];
    }
    return [NSString stringWithFormat:@"TON_%@",str];
}


- (SccpTypeOfNumberIndicator *)copyWithZone:(NSZone *)zone
{
    return [[SccpTypeOfNumberIndicator allocWithZone:zone]initWithInt:ton];
}
@end
