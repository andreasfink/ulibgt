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
#import "SccpAddress.h"
#import "SccpDestinationGroup.h"

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
        _routingTable = [[SccpGttRoutingTable alloc]init];
    }
    return self;
}

-(SccpGttSelector *)initWithConfig:(NSDictionary *)config
{
    self = [super init];
    if(self)
    {
        _gti =4;
        _np = 1;
        _nai =4;
        _external = 1;
        _routingTable = [[SccpGttRoutingTable alloc]init];
        if(config[@"sccp"])
        {
            _sccp_instance = [config[@"sccp"] stringValue];
        }
        if(config[@"tt"])
        {
            _tt = [config[@"tt"] intValue];
        }
        if(config[@"gti"])
        {
            _gti = [config[@"gti"] intValue];
        }
        if(config[@"np"])
        {
            _np = [config[@"np"] intValue];
        }
        if(config[@"nai"])
        {
            _nai = [config[@"nai"] intValue];
        }
        if(config[@"pre-translation"])
        {
            _preTranslationName = [config[@"pre-translation"] stringValue];
        }
        if(config[@"post-translation"])
        {
            _postTranslationName = [config[@"post-translation"] stringValue];
        }
        if(config[@"default-destination"])
        {
            _defaultEntryName = [config[@"default-destination"] stringValue];
        }
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
        nextHop = [defaultEntry chooseNextHopWithRoutingTable:rt];
    }
    else
    {
        SccpDestinationGroup *nextHopGroup = [routingTableEntry getRouteTo];
        nextHop = [nextHopGroup chooseNextHopWithRoutingTable:rt];
    }
    /* This will return:
       If its a group, pick a specific entry in the group which is available.
       If none in the group is available, return NULL,
       If its a single destination and its not available, return NULL
    */
    if(_postTranslation)
    {
        addr = [_postTranslation translateAddress:addr];
    }
    *dst = addr;
    return nextHop;
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
	(_sccp_instance!=NULL) ? [dict addObject:_sccp_instance forKey:@"sccp"] : "";
	[dict addObject:[NSNumber numberWithInt:_tt] forKey:@"tt"]; 			// tt is integer and zero (e.g. 0) is a valid number
	[dict addObject:[NSNumber numberWithInt:_gti] forKey:@"gti"];			//     	-//-
	[dict addObject:[NSNumber numberWithInt:_np] forKey:@"np"];				//		-//-
	[dict addObject:[NSNumber numberWithInt:_nai] forKey:@"nai"];			//		-//-
	[dict addObject:[NSNumber numberWithInt:_external] forKey:@"external"];	//		-//-	
	[dict addObject:[NSNumber numberWithInt:_internal] forKey:@"internal"];	//		-//-
	(_preTranslationName!=NULL) ? [dict addObject:_preTranslationName forKey:@"pre-translation"] : "";
	(_postTranslationName!=NULL) ? [dict addObject:_postTranslationName forKey:@"post-translation"] : "";
	(_defaultEntryName!=NULL) ? [dict addObject:_defaultEntryName forKey:@"default-destination"] : "";
    return dict;
}

- (UMSynchronizedSortedDictionary *)statisticalInfo
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    
	UMSynchronizedSortedDictionary *entries = [_routingTable list];
	NSArray *keys = [entries allKeys];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *routingTableEntry = entries[key];
        dict[key] = [routingTableEntry getStatistics];
    }
    return dict;
}

@end
