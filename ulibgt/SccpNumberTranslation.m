//
//  SccpNumberTranslation.m
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpNumberTranslation.h"
#import "SccpAddress.h"
#import "SccpNumberTranslationEntry.h"

@implementation SccpNumberTranslation


- (SccpNumberTranslation *)initWithConfig:(NSDictionary *)cfg
{
    self = [super init];
    if(self)
    {
        if(cfg[@"name"])
        {
            _name = [cfg[@"name"] stringValue];
        }
        _entries = [[NSMutableArray alloc]init];
    }
    return self;
}

- (SccpNumberTranslation *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addEntry:(SccpNumberTranslationEntry *)entry
{
    [_entries addObject:entry];
}

- (SccpAddress *)translateAddress:(SccpAddress *)in newCallingTT:(NSNumber **)cpatt newCalledTT:(NSNumber **)cgatt;
{
    SccpAddress *addr = in;
    for(SccpNumberTranslationEntry *e in _entries)
    {
        SccpAddress *addr2 = [e translateAddress:addr newCallingTT:cpatt newCalledTT:cgatt];
        if(addr2)
        {
            addr = addr2;
            break;
        }
    }
    return addr;
}

- (SccpAddress *)translateAddress:(SccpAddress *)in
{
    SccpAddress *addr = in;
    for(SccpNumberTranslationEntry *e in _entries)
    {
        SccpAddress *addr2 = [e translateAddress:addr newCallingTT:NULL newCalledTT:NULL];
        if(addr2)
        {
            addr = addr2;
            break;
        }
    }
    return addr;
}

@end
