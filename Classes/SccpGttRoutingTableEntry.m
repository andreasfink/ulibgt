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
#import "SccpSubSystemNumber.h"

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
        if(cfg[@"opcode"])
        {
            NSMutableArray *a = [[NSMutableArray alloc]init];
            id c = cfg[@"opcode"];
            if([c isKindOfClass:[NSArray class]])
            {
                NSArray *b = (NSArray *)c;
                for(id c in b)
                {
                    if([c isKindOfClass:[NSString class]])
                    {
                        NSNumber *n = @([(NSString *)c integerValue]);
                        [a addObject:n];
                    }
                    else if([c isKindOfClass:[NSNumber class]])
                    {
                        NSNumber *n = @([(NSNumber *)c integerValue]);
                        [a addObject:n];
                    }
                }
            }
            else
            {
                if([c isKindOfClass:[NSString class]])
                {
                    NSString *s = (NSString *)c;
                    NSArray *a1 = [s componentsSeparatedByCharactersInSet:[UMObject whitespaceAndNewlineAndCommaCharacterSet]];
                    for(NSString *s1 in a1 )
                    {
                        NSNumber *n = @([s1 integerValue]);
                        [a addObject:n];
                    }
                }
                else if([c isKindOfClass:[NSNumber class]])
                {
                    NSNumber *n = @([(NSNumber *)c integerValue]);
                    [a addObject:n];
                }
            }
            _calledOpcodes = a;
        }
        if(cfg[@"ssn"])
        {
            NSMutableArray *a = [[NSMutableArray alloc]init];

            if([cfg[@"ssn"] isKindOfClass:[NSArray class]])
            {
                NSArray *b = (NSArray *)cfg[@"ssn"];
                for(id c in b)
                {
                    if([c isKindOfClass:[NSString class]])
                    {
                        NSNumber *n = @([(NSString *)c integerValue]);
                        [a addObject:n];
                    }
                    else if([c isKindOfClass:[NSNumber class]])
                    {
                        NSNumber *n = @([(NSNumber *)c integerValue]);
                        [a addObject:n];
                    }
                }
            }
            else
            {
                id c = cfg[@"ssn"];
                if([c isKindOfClass:[NSString class]])
                {
                    NSNumber *n = @([(NSString *)c integerValue]);
                    [a addObject:n];
                }
                if([c isKindOfClass:[NSString class]])
                {
                    NSString *s = (NSString *)c;
                    NSArray *a1 = [s componentsSeparatedByCharactersInSet:[UMObject whitespaceAndNewlineAndCommaCharacterSet]];
                    for(NSString *s1 in a1 )
                    {
                        SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithName:s1];
                        [a addObject:@(ssn.ssn)];
                    }
                }
                else if([c isKindOfClass:[NSNumber class]])
                {
                    NSNumber *n = @([(NSNumber *)c integerValue]);
                    [a addObject:n];
                }
            }
            _calledSSNs = a;
        }
        
        if(cfg[@"application-context"])
        {

            if([cfg[@"application-context"] isKindOfClass:[NSArray class]])
            {
                NSMutableArray *a = [[NSMutableArray alloc]init];
                NSArray *b = (NSArray *)cfg[@"application-context"];
                for(id c in b)
                {
                    if([c isKindOfClass:[NSString class]])
                    {
                        NSNumber *n = @([(NSString *)c integerValue]);
                        [a addObject:n];
                    }
                }
                _appContexts = a;
            }
            if([cfg[@"application-context"] isKindOfClass:[NSString class]])
            {
                NSString *s = (NSString *)cfg[@"application-context"];
                _appContexts = [s componentsSeparatedByCharactersInSet:[UMObject whitespaceAndNewlineAndCommaCharacterSet]];
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
                                                          ssn:(NSNumber *)ssn
                                                       opcode:(NSNumber *)op
                                                   appcontext:(NSString *)ac
{
    if(_hasSubentries == NO)
    {
        return self;
    }
    for(SccpGttRoutingTableEntry *entry in _subentries)
    {
        if([entry matchingTransactionNumber:tid
                                        ssn:ssn
                                     opcode:op
                                 appcontext:ac])
        {
            return entry;
        }
    }
    return self;
}

- (SccpGttRoutingTableEntry *)findSubentryByApplicationContext:(NSString *)ac
{
    if(_hasSubentries == NO)
    {
        return self;
    }
    for(SccpGttRoutingTableEntry *entry in _subentries)
    {
        if([entry matchingApplicationContext:ac])
        {
            return entry;
        }
    }
    return self;
}

- (SccpGttRoutingTableEntry *)findSubentryBySubsystemNumber:(NSNumber *)ssn
{
    if(_hasSubentries == NO)
    {
        return self;
    }
    for(SccpGttRoutingTableEntry *entry in _subentries)
    {
        if([entry matchingSSN:ssn])
        {
            return entry;
        }
    }
    return self;
}

- (SccpGttRoutingTableEntry *)findSubentryByOpcode:(NSNumber *)opcode
{
    if(_hasSubentries == NO)
    {
        return self;
    }
    for(SccpGttRoutingTableEntry *entry in _subentries)
    {
        if([entry matchingOpcode:opcode])
        {
            return entry;
        }
    }
    return self;
}

- (BOOL)matchingTransactionNumber:(NSNumber *)tid
                              ssn:(NSNumber *)ssn
                           opcode:(NSNumber *)op
                       appcontext:(NSString *)ac
{
    if(![self matchingTransactionNumber:tid])
    {
        return NO;
    }
    if(![self matchingSSN:ssn])
    {
        return NO;
    }
    
    if(![self matchingOpcode:op])
    {
        return NO;
    }
    if(![self matchingApplicationContext:ac])
    {
        return NO;
    }
    return YES;
}

- (BOOL) matchingTransactionNumber:(NSNumber *)tid
{
    unsigned long start = 0x00000000;
    unsigned long end   = 0xFFFFFFFF;
    unsigned long current = tid.unsignedLongValue;
    if(_tcapTransactionRangeStart)
    {
        start = _tcapTransactionRangeStart.unsignedLongValue;
    }
    if(_tcapTransactionRangeEnd)
    {
        end = _tcapTransactionRangeEnd.unsignedLongValue;
    }

    if((start <= current) && ( current <= end))
    {
        return YES;
    }
    return NO;
}

- (BOOL) matchingApplicationContext:(NSString *)ac
{
    if(_appContexts.count == 0)
    {
        return YES;
    }
    for(NSString *s in _appContexts)
    {
        if( [s isEqualToString:ac])
        {
            return YES;
        }
    }
    return NO;
}


- (BOOL) matchingSSN:(NSNumber *)ssn
{
    if(_calledSSNs.count == 0)
    {
        return YES;
    }
    for(NSNumber *s in _calledSSNs)
    {
        if( [s isEqualTo:ssn])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL) matchingOpcode:(NSNumber *)op
{
    if(_calledOpcodes.count == 0)
    {
        return YES;
    }
    for(NSNumber *n in _calledOpcodes)
    {
        if( [n isEqualTo:op])
        {
            return YES;
        }
    }
    return NO;
}

- (SccpGttRoutingTableEntry *)copyWithZone:(NSZone *)zone
{
    SccpGttRoutingTableEntry *dst = [[SccpGttRoutingTableEntry allocWithZone:zone]init];
    dst->_hasSubentries = _hasSubentries;
    dst->_subentries = [_subentries copy];
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
