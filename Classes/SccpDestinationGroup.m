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

- (SccpDestination *)pickRandom
{
    if(_entries.count == 0)
    {
        return NULL;
    }
    if(_entries.count ==1)
    {
        return _entries[0];
    }
    uint32_t idx = [UMUtil random:(uint32_t)_entries.count];
    return [_entries objectAtIndex:idx];
}

- (SccpDestinationGroup *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
    }
    return self;
}


#if 0
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
        _entries = [[UMSynchronizedArray alloc]init];
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
#endif


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
            [availEntries addObject:e];
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
        int priority = 4;
        if(e.priority)
        {
            priority = e.priority.intValue;
        }

        if(priority < highestPrio)
        {
            continue;
        }
        if(priority == highestPrio)
        {
            [highestPrioEntries addObject:e];
        }
        if(priority > highestPrio)
        {
            highestPrioEntries = [[NSMutableArray alloc]init];
            [highestPrioEntries addObject:e];
            highestPrio = priority;
        }
    }

    uint32_t totalWeight = 0;
    for(SccpDestination *e in highestPrioEntries)
    {
        int weight = 100;
        if(e.weight)
        {
            weight = e.weight.intValue;
        }
        totalWeight += weight;
    }

    uint32_t pickWeight = [UMUtil random:totalWeight];
    uint32_t currentWeight = 0;
    for(SccpDestination *e in highestPrioEntries)
    {
        int weight = 100;
        if(e.weight)
        {
            weight = e.weight.intValue;
        }

        if((currentWeight < pickWeight) && (pickWeight <= (currentWeight + weight)))
        {
            return e;
        }
        currentWeight += weight;
    }
    /* we basically shoud never get here */
    return NULL;
}

- (void)setConfig:(NSDictionary *)cfg applicationContext:(id)appContext
{
    _name = [cfg[@"name"] stringValue];
}


- (UMSynchronizedSortedDictionary *)status
{
    return [self statusForL3RoutingTable:NULL];
}

- (UMSynchronizedSortedDictionary *)statusForL3RoutingTable:(SccpL3RoutingTable *)rt
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"name"] = _name;

    NSMutableArray *availEntries                = [[NSMutableArray alloc]init];
    NSMutableArray *restrictedEntries           = [[NSMutableArray alloc]init];
    NSMutableArray *unavailableEntries          = [[NSMutableArray alloc]init];
    NSMutableArray *unknownEntries              = [[NSMutableArray alloc]init];

    NSArray *entries = [_entries arrayCopy];

    for(SccpDestination *e in entries)
    {
        if(rt==NULL)
        {
            [unknownEntries addObject:e.statusDict];
        }
        else
        {
            SccpL3RoutingTableEntry *rtentry = [rt getEntryForPointCode:e.dpc];
            UMSynchronizedSortedDictionary *d = [[UMSynchronizedSortedDictionary alloc]init];
            d[@"destination-status"] = e.statusDict;
            if(rtentry)
            {
                d[@"destination-route-status"] = rtentry.statusDict;
            }
            if(rtentry.status==SccpL3RouteStatus_available)
            {
                [availEntries addObject:d];
            }
            else if(rtentry.status==SccpL3RouteStatus_restricted)
            {
                [restrictedEntries addObject:d];
            }
            else
            {
                [unavailableEntries addObject:d];
            }
        }
    }
    dict[@"valid-entries"] = availEntries;
    dict[@"available-entries"] = availEntries;
    dict[@"restricted-entries"] = restrictedEntries;
    dict[@"unavailable-entries"] = unavailableEntries;
    return dict;
}


@end
