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
            if([_routeToName isEqualToStringCaseInsensitive:@"local"])
            {
                _deliverLocal = YES;
            }
        }
        if(cfg[@"post-translation"])
        {
            _postTranslationName = [cfg[@"post-translation"] stringValue];
        }
        if(cfg[@"transaction-id-start"])
        {
            if([cfg[@"transaction-id-start"] isKindOfClass:[NSNumber class]])
            {
                _tcapTransactionRangeStart = cfg[@"transaction-id-start"]; /* this is supposed to be a NSNumber */
            }
        }
        if(cfg[@"transaction-id-end"])
        {
             if([cfg[@"transaction-id-end"] isKindOfClass:[NSNumber class]])
             {
                 _tcapTransactionRangeEnd = cfg[@"transaction-id-end"]; /* this is supposed to be a NSNumber */
             }
        }
        if(cfg[@"transaction-id-range"])
        {
            NSString *s =[cfg[@"transaction-id-range"] stringValue];
            NSArray *a = [s componentsSeparatedByString:@"-"];
            if(a.count !=2)
            {
                NSLog(@"config option 'transaction-id-range' ignored. should be <from> - <to>");
            }
            else
            {
                NSString *a0 = a[0];
                NSString *a1 = a[1];
                a0 = [a0 trim];
                a1 = [a1 trim];
                if(a0.length > 0)
                {
                    _tcapTransactionRangeStart = @([a0 intergerValueSupportingHex]);
                }
                if(a1.length > 0)
                {
                    _tcapTransactionRangeEnd = @([a1 intergerValueSupportingHex]);
                }
            }
        }
        _enabled=YES;
        _name = [SccpGttRoutingTableEntry entryNameForGta:_digits tableName:_table];
    }
    return self;
}

- (void)addSubentry:(SccpGttRoutingTableEntry *)subentry
{
    SccpGttRoutingTableEntry *e = [self copy];
    if(_subentries == NULL)
    {
        _subentries = @[subentry, e];
    }
    else
    {
        _subentries =  [_subentries arrayByAddingObject:subentry];
    }
    _hasSubentries = YES;
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

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"<%@:%p>",[self className],self];
    if(_name)
    {
        [s appendFormat:@" name=%@",_name];
    }
    if(_table)
    {
        [s appendFormat:@" table=%@",_table];
    }
    if(_digits)
    {
        [s appendFormat:@" gta=%@",_digits];
    }
    if(_routeToName)
    {
        [s appendFormat:@" destination=%@ -> (%@)",_routeToName, (_routeTo ? _routeTo.name : @"NULL" )];
    }
    if(_postTranslationName)
    {
        [s appendFormat:@" post-translation=%@",_postTranslationName];
    }
    return s;
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


- (SccpGttRoutingTableEntry *)findSubentryByTransactionNumber:(NSNumber *)tid
{
    if(_hasSubentries == NO)
    {
        return self;
    }
    for(SccpGttRoutingTableEntry *entry in _subentries)
    {
        if([entry matchingTransactionNumber:tid])
        {
            return entry;
        }
    }
    return self;
}

- (BOOL) matchingTransactionNumber:(NSNumber *)tid
{
    if((_tcapTransactionRangeStart==NULL) &&(_tcapTransactionRangeEnd == NULL))
    {
        return YES;
    }
    
    NSComparisonResult c1;
    NSComparisonResult c2;

    if(_tcapTransactionRangeStart ==NULL)
    {
        c1 = NSOrderedAscending;
    }
    else
    {
        c1 = [_tcapTransactionRangeStart compare:tid];
    }
    
    if(_tcapTransactionRangeEnd ==NULL)
    {
        c2 = NSOrderedDescending;
    }
    else
    {
        c2 = [_tcapTransactionRangeEnd compare:tid];
    }

    if(((c1 == NSOrderedAscending) ||(c1 == NSOrderedSame)) &&
       ((c2 == NSOrderedDescending) ||(c2 == NSOrderedSame)))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (SccpGttRoutingTableEntry *)copyWithZone:(NSZone *)zone
{
    SccpGttRoutingTableEntry *dst = [[SccpGttRoutingTableEntry allocWithZone:zone]init];
    dst->_hasSubentries = NO;
    dst->_subentries = NULL;
    dst->_name = _name;
    dst->_table = _table;
    dst->_digits = _digits;
    dst->_routeTo = _routeTo;
    dst->_routeToName = _routeToName;
    dst->_deliverLocal = _deliverLocal;
    dst->_postTranslationName = _postTranslationName;
    dst->_postTranslation = _postTranslation;
    dst->_enabled = _enabled;
    dst->_logLevel = _logLevel;
    dst->_tcapTransactionRangeStart = _tcapTransactionRangeStart;
    dst->_tcapTransactionRangeEnd = _tcapTransactionRangeEnd;
    return dst;
}
    

@end
