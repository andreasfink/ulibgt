//
//  SccpNextHop.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#if 0

#import "SccpNextHop.h"
#import "SccpL3Provider.h"

@implementation SccpNextHop


@synthesize sendToSubsystem;
@synthesize ssn;
@synthesize priority;
@synthesize weight;
@synthesize l3provider;
@synthesize opc;
@synthesize dpc;
@synthesize ntt;
@synthesize provider;
@synthesize name;

-(SccpNextHop *)init
{
    self = [super init];
    if(self)
    {
        priority = 4;
        weight = 100;
    }
    return self;
}

- (BOOL)isAvailable
{
    return YES;
}

- (double)currentLoad
{
    return 1.0;
}

- (BOOL)isGroup
{
    return NO;
}

- (SccpNextHop *)pickHopUsingProviders:(UMSynchronizedDictionary *)allProviders
{
    NSArray *keys = [allProviders allKeys];
    for(NSString *providerName in keys)
    {
        SccpL3Provider *prov = allProviders[providerName];
        if([prov isAvailable])
        {
            if([prov dpcIsAvailable:dpc])
            {
                return self;
            }
        }
    }
    return NULL;
}

@end
#endif

