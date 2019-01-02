//
//  SccpGttSelector.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpGttSelector.h"
#import "SccpApplicationGroup.h"
#import "SccpDestination.h"
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
        _routingTable = [[SccpGttRoutingTable alloc]initWithName:name];
		_active=YES;
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
		_active=YES;
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
        if(config[@"name"])
        {
            _name = [config[@"name"] stringValue];
        }
        else
        {
            _name = [self selectorKey];
        }
        _routingTable = [[SccpGttRoutingTable alloc]initWithName:_name];
    }
    return self;
}



- (void)setLogLevel:(UMLogLevel)newLogLevel
{
    _logLevel = newLogLevel;
    _routingTable.logLevel = newLogLevel;
}

- (UMLogLevel) logLevel
{
    return _logLevel;
}

- (void)setLogFeed:(UMLogFeed *)newLogFeed
{
    [super setLogFeed:newLogFeed];
    _routingTable.logFeed = newLogFeed;
}

- (UMLogFeed *) logFeed
{
    return [super logFeed];
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

- (SccpDestination *)chooseNextHopWithL3RoutingTable:(SccpL3RoutingTable *)rt
                                         destination:(SccpAddress **)dst
                                     incomingLinkset:(NSString *)incomingLinkset
{
    SccpAddress *addr = *dst;
    if(_preTranslation)
    {
        SccpAddress *addr2 = [_preTranslation translateAddress:addr];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"pre-translation: %@->%@",addr,addr2]];
        }
        addr = addr2;
    }
    NSString *digits = addr.address;
    SccpDestination *nextHop = NULL;
    SccpGttRoutingTableEntry *routingTableEntry = [_routingTable findEntryByDigits:digits];
    if(routingTableEntry==NULL)
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"_routingTable findEntryByDigits:%@ returns NULL. Taking default route",digits]];
        }

        nextHop = [defaultEntry chooseNextHopWithRoutingTable:rt];
    }
    else
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"_routingTable findEntryByDigits:%@ returns routingTableEntry:%@",digits,routingTableEntry.name]];
        }
        SccpDestinationGroup *nextHopGroup = [routingTableEntry getRouteTo];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"destinationGroup = %@",nextHopGroup.name]];
        }

        nextHop = [nextHopGroup chooseNextHopWithRoutingTable:rt];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"nextHop = %@",nextHopGroup.name]];
        }

    }
    /* This will return:
       If its a group, pick a specific entry in the group which is available.
       If none in the group is available, return NULL,
       If its a single destination and its not available, return NULL
    */
    if(_postTranslation)
    {
        SccpAddress *addr2 = [_postTranslation translateAddress:addr];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"post-translation: %@->%@",addr,addr2]];
        }
        addr = addr2;
    }
    *dst = addr;
    return nextHop;
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    if(_name)
    {
        dict[@"name"] = _name;
    }
    if(_sccp_instance)
    {
        dict[@"sccp"] = _sccp_instance;
    }
    dict[@"tt"] = @(_tt);
    dict[@"gti"] = @(_gti);
    dict[@"np"] = @(_np);
    dict[@"nai"] = @(_nai);
    if(_preTranslationName)
    {
        dict[@"pre-translation"] = _preTranslationName;
    }
    if(_postTranslationName)
    {
        dict[@"post-translation"] = _postTranslationName;
    }
    if(_defaultEntryName)
    {
        dict[@"default-destination"] = _defaultEntryName;
    }
	dict[@"active"] = @(_active);


    dict[@"gt-destination"] = _defaultEntryName;

    return dict;
}

- (UMSynchronizedSortedDictionary *)statisticalInfo
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    
	UMSynchronizedSortedDictionary *entries = [_routingTable list];
	NSArray *keys = [entries allKeys];
	dict[@"active"] = [NSNumber numberWithBool:_active];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *routingTableEntry = entries[key];
        dict[key] = [routingTableEntry getStatistics];
    }
    return dict;
}

- (void)activate:(BOOL)on
{
	_active = on;
}

@end
