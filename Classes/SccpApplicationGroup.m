//
//  SccpApplicationGroup.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpApplicationGroup.h"
#import "SccpL3Provider.h"

#include <stdlib.h>


@implementation SccpApplicationGroup

- (SccpApplicationGroup *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[NSMutableArray alloc]init];
        _lock = [[UMMutex alloc]init];
    }
    return self;
}

- (BOOL)isGroup
{
    return YES;
}

-(void)addNextHop:(SccpNextHop *)hop
{
    [_lock lock];
    [_entries addObject:hop];
    [_lock unlock];

}


- (BOOL)isAvailable
{
    BOOL r = NO;
    [_lock lock];
    for(SccpNextHop *e in _entries)
    {
        if(e.isAvailable)
        {
            r = YES;
        }
    }
    [_lock unlock];
    return r;
}

- (SccpNextHop *)pickHopUsingProviders:(UMSynchronizedDictionary *)allProviders
{
    NSMutableArray *useableNextHops[10];
    for(int prio=0;prio<8;prio++)
    {
        useableNextHops[prio] = [[NSMutableArray alloc]init];
    }
    
    [_lock lock];

    @try
    {
        NSArray *keys = [allProviders allKeys];
        for(NSString *providerName in keys)
        {
            SccpL3Provider *prov = allProviders[providerName];
            if([prov isAvailable])
            {
                for(SccpNextHop *nextHop in _entries)
                {
                    if([prov dpcIsAvailable:nextHop.dpc])
                    {
                        int prio = nextHop.priority;
                        [useableNextHops[prio] addObject:nextHop];
                    }
                }
            }
        }
    }
    @finally
    {
        [_lock unlock];
    }
    
    for(int prio=0;prio<8;prio++)
    {
        /* within the priority group, we distribute by weight */
        int totalWeight=0;
        if([useableNextHops[prio] count] == 0)
        {
            continue;
        }
        if([useableNextHops[prio] count] == 1)
        {
            return [useableNextHops[prio] objectAtIndex:0];
        }

        for(SccpNextHop *entry in useableNextHops[prio])
        {
            totalWeight += entry.weight;
        }

        /* we pick a radnom entry out of the list weighted by the weight */

        u_int32_t pick = [UMUtil random:totalWeight];
        totalWeight = 0;
        for(SccpNextHop *entry in useableNextHops[prio])
        {
            totalWeight += entry.weight;
            if(pick <= totalWeight)
            {
                return entry;
            }
        }
    }
    return NULL;
}

@end
