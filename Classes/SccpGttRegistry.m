//
//  SccpGttRegistry.m
//  ulibgt
//
//  Created by Andreas Fink on 29/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpGttRegistry.h"
#import "SccpGttSelector.h"

static SccpGttRegistry *g_registry;

@implementation SccpGttRegistry

- (SccpGttRegistry *)init
{
    self = [super init];
    if(self)
    {
        _entriesByKey = [[UMSynchronizedDictionary alloc]init];
        _entriesByName = [[UMSynchronizedDictionary alloc]init];
    }
    return self;
}

- (void)updateLogLevel:(UMLogLevel)newLogLevel
{
    _logLevel = newLogLevel;

    NSArray *keys = [_entriesByKey allKeys];
    for(NSString *key in keys)
    {
        SccpGttSelector *s =  _entriesByKey[key];
        if(s)
        {
            s.logLevel = newLogLevel;
        }
    }
}


- (void)updateLogFeed:(UMLogFeed *)newLogFeed
{
    [super setLogFeed:newLogFeed];

    NSArray *keys = [_entriesByKey allKeys];
    for(NSString *key in keys)
    {
        SccpGttSelector *s =  _entriesByKey[key];
        if(s)
        {
            s.logFeed = newLogFeed;
        }
    }
}

- (SccpGttSelector *)selectorForInstance:(NSString *)instance
                                      tt:(int)tt
                                     gti:(int)gti
                                      np:(int)np
                                     nai:(int)nai
{
    @synchronized (self)
    {
        NSString *key = [SccpGttSelector selectorKeyForTT:tt gti:gti np:np nai:nai];
        return _entriesByKey[key];
    }
    return NULL;
}

- (void)addEntry:(SccpGttSelector *)gsel
{
    gsel.logLevel   = self.logLevel;
    gsel.logFeed    = self.logFeed;
    NSString *key = gsel.selectorKey;
    _entriesByKey[key]=gsel;
    _entriesByName[gsel.name] = gsel;
}

- (void)updateEntry:(SccpGttSelector *)gsel
{
    NSArray *keys = [_entriesByKey allKeys];
    for(NSString *key in keys)
    {
        SccpGttSelector *sel = _entriesByKey[key];
        if([sel.name isEqualToString:gsel.name])
        {
            [_entriesByKey removeObjectForKey:key];
        }
    }
    [_entriesByName removeObjectForKey:gsel.name];
    [self addEntry:gsel];
}

- (void)removeEntry:(SccpGttSelector *)gsel
{
    NSString *key = gsel.selectorKey;
    [_entriesByKey removeObjectForKey:key];
    [_entriesByName removeObjectForKey:gsel.name];
}

- (NSArray *)listSelectorNames
{
    return [_entriesByName allKeys];
}

- (SccpGttSelector *)getSelectorByName:(NSString *)name;
{
    return _entriesByName[name];
}


- (void)initWithConfigLines:(NSArray *)lines
{
    /* this will process a cisco ITP style GTT configuration */
    /* first we look for config lines starting with "cs7" */

    NSCharacterSet *whitespace  = [UMObject whitespaceAndNewlineCharacterSet];

    for(NSString *line in lines)
    {
        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:whitespace];
        unichar firstChar = [trimmedLine characterAtIndex:0];
        if((firstChar == '!') || (firstChar='#'))
        {
            continue;
        }
    }
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    NSArray *arr = [self listSelectorNames];
    for(NSString *name in arr)
    {
        SccpGttSelector *sel = [self getSelectorByName:name];
        if(sel)
        {
            UMSynchronizedSortedDictionary *selectorConfig = [sel config];
            if(selectorConfig)
            {
                dict[name] = selectorConfig;
            }
        }
    }
    return dict;
}

@end
