//
//  SccpGttRoutingTableEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpGttRoutingTableEntry.h"

@implementation SccpGttRoutingTableEntry

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
@end
