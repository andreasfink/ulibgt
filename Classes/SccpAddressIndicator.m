//
//  SccpAddressIndicator.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpAddressIndicator.h"

@implementation SccpAddressIndicator

@synthesize nationalReservedBit;
@synthesize routingIndicatorBit;
@synthesize globalTitleIndicator;
@synthesize subSystemIndicator;
@synthesize pointCodeIndicator;


- (SccpAddressIndicator *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        [self setAddressIndicator:i];
    }
    return self;
}


#define SETBIT(a,n)    ( a = a | (0x01 << n) )
#define CLEARBIT(a,n)  ( a = a & ~(0x01 << n))
#define GETBIT(a,n)    ( (( a >> n) & 0x01) ? YES : NO )
#define SETBITVALUE(a,n,v)   { if (v) { SETBIT(a,n); } else { CLEARBIT(a,n); } }

#define NATIONAL_RESERVED_BIT   7
#define ROUTING_INDICATOR_BIT   6
#define SUBSYSTEM_INDICATOR_BIT 1 /* these two are swapped in ANSI, we store them in ITU variant */
#define POINTCODE_INDICATOR_BIT 0 /* these two are swapped in ANSI, we store them in ITU variant */


-(int)addressIndicator
{
    if(nationalReservedBit)
    {
        return [self addressIndicatorANSI];
    }
    return [self addressIndicatorITU];
}

- (int)addressIndicatorITU
{
    int i=0;
    if(nationalReservedBit)
    {
        i = i | 0x80;
    }
    if(routingIndicatorBit)
    {
        i = i | 0x40;
    }
    i = i | ((globalTitleIndicator & 0x0F) << 2);
    if(subSystemIndicator)
    {
        i = i | 0x02;
    }
    if(pointCodeIndicator)
    {
        i = i | 0x01;
    }
    return i;
}

- (void)setAddressIndicatorITU:(int)i
{
    if( i & 0x80)
    {
        nationalReservedBit = YES;
    }
    else
    {
        nationalReservedBit = NO;
    }
    if( i & 0x40)
    {
        routingIndicatorBit = YES;
    }
    else
    {
        routingIndicatorBit = NO;
    }
    globalTitleIndicator = (i >> 2) & 0x0F;
    
    if( i & 0x02)
    {
        subSystemIndicator=YES;
    }
    else
    {
        subSystemIndicator=NO;
    }

    if( i & 0x01)
    {
        pointCodeIndicator=YES;
    }
    else
    {
        pointCodeIndicator=NO;
    }
}

- (int)addressIndicatorANSI
{
    int i=0;
    if(nationalReservedBit)
    {
        i = i | 0x80;
    }
    if(routingIndicatorBit)
    {
        i = i | 0x40;
    }
    i = i | ((globalTitleIndicator & 0x0F) << 2);
    if(pointCodeIndicator)
    {
        i = i | 0x02;
    }
    if(subSystemIndicator)
    {
        i = i | 0x01;
    }
    return i;
}


- (void)setAddressIndicator:(int)i
{
    if(GETBIT(i,NATIONAL_RESERVED_BIT))
    {
        [self setAddressIndicatorANSI:i];
    }
    else
    {
        [self setAddressIndicatorITU:i];
    }
}

- (void)setAddressIndicatorANSI:(int)i
{
    if( i & 0x80)
    {
        nationalReservedBit = YES;
    }
    else
    {
        nationalReservedBit = NO;
    }
    if( i & 0x40)
    {
        routingIndicatorBit = YES;
    }
    else
    {
        routingIndicatorBit = NO;
    }
    globalTitleIndicator = (i >> 2) & 0x0F;
    
    if( i & 0x02)
    {
        pointCodeIndicator=YES;
    }
    else
    {
        pointCodeIndicator=NO;
    }
    if( i & 0x01)
    {
        subSystemIndicator=YES;
    }
    else
    {
        subSystemIndicator=NO;
    }
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"national-reserved-bit"] = @(nationalReservedBit);
    dict[@"routing-indicator-bit"] = @(routingIndicatorBit);
    dict[@"global-title-indicator"] = @(globalTitleIndicator);
    dict[@"sub-system-indicator"] = @(subSystemIndicator);
    dict[@"point-code-indicator"] = @(pointCodeIndicator);
    return dict;
}

- (NSString *)debugDescription
{
    NSMutableString *s = [[NSMutableString alloc]init];
    if(nationalReservedBit)
    {
        [s appendFormat:@"%d\n",[self addressIndicatorANSI]];
    }
    else
    {
        [s appendFormat:@"%d\n",[self addressIndicatorITU]];
    }
    [s appendFormat:@"     national-reserved-bit=%d\r\n",(nationalReservedBit ? 1 : 0)];
    [s appendFormat:@"     routing-indicator-bit=%d\r\n",(routingIndicatorBit ? 1 : 0)];
    [s appendFormat:@"     global-title-indicator=%d\r\n",(globalTitleIndicator ? 1 : 0)];
    [s appendFormat:@"     sub-system-indicator=%d\r\n",(subSystemIndicator ? 1 : 0)];
    [s appendFormat:@"     point-code-indicator=%d\r\n",(pointCodeIndicator ? 1 : 0)];
    return s;
}

- (SccpAddressIndicator *)copyWithZone:(NSZone *)zone
{
    return [[SccpAddressIndicator allocWithZone:zone]initWithInt:self.addressIndicator];
}


@end
