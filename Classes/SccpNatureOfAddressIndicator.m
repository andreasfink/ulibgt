//
//  SccpNatureOfAddressIndicator.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpNatureOfAddressIndicator.h"

@implementation SccpNatureOfAddressIndicator
@synthesize nai;

- (SccpNatureOfAddressIndicator *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        nai = i;
    }
    return self;
}

- (NSString *)description
{
    NSString *str = @"";
    switch (nai)
    {
        case SCCP_NAI_UNKNOWN:
            str = @"UNKNOWN";
            break;
        case SCCP_NAI_SUBSCRIBER:
            str = @"SUBSCRIBER";
            break;
        case SCCP_NAI_RESERVED:
            str = @"RESERVED";
            break;
        case SCCP_NAI_NATIONAL:
            str = @"NATIONAL";
            break;
        case SCCP_NAI_INTERNATIONAL:
            str = @"INTERNATIONAL";
            break;
        case SCCP_NAI_POINTCODE:
            str = @"POINTCODE";
            break;
        case SCCP_NAI_EMPTY:
            str = @"EMPTY";
            break;
        case SCCP_NAI_MISSING:
            str = @"MISSING";
            break;
        default:
            return [NSString stringWithFormat:@"NAI_%d",nai];
    }
    return [NSString stringWithFormat:@"NAI_%@",str];
}
@end
