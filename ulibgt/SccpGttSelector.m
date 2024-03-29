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
#import "SccpDestinationEntry.h"
#import "SccpGttRoutingTable.h"
#import "SccpNumberTranslation.h"
#import "SccpAddress.h"
#import "SccpDestinationGroup.h"

@implementation SccpGttSelector

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

-(SccpGttSelector *)initWithInstanceName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        _sccp_instance = name;
        _routingTable = [[SccpGttRoutingTable alloc]initWithName:name];
        _active=YES;
    }
    return self;
}

-(SccpGttSelector *)init
{
    self = [super init];
    if(self)
    {
        _routingTable = [[SccpGttRoutingTable alloc]initWithName:@"untitled"];
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

- (SccpGttRoutingTableEntry *)chooseNextHopWithL3RoutingTable:(SccpL3RoutingTable *)rt
                                                  destination:(SccpAddress **)dst
                                                       source:(SccpAddress *)src
                                              incomingLinkset:(NSString *)incomingLinkset
                                            transactionNumber:(NSNumber *)tid
                                                    operation:(NSNumber *)op
                                                   appContext:(NSString *)ac
{
    SccpAddress *addr = *dst;
    if(_preTranslation)
    {
        NSNumber *newCallingTT;
        NSNumber *newCalledTT;
        SccpAddress *addr2 = [_preTranslation translateAddress:addr newCallingTT:&newCallingTT newCalledTT:&newCalledTT];
        if(newCalledTT)
        {
            addr.tt.tt = newCalledTT.intValue;
        }
        if(newCallingTT)
        {
            src.tt.tt = newCallingTT.intValue;
        }
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"pre-translation: %@->%@",addr,addr2]];
        }
        addr = addr2;
    }
    NSString *digits = addr.address;
    NSNumber *ssn = @(addr.ssn.ssn);
    SccpDestinationEntry *nextHop = NULL;
    SccpGttRoutingTableEntry *routingTableEntry = [_routingTable findEntryByDigits:digits
                                                                 transactionNumber:tid
                                                                               ssn:ssn
                                                                         operation:op
                                                                        appContext:ac];
    if(routingTableEntry==NULL)
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"no routing table defined in findEntryByDigits:%@ returns NULL. Taking default route",digits]];
        }
        nextHop = NULL;
    }
    else
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"_routingTable findEntryByDigits:%@ returns routingTableEntry:%@",digits,routingTableEntry.name]];
        }

        [routingTableEntry.incomingSpeed increase];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"routingTable.routeTo = %@",routingTableEntry.routeTo]];
        }
    }
    if(_postTranslation)
    {
        SccpAddress *addr2 = [_postTranslation translateAddress:addr];
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"post-translation: %@->%@",addr,addr2]];
        }
        addr = addr2;
    }
    if(nextHop.changeGti)
    {
        addr.ai.globalTitleIndicator = [nextHop.changeGti intValue];
    }
    if(nextHop.changeNai)
    {
        addr.nai.nai = [nextHop.changeNai intValue];
    }
    if(nextHop.changeNpi)
    {
        addr.npi.npi = [nextHop.changeNpi intValue];
    }
    if(nextHop.changeEncoding)
    {
        addr.encodingScheme = nextHop.changeEncoding;
    }
    if(nextHop.changeNational)
    {
        addr.ai.nationalReservedBit = [nextHop.changeNational boolValue];
    }
    
    if(nextHop.removeDigits)
    {
        addr.address = [addr.address substringFromIndex:nextHop.removeDigits.intValue];
    }
    if(nextHop.addPrefix)
    {
        addr.address = [NSString stringWithFormat:@"%@%@",nextHop.addPrefix,addr.address];
    }
    if(nextHop.addPostfix)
    {
        addr.address = [NSString stringWithFormat:@"%@%@",addr.address,nextHop.addPostfix];
    }
    
    if(nextHop.limitDigitLength)
    {
        if(addr.address.length > [nextHop.limitDigitLength integerValue])
        {
            addr.address = [addr.address substringToIndex:[nextHop.limitDigitLength integerValue]];
        }
    }
    *dst = addr;
    
    return routingTableEntry;
}


- (SccpGttRoutingTableEntry *)findNextHopForDestination:(SccpAddress *)dst
                                      transactionNumber:(NSNumber *)tid
                                                    ssn:(NSNumber *)ssn
                                              operation:(NSNumber *)op
                                             appContext:(NSString *)ac
{
    NSString *digits = dst.address;
    SccpGttRoutingTableEntry *routingTableEntry = [_routingTable findEntryByDigits:digits
                                                                 transactionNumber:tid
                                                                               ssn:ssn
                                                                         operation:op
                                                                        appContext:ac];
    if(routingTableEntry==NULL)
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"[_routingTable findEntryByDigits:'%@'] returns NULL",digits]];
        }
        return NULL;
    }
    else
    {
        if(self.logLevel <= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@"[_routingTable findEntryByDigits:'%@'] returns %@",digits,routingTableEntry]];
        }
        [routingTableEntry.incomingSpeed increase];
    }
    return routingTableEntry;
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
	dict[@"active"] = @(_active);
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

