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
    dst.name = [NSString stringWithFormat:@"%@-%d",self.name,(int)_entries.count+1];
    dst.destination = self.name;
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

    /* if we get here, we have more than one option. so we must take weight and cost into consideration */

    _lastIndex++;

    NSMutableArray *lowestCostEntries;

    /* find the lowest cost entries if wrr or cost methods are choosen. otherwise all entries are considered */
    if((_distributionMethod == SccpDestinationGroupDistributionMethod_cost) || (_distributionMethod == SccpDestinationGroupDistributionMethod_wrr))
    {

        int lowestCost = 65; /* costs is a value from 1...64 */
        for(SccpDestination *e in validEntries)
        {
            int cost = 4;
            if(e.cost)
            {
                cost = e.cost.intValue;
            }

            if(cost > lowestCost)
            {
                continue;
            }
            if(cost == lowestCost)
            {
                [lowestCostEntries addObject:e];
            }
            if(cost < lowestCost)
            {
                lowestCostEntries = [[NSMutableArray alloc]init];
                [lowestCostEntries addObject:e];
                lowestCost = cost;
            }
        }
    }
    else
    {
         lowestCostEntries = validEntries;
    }

    /* calculate the total weigth */
    uint32_t totalWeight = 0;
    for(SccpDestination *e in lowestCostEntries)
    {
        uint32_t weight = 100;
        if(e.weight)
        {
            weight = (uint32_t)e.weight.unsignedIntegerValue;
        }
        totalWeight += weight;
    }

    switch(_distributionMethod)
    {
        case SccpDestinationGroupDistributionMethod_share:
        {
            int lowestCost = 65;
            NSMutableArray *lowestCostEntries = validEntries;
            for(SccpDestination *e in validEntries)
            {
                int cost = 4;
                if(e.cost)
                {
                    cost = e.cost.intValue;
                }

                if(cost > lowestCost)
                {
                    continue;
                }
                if(cost == lowestCost)
                {
                    [lowestCostEntries addObject:e];
                }
                if(cost < lowestCost)
                {
                    lowestCostEntries = [[NSMutableArray alloc]init];
                    [lowestCostEntries addObject:e];
                    lowestCost = cost;
                }
            }
            uint32_t totalWeight = 0;
            for(SccpDestination *e in lowestCostEntries)
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
            for(SccpDestination *e in lowestCostEntries)
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
            return NULL;
            break;
        }
        case SccpDestinationGroupDistributionMethod_wrr:
        {
            uint32_t pickWeight = [UMUtil random:totalWeight];
            uint32_t currentWeight = 0;
            for(SccpDestination *e in lowestCostEntries)
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
            return NULL;
        }
        case SccpDestinationGroupDistributionMethod_cgpa:
            NSLog(@"SccpDestinationGroupDistributionMethod_cgpa is not yet implemented");
            break;

        case SccpDestinationGroupDistributionMethod_cost:
        default:
            if(lowestCostEntries.count==0)
            {
                return NULL;
            }
            else if(lowestCostEntries.count == 1)
            {
                return lowestCostEntries[0];
            }
            else
            {
                _lastIndex = _lastIndex % lowestCostEntries.count;
                return lowestCostEntries[ _lastIndex];
            }
            break;
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
    if(unknownEntries.count > 0)
    {
        dict[@"unknown-entries"] = [NSArray arrayWithArray:unknownEntries];
    }
    if(availEntries.count > 0)
    {
        dict[@"available-entries"] = [NSArray arrayWithArray:availEntries];
    }
    if(restrictedEntries.count > 0)
    {
        dict[@"restricted-entries"] = [NSArray arrayWithArray:restrictedEntries];
    }
    if(unavailableEntries.count > 0)
    {
        dict[@"unavailable-entries"] = [NSArray arrayWithArray:unavailableEntries];
    }
    return dict;
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"SccpDestinationGroup<%p> %@",self,_name];
    return s;
}
@end
