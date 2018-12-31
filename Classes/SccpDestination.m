//
//  SccpDestination.m
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpDestination.h"
#import "SccpDestinationGroup.h"
#import "SccpL3RoutingTable.h"
#import <ulibmtp3/ulibmtp3.h>
#import "SccpL3RouteStatus.h"
#import "SccpL3RoutingTableEntry.h"

@implementation SccpDestination

- (SccpDestination *)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}


- (SccpDestination *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant;
{
    self = [super init];
    if(self)
    {
        [self setConfig:dict variant:variant];
    }
    return self;
}


#if 0
- (SccpDestination *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant
{
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]];
    if(array.count==0)
    {
        return NULL;
    }
    else if(array.count==1)
    {
        self = [super init];
        if(self)
        {
            _dpc = [[UMMTP3PointCode alloc]initWithString:array[0] variant:variant];
        }
        return self;
    }
    else
    {
        return [[SccpDestinationGroup alloc]initWithDpcString:string variant:variant];
    }
}
#endif


- (SccpDestination *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt
{
    SccpL3RoutingTableEntry *entry = [rt getEntryForPointCode:self.dpc];
    if(entry.status==SccpL3RouteStatus_unavailable)
    {
        return NULL;
    }
    return self;
}

- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant
{
    if(cfg[@"name"])
    {
        _name = [cfg[@"name"] stringValue];
    }
    if(cfg[@"destination"])
    {
        _destination = [cfg[@"destination"] stringValue];
    }
    if(cfg[@"subsystem"])
    {
        _ssn = @(  [cfg[@"subsystem"] intValue] );
    }
    if(cfg[@"point-code"])
    {
        _dpc = [[UMMTP3PointCode alloc]initWithString: [cfg[@"point-code"] stringValue] variant:variant];
    }
    if(cfg[@"application-server"])
    {
        _m3uaAs =[cfg[@"application-server"] stringValue];
    }

    if(cfg[@"priority"])
    {
        _priority =@([cfg[@"ssn"] intValue]);

    }
    if(cfg[@"weight"])
    {
        _weight =@([cfg[@"weight"] intValue]);
    }
    if(cfg[@"ntt"])
    {
        _ntt = @([cfg[@"ntt"] intValue]);
    }
    if(cfg[@"add-prefix"])
    {
        _addPrefix = [cfg[@"add-prefix"] stringValue];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];

    if(_name)
    {
        dict[@"name"] = _name;
    }
    if(_destination)
    {
        dict[@"destination"] = _destination;
    }
    if(_ssn)
    {
        dict[@"subsystem"] = _ssn;
    }
    if(_dpc)
    {
        dict[@"point-code"] = _dpc;
    }
    if(_m3uaAs)
    {
        dict[@"application-server"] = _m3uaAs;
    }
    if(_priority)
    {
        dict[@"priority"] = _priority;
    }
    if(_weight)
    {
        dict[@"weight"] = _weight;
    }
    if(_ntt)
    {
        dict[@"ntt"] = _ntt;
    }
    if(_addPrefix)
    {
        dict[@"add-prefix"] = _addPrefix;
    }
    return dict;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"SCCP Destination(name=%@,_ssn=%@,_priority=%@,_weight=%@,_dpc=%@)",_name,_ssn,_priority,_weight,_dpc ];
}

- (UMSynchronizedSortedDictionary *)statusDict
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"config"] = [self config];
    return dict;
}
@end
