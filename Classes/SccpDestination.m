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
#import "SccpSubSystemNumber.h"

@implementation SccpDestination

- (SccpDestination *)init
{
    self = [super init];
    if(self)
    {
        _cost = @(5);
        _weight = @(100.0);
        _usePcssn = NO;
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
        _ssn = [[SccpSubSystemNumber alloc]initWithName:cfg[@"subsystem"]];
    }
    if(cfg[@"point-code"])
    {
        _dpc = [[UMMTP3PointCode alloc]initWithString: [cfg[@"point-code"] stringValue] variant:variant];
    }
    if(cfg[@"application-server"])
    {
        _m3uaAs =[cfg[@"application-server"] stringValue];
    }

    if(cfg[@"cost"])
    {
        _cost =@([cfg[@"cost"] intValue]);

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
        dict[@"subsystem"] = @(_ssn.ssn);
    }
    if(_dpc)
    {
        dict[@"point-code"] = _dpc;
    }
    if(_m3uaAs)
    {
        dict[@"application-server"] = _m3uaAs;
    }
    if(_cost)
    {
        dict[@"cost"] = _cost;
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
    if(_allowConversion)
    {
        dict[@"allow-conversion"] = _allowConversion;
    }
    if(_usePcssn)
    {
        dict[@"use-pcssn"] = @(YES);
    }

    return dict;
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"SCCP Destination<%@>\n",_name];
    if(_ssn)
    {
        [s appendFormat:@"\tssn: %@\n",_ssn];
    }
    if(_dpc)
    {
        [s appendFormat:@"\tdpc: %@\n",_dpc];
    }
    if(_m3uaAs)
    {
        [s appendFormat:@"\tapplication-server: %@\n",_m3uaAs];
    }
    if(_cost)
    {
        [s appendFormat:@"\tcost: %@\n",_cost];
    }
    if(_weight)
    {
        [s appendFormat:@"\tweigth: %@\n",_weight];
    }
    if(_ntt)
    {
        [s appendFormat:@"\tntt: %@\n",_ntt];
    }
    if(_addPrefix)
    {
        [s appendFormat:@"\taddPrefix: %@\n",_addPrefix];
    }
    if(_allowConversion)
    {
        [s appendFormat:@"\tallowConversion: %@\n",_allowConversion];
    }

    if(_usePcssn)
    {
        [s appendFormat:@"\tusePcssn: YES\n"];
    }
     return s;
}

- (UMSynchronizedSortedDictionary *)statusDict
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"config"] = [self config];
    return dict;
}
@end
