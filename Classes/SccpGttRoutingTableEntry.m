//
//  SccpGttRoutingTableEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpGttRoutingTableEntry.h"
#import "SccpDestinationGroup.h"
#import "SccpL3RoutingTable.h"

@implementation SccpGttRoutingTableEntry

- (SccpGttRoutingTableEntry *)init
{
    self = [super init];
    if(self)
    {
        _incomingSpeed = [[UMThroughputCounter alloc]init];
        _enabled=YES;
    }
    return self;
}

- (SccpGttRoutingTableEntry *)initWithConfig:(NSDictionary *)cfg
{
    self = [super init];
    if(self)
    {
		_incomingSpeed = [[UMThroughputCounter alloc]init];
        if(cfg[@"name"])
        {
            _name = [cfg[@"name"] stringValue];
        }
        if(cfg[@"table"])
        {
            _table = [cfg[@"table"] stringValue];
        }
        if(cfg[@"gta"])
        {
            _digits = [cfg[@"gta"] stringValue];
        }

        if(cfg[@"destination"])
        {
            _routeToName = [cfg[@"destination"] stringValue];
        }
        if(cfg[@"post-translation"])
        {
            _postTranslationName = [cfg[@"post-translation"] stringValue];
        }
        _enabled=YES;
    }
    return self;
}

- (SccpDestinationGroup *)getRouteTo
{
	[_incomingSpeed increase];
	return _routeTo;
}

- (NSString *)getStatistics
{
   return [_incomingSpeed getSpeedStringTriple];
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    if(_name)
    {
        dict[@"name"] = _name;
    }
    if(_table)
    {
        dict[@"table"] = _table;
    }
    if(_digits)
    {
        dict[@"gta"] = _digits;
    }
    if(_routeToName)
    {
        dict[@"destination"] = _routeToName;
    }
    if(_postTranslationName)
    {
        dict[@"post-translation"] = _postTranslationName;
    }
    return dict;
}

+ (NSString *)entryNameForGta:(NSString *)gta tableName:(NSString *)tableName
{
    return [NSString stringWithFormat:@"%@:%@",tableName,gta ];
}

- (UMSynchronizedSortedDictionary *)status
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"config"] = [self config];
    dict[@"enabled"] = @(_enabled);
    dict[@"incoming-speed"] = [_incomingSpeed getSpeedTripleJson];
    if(_routeTo)
    {
        dict[@"destination-status"] = [_routeTo status];
    }
    return dict;
}

- (UMSynchronizedSortedDictionary *)statusForL3RoutingTable:(SccpL3RoutingTable *)rt
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"config"] = [self config];
    dict[@"enabled"] = @(_enabled);
    dict[@"incoming-speed"] = [_incomingSpeed getSpeedTripleJson];
    if(_routeTo)
    {
        dict[@"destination-status"] = [_routeTo statusForL3RoutingTable:rt];
    }
    return dict;
}

@end
