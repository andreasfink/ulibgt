//
//  SccpRoutingTable.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpGttSelector.h"
#import "SccpL3Provider.h"
#import "SccpApplicationGroup.h"
#import "SccpDestination.h"
#import "SccpL3Provider.h"
#import "SccpGttRoutingTable.h"
#import "SccpNumberTranslation.h"

@implementation SccpGttSelector


@synthesize defaultEntry;

-(SccpGttSelector *)initWithInstanceNameE164:(NSString *)name
{
    self = [super init];
    if(self)
    {
        _sccp_instance = name;
        _gti =4;
        _np = 1;
        _nai =4;
        _external = 1;
    }
    return self;
}


- (NSString *)selectorKey
{
    return [SccpGttSelector selectorKeyForTT:_tt gti:_gti np:_np nai:_nai];
}


+ (NSString *)selectorKeyForTT:(int)tt gti:(int)gti np:(int)np nai:(int)nai
{
    if(gti==2)
    {
        return [NSString stringWithFormat:@"tt %d gti 2",tt];
    }
    else
    {
        return [NSString stringWithFormat:@"tt %d gti %d np %d nai %d",tt,gti,np,nai];
    }
}


- (SccpDestination *)chooseNextHopWithL3RoutingTable:(SccpL3RoutingTable *)rt destination:(SccpAddress **)dst;
{
    SccpAddress *addr = *dst;
    if(_preTranslation)
    {
        addr = [_preTranslation translateAddress:addr];
    }
    NSString *digits = addr.address;
    SccpDestination *nextHop;
    SccpGttRoutingTableEntry *routingTableEntry = [_routingTable findEntry:digits];
    if(routingTableEntry==NULL)
    {
        nextHop = defaultEntry;
    }
    else
    {
        nextHop = routingTableEntry.routeTo;
    }
    /* This will return:
       If its a group, pick a specific entry in the group which is available.
       If none in the group is available, return NULL,
       If its a single destination and its not available, return NULL
    */
    nextHop = [nextHop chooseNextHopWithRoutingTable:rt];
    if(_postTranslation)
    {
        addr = [_postTranslation translateAddress:addr];
    }
    *dst = addr;
    return nextHop;
}

@end
