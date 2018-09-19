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
        _entries = [[UMSynchronizedDictionary alloc]init];
    }
    return self;
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
        return _entries[key];
    }
    return NULL;
}

- (void)addEntry:(SccpGttSelector *)gsel
{
    @synchronized(self)
    {
        NSString *key = gsel.selectorKey;
        _entries[key]=gsel;
    }
}

- (void)removeEntry:(SccpGttSelector *)gsel
{
    @synchronized(self)
    {
        NSString *key = gsel.selectorKey;
		[_entries removeObjectForKey:key];
    }
}

- (void)initWithConfigLines:(NSArray *)lines
{
    /* this will process a cisco ITP style GTT configuration */
    /* first we look for config lines starting with "cs7" */

    NSCharacterSet *whitespace  = [NSCharacterSet whitespaceAndNewlineCharacterSet];

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
@end
