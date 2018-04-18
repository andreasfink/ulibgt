//
//  SccpDestinationGroup.m
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpDestinationGroup.h"
#import "SccpL3RouteStatus.h"
#import "SccpL3RoutingTableEntry.h"

@implementation SccpDestinationGroup
{

}

- (void)addEntry:(SccpDestination *)dst
{
    [_entries addObject:dst];
}

- (SccpDestination *)entryAtIndex:(int)idx
{
    if((idx >=0) && (idx <_entries.count ))
    {
        return [_entries objectAtIndex:idx];
    }
    return NULL;
}

- (SccpDestinationGroup *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant
{
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]];
    if(array.count==0)
    {
        return NULL;
    }

    self = [super init];
    if(self)
    {
        _priority = 4;
        _weight   = 100;
        for(NSString *dpc in array)
        {
            SccpDestination *dst = [[SccpDestination alloc]initWithDpcString:dpc variant:variant];
            if(dst)
            {
                [_entries addObject:dst];
            }
        }
    }
    return self;
}


- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt
{
    NSMutableArray *availEntries = [[NSMutableArray alloc]init];
    NSMutableArray *availAndRestrictedEntries = [[NSMutableArray alloc]init];

    NSArray *entries = [_entries arrayCopy];
    BOOL availSeen = NO;
    BOOL restrictedSeen = NO;

    for(SccpDestination *e in entries)
    {

        SccpL3RoutingTableEntry *rtentry = [rt getEntryForPointCode:e.dpc];
        if(rtentry.status==SccpL3RouteStatus_available)
        {
            availSeen = YES;
            [availEntries addObject:rtentry];
            [availAndRestrictedEntries addObject:e];
        }
        else if(rtentry.status==SccpL3RouteStatus_restricted)
        {
            restrictedSeen = YES;
            [availAndRestrictedEntries addObject:e];
        }
    }
    NSMutableArray *validEntries;
    /* if we have seen available, we only take available entries */
    if(availSeen == YES)
    {
        validEntries = availEntries;
    }
    else if(restrictedSeen == YES)
    {
        validEntries = availAndRestrictedEntries;
    }
    if(validEntries.count==1)
    {
        SccpDestination *e = validEntries[0];
        return e;
    }

    /* if we get here, we have more than one option. so we must take weight and priority into consideration */

    int highestPrio = -1;
    NSMutableArray *highestPrioEntries = [[NSMutableArray alloc]init];
    for(SccpDestination *e in validEntries)
    {
        if(e.priority < highestPrio)
        {
            continue;
        }
        if(e.priority == highestPrio)
        {
            [highestPrioEntries addObject:e];
        }
        if(e.priority > highestPrio)
        {
            highestPrioEntries = [[NSMutableArray alloc]init];
            [highestPrioEntries addObject:e];
            highestPrio = e.priority;
        }
    }

    uint32_t totalWeight = 0;
    for(SccpDestination *e in highestPrioEntries)
    {
        totalWeight = totalWeight + e.weight;
    }

    uint32_t pickWeight = [UMUtil random:totalWeight];
    uint32_t currentWeight = 0;
    for(SccpDestination *e in highestPrioEntries)
    {
        if((currentWeight < pickWeight) && (pickWeight <= (currentWeight+ e.weight)))
        {
            return e;
        }
        currentWeight += e.weight;
    }
    /* we basically shoud never get here */
    return NULL;
}

- (void)setConfig:(NSDictionary *)cfg applicationContext:(id)appContext
{
    _name = [cfg[@"name"] stringValue];
}


@end
