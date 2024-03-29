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
#import "SccpGttRoutingTable.h"
#import "SccpDestinationGroup.h"
#import "SccpDestinationEntry.h"

static SccpGttRegistry *g_registry;

@implementation SccpGttRegistry

- (SccpGttRegistry *)init
{
    self = [super init];
    if(self)
    {
        _entriesByKey = [[UMSynchronizedDictionary alloc]init];
        _entriesByName = [[UMSynchronizedDictionary alloc]init];
        _sccp_number_translations_dict = [[UMSynchronizedDictionary alloc]init];
        _sccp_destinations_dict = [[UMSynchronizedDictionary alloc]init];
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
        if((firstChar == '!') || (firstChar=='#'))
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

- (void)finishUpdate
{
    NSArray *arr = [self listSelectorNames];
    for(NSString *name in arr)
    {
        SccpGttSelector *sel = [self getSelectorByName:name];
        if(sel)
        {
            [sel.routingTable entriesToDigitTree];

            if(sel.preTranslationName.length > 0)
            {
                sel.preTranslation = _sccp_number_translations_dict[sel.preTranslationName];
            }
            if(sel.postTranslationName.length > 0)
            {
                sel.postTranslation = _sccp_number_translations_dict[sel.postTranslationName];
            }
        }
    }
    for(NSString *name in  _sccp_destinations_dict.allKeys)
    {
        SccpDestinationGroup *grp = _sccp_destinations_dict[name];
        if(grp.postTranslationName.length > 0)
        {
            grp.postTranslation = _sccp_number_translations_dict[grp.postTranslationName];
        }
        UMSynchronizedArray *entries = grp.entries;
        for(SccpDestinationEntry *e in entries)
        {
            if(e.postTranslationName.length > 0)
            {
                e.postTranslation = _sccp_number_translations_dict[e.postTranslationName];
            }
        }
    }
        
}

- (SccpNumberTranslation *)numberTranslationByName:(NSString *)name
{
    return _sccp_number_translations_dict[name];
}

- (SccpDestinationGroup *)getDestinationGroupByName:(NSString *)name;
{
    return _sccp_destinations_dict[name];
}

- (void)addDestinationGroup:(SccpDestinationGroup *)grp
{
    if(grp.name)
    {
        _sccp_destinations_dict[grp.name] = grp;
    }
}

- (void)removeDestinationGroup:(NSString *)name
{
    [_sccp_destinations_dict removeObjectForKey:name];
}

@end
