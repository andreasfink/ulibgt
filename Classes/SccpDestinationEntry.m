//
//  SccpDestinationEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpDestinationEntry.h"
#import "SccpDestinationGroup.h"
#import "SccpL3RoutingTable.h"
#import <ulibmtp3/ulibmtp3.h>
#import "SccpL3RouteStatus.h"
#import "SccpL3RoutingTableEntry.h"
#import "SccpSubSystemNumber.h"

@implementation SccpDestinationEntry

- (SccpDestinationEntry *)init
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

- (SccpDestinationEntry *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant
{
    return [self initWithConfig:dict variant:variant mtp3Instances:NULL];

}
- (SccpDestinationEntry *)initWithConfig:(NSDictionary *)dict variant:(UMMTP3Variant)variant mtp3Instances:(UMSynchronizedDictionary *)mtp3_instances;

{
    self = [super init];
    if(self)
    {
        [self setConfig:dict variant:variant mtp3Instances:mtp3_instances];
    }
    return self;
}

- (SccpDestinationEntry *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt
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
    [self setConfig:cfg variant:variant mtp3Instances:NULL];
}

- (void)setConfig:(NSDictionary *)cfg variant:(UMMTP3Variant)variant mtp3Instances:(UMSynchronizedDictionary *)mtp3_instances
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
        int cost = [cfg[@"cost"] intValue];
        if((cost >0) && (cost <=64))
        {
            _cost = @(cost);
        }
        else
        {
            NSLog(@"invalid value %d for cost in sccp-destination '%@' ignored. Should be 1...64",cost,self.name);
        }
    }
    if(cfg[@"weight"])
    {
        _weight = @([cfg[@"weight"] intValue]);
    }
    if(cfg[@"ntt"])
    {
        _overrideCalledTT = @([cfg[@"ntt"] intValue]);
    }
    if(cfg[@"set-called-tt"])
    {
        _overrideCalledTT = @([cfg[@"set-called-tt"] intValue]);
    }
    if(cfg[@"set-calling-tt"])
    {
        _overrideCallingTT = @([cfg[@"set-calling-tt"] intValue]);
    }
    if(cfg[@"add-prefix"])
    {
        _addPrefix = [cfg[@"add-prefix"] stringValue];
    }
    if(cfg[@"add-postfix"])
    {
        _addPostfix = [cfg[@"add-postfix"] stringValue];
    }

    if(cfg[@"set-gti"])
    {
        _changeGti = @([cfg[@"set-gti"] intValue]);
    }
    if(cfg[@"set-npi"])
    {
        _changeNpi = @([cfg[@"set-npi"] intValue]);
    }
    if(cfg[@"set-nai"])
    {
        _changeNai = @([cfg[@"set-nai"] intValue]);
    }
    if(cfg[@"set-encoding"])
    {
        _changeEncoding = @([cfg[@"set-encoding"] intValue]);
    }
    if(cfg[@"set-national"])
    {
        _changeNational = @([cfg[@"set-national"] intValue]);
    }
    if(cfg[@"remove-digits"])
    {
        _removeDigits = @([cfg[@"remove-digits"] intValue]);
    }
    
    if(cfg[@"limit-digit-length"])
    {
        _limitDigitLength = @([cfg[@"limit-digit-length"] intValue]);
    }
    
    if(cfg[@"mtp3"])
    {
        _mtp3InstanceName = [cfg[@"mtp3"] stringValue];
        _mtp3 = mtp3_instances[_mtp3InstanceName];
        if(_mtp3 == NULL)
        {
            NSLog(@"Warning: mtp3 instance %@  doestn exist. Referred by sccp-destination-entry %@",_mtp3InstanceName, _destination);
        }
    }
    
    if(cfg[@"ansi-to-itu"])
    {
        _ansiToItuConversion = @([cfg[@"ansi-to-itu"] boolValue]);
    }
    if(cfg[@"itu-to-ansi"])
    {
        _ituToAnsiConversion = @([cfg[@"itu-to-ansi"] boolValue]);
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
    if(_overrideCalledTT)
    {
        dict[@"set-called-tt"] = _overrideCalledTT;
    }
    if(_overrideCallingTT)
    {
        dict[@"set-calling-tt"] = _overrideCallingTT;
    }
    if(_addPrefix)
    {
        dict[@"add-prefix"] = _addPrefix;
    }
    if(_addPostfix)
    {
        dict[@"add-postfix"] = _addPostfix;
    }
    if(_allowConversion)
    {
        dict[@"allow-conversion"] = _allowConversion;
    }
    if(_usePcssn)
    {
        dict[@"use-pcssn"] = @(YES);
    }

    if(_changeGti)
    {
        dict[@"set-gti"] = _changeGti;
    }
    if(_changeNpi)
    {
        dict[@"set-npi"] = _changeNpi;
    }
    if(_changeNai)
    {
        dict[@"set-nai"] = _changeNai;
    }
    if(_changeEncoding)
    {
        dict[@"set-encoding"] = _changeEncoding;
    }
    if(_changeNational)
    {
        dict[@"set-national"] = _changeNational;
    }
    if(_mtp3InstanceName)
    {
        dict[@"mtp3"] = _mtp3InstanceName;
    }
    if(_removeDigits)
    {
        dict[@"remove-digits"] = _removeDigits;
    }
    if(_limitDigitLength)
    {
        dict[@"limit-digit-length"] = _limitDigitLength;
    }
    if(_ansiToItuConversion)
    {
        dict[@"ansi-to-itu"] =_ansiToItuConversion;
    }
    if(_ituToAnsiConversion)
    {
        dict[@"itu-to-ansi"] =_ituToAnsiConversion;
    }
    return dict;
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"SCCP Destination<%@>\n",_name];
    if(_destination)
    {
        [s appendFormat:@"\tdestination: %@\n",_destination];
    }

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
    if(_overrideCalledTT)
    {
        [s appendFormat:@"\tset-called-tt: %@\n",_overrideCalledTT];
    }
    if(_overrideCallingTT)
    {
        [s appendFormat:@"\tset-calling-tt: %@\n",_overrideCallingTT];
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
    if(_changeGti)
    {
        [s appendFormat:@"\tset-gti: %@\n",_changeGti];
    }
    if(_changeNpi)
    {
        [s appendFormat:@"\tset-npi: %@\n",_changeNpi];
    }
    if(_changeNai)
    {
        [s appendFormat:@"\tset-nai: %@\n",_changeNai];
    }
    if(_changeEncoding)
    {
        [s appendFormat:@"\tset-encoding: %@\n",_changeEncoding];
    }
    if(_changeNational)
    {
        [s appendFormat:@"\tset-national: %@\n",_changeNational];
    }
    
    if(_removeDigits)
    {
        [s appendFormat:@"\tremove-digits: %@\n",_removeDigits];
    }
    if(_limitDigitLength)
    {
        [s appendFormat:@"limit-digit-length: %@\n",_limitDigitLength];
    }
    if(_mtp3InstanceName)
    {
        [s appendFormat:@"\tmtp3: %@\n",_mtp3InstanceName];
    }
    if(_ansiToItuConversion)
    {
        [s appendFormat:@"\tansi-to-itu: %@\n",_ansiToItuConversion];
    }
    if(_ituToAnsiConversion)
    {
        [s appendFormat:@"\titu-to-ansi: %@\n",_ituToAnsiConversion];
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
