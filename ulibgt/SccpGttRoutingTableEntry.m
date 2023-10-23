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
            id gta_entry = cfg[@"gta"];
            if([gta_entry isKindOfClass:[NSString class]])
            {
                _digits = [gta_entry stringValue];
            }
            if([gta_entry isKindOfClass:[NSArray class]])
            {
                _digits = [gta_entry[0] stringValue];
            }
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
    }
    return self;
}
 
#if 0
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
#endif

- (NSString *)getStatistics
{
   return [_incomingSpeed getSpeedStringTriple];
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"name"] = [self name];
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
    [s appendFormat:@" name=%@", [self name]];
    if(_table)
    {
        [s appendFormat:@" table=%@",_table];
    }
    if(_digits)
    {
        [s appendFormat:@" digits=%@",_digits];
    }
    if(_routeToName)
    {
        [s appendFormat:@" destination=%@ -> (%@)",_routeToName, (_routeTo ? _routeTo.name : @"NULL" )];
    }
    if(_deliverLocal)
    {
        [s appendFormat:@" deliverLocal=%@", _deliverLocal? @"YES" : @"NO"];
    }
    if(_postTranslationName)
    {
        [s appendFormat:@" post-translation=%@",_postTranslationName];
    }
    if(_enabled == NO)
    {
        [s appendFormat:@" enabled=NO"];
    }
    
    if(_tcapTransactionRangeStart || _tcapTransactionRangeEnd)
    {
        [s appendFormat:@" tcap-transaction-range="];
        if(_tcapTransactionRangeStart)
        {
            [s appendFormat:@"%@-",_tcapTransactionRangeStart];
        }
        else
        {
            [s appendFormat:@"0-"];
        }
        if(_tcapTransactionRangeEnd)
        {
            [s appendFormat:@"%@",_tcapTransactionRangeEnd];
        }
        else
        {
            [s appendFormat:@"%d",0xFFFFFFFF];
        }
        [s appendFormat:@" enabled=NO"];
    }
    if(_calledSSNs.count > 0)
    {
        BOOL first=YES;
        [s appendFormat:@" ssn="];
        for(NSNumber *s1 in _calledSSNs)
        {
            if(first)
            {
                first=NO;
                [s appendFormat:@"%@",s1];
            }
            else
            {
                [s appendFormat:@",%@",s1];
            }
        }
    }
    if(_calledOpcodes.count > 0)
    {
        BOOL first=YES;
        [s appendFormat:@" opcodes="];
        for(NSNumber *s1 in _calledOpcodes)
        {
            if(first)
            {
                first=NO;
                [s appendFormat:@"%@",s1];
            }
            else
            {
                [s appendFormat:@",%@",s1];
            }
        }
    }
    if(_appContexts.count > 0)
    {
        BOOL first=YES;
        [s appendFormat:@" app-contexts="];
        for(NSString *s1 in _appContexts)
        {
            if(first)
            {
                first=NO;
                [s appendFormat:@"%@",s1];
            }
            else
            {
                [s appendFormat:@",%@",s1];
            }
        }
    }
    return s;
}


- (NSString *)name
{
    return [SccpGttRoutingTableEntry entryNameForGta:_digits
                                           tableName:_table
                           tcapTransactionRangeStart:_tcapTransactionRangeStart
                             tcapTransactionRangeEnd:_tcapTransactionRangeEnd
                                          calledSSNs:(NSArray<NSNumber *>*)_calledSSNs
                                       calledOpcodes:(NSArray<NSNumber *>*)_calledOpcodes
                                         appContexts:(NSArray<NSNumber *>*)_appContexts];
}

+ (NSString *)entryNameForGta:(id)digits_object  /* can be NSString or NSArray<NSString *> with exactly one object */
                    tableName:(NSString *)table
    tcapTransactionRangeStart:(NSNumber *)tcapTransactionRangeStart
      tcapTransactionRangeEnd:(NSNumber *)tcapTransactionRangeEnd
                   calledSSNs:(NSArray<NSNumber *>*)calledSSNs
                calledOpcodes:(NSArray<NSNumber *>*)calledOpcodes
                  appContexts:(NSArray<NSNumber *>*)appContexts

{
    NSString *digits = NULL;

    if([digits_object isKindOfClass:[NSString class]])
    {
        digits = (NSString *)digits_object;
    }
    else if([digits_object isKindOfClass:[NSArray class]])
    {
        digits = (NSString *)((NSArray <NSString *> *)digits_object[0]);
    }
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"%@:%@",table,digits];
    if((tcapTransactionRangeStart) || (tcapTransactionRangeEnd))
    {
        
        [s appendString:@":tid("];
        if(tcapTransactionRangeStart)
        {
            [s appendFormat:@"%@",tcapTransactionRangeStart];
        }
        [s appendString:@"-"];
        if(tcapTransactionRangeEnd)
        {
            [s appendFormat:@"%@",tcapTransactionRangeEnd];
        }
        [s appendString:@")"];
    }
    if( calledSSNs)
    {
        [s appendString:@":ssn("];
        BOOL first=YES;
        for(NSNumber *n in calledSSNs)
        {
            if(first)
            {
                first=NO;
            }
            else
            {
                [s appendString:@","];
            }
            [s appendFormat:@"%@",n];
        }
        [s appendString:@")"];
    }
    if(calledOpcodes)
    {
        [s appendString:@":op("];
        BOOL first=YES;
        for(NSNumber *n in calledOpcodes)
        {
            if(first)
            {
                first=NO;
            }
            else
            {
                [s appendString:@","];
            }
            [s appendFormat:@"%@",n];
        }
        [s appendString:@")"];
    }
    if(appContexts)
    {
        [s appendString:@":ac("];
        BOOL first=YES;
        for(NSString *ac in appContexts)
        {
            if(first)
            {
                first=NO;
            }
            else
            {
                [s appendString:@","];
            }
            [s appendFormat:@"%@",ac];
        }
        [s appendString:@")"];
    }
    return s;
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

#if 0
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
#endif

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


- (BOOL) isMainEntry
{
    if(_tcapTransactionRangeStart)
    {
        return NO;
    }
    if(_tcapTransactionRangeEnd)
    {
        return NO;
    }
    if(_calledSSNs.count > 0)
    {
        return NO;
    }
    if(_calledOpcodes.count > 0)
    {
        return NO;
    }
    if(_appContexts)
    {
        return NO;
    }
    return YES;
}

+ (UMDbTableDefinition *)routingTableEntryDbDefinition
{
    UMDbTableDefinition *ttTableDef = [[UMDbTableDefinition alloc] init];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"key"
                       size:255
                  canBeNull:NO
                    indexed:YES
                    primary:YES
                        tag:1]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"translation_table"
                           size:255
                      canBeNull:NO
                        indexed:YES
                        primary:YES
                            tag:1]] ;
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithInteger:@"gta"
                      canBeNull:NO
                        indexed:YES
                        primary:YES
                            tag:2]] ;
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"destination"
                       size:255
                  canBeNull:YES
                    indexed:YES
                    primary:NO
                        tag:3]];

    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"post_translation"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:4]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"gt_owner"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:5]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"gt_user"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:6]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"transaction_id_start"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:7]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"transaction_id_end"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:8]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"transaction_id_range"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:9]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"ssn"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:10]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"opcode"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:11]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"application_context"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:12]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"last_modified_ts"
                       size:32
                  canBeNull:YES
                    indexed:YES
                    primary:NO
                        tag:13]];
    return ttTableDef;
}
@end
