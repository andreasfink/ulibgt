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
        entries = [[UMSynchronizedDictionary alloc]init];
    }
    return self;
}

+(SccpGttRegistry *)sharedInstance
{
    @synchronized(self)
    {
        if(g_registry == NULL)
        {
            g_registry = [[SccpGttRegistry alloc]init];
        }
    }
    return g_registry;
}
- (SccpGttSelector *)selectorForInstance:(NSString *)instance
                                      tt:(int)tt
                                     gti:(int)gti
                                      np:(int)np
                                     nai:(int)nai
                            internalOnly:(BOOL)internal_only
                            externalOnly:(BOOL)external_only
{
    NSArray *keys = [entries allKeys];
    for(id key in keys)
    {
        SccpGttSelector *entry = entries[key];
        if(!entry)
        {
            continue;
        }
        if(![entry.sccp_instance isEqualToString:instance])
        {
            continue;
        }
        if(entry.tt != tt)
        {
            continue;
        }
        if(entry.gti != gti)
        {
            continue;
        }
        if(gti == 4)
        {
            if(entry.np != np)
            {
                continue;
            }
            if(entry.nai != nai)
            {
                continue;
            }
        }
        if(internal_only  && (entry.internal == 0))
        {
            continue;
        }
        if(external_only  && (entry.external  == 0))
        {
            continue;
        }
        return entry;
    }
    return NULL;
}

- (void)addEntry:(SccpGttSelector *)sel
{
    NSString *key = sel.gtt_selector;
    entries[key]=sel;
}

@end
