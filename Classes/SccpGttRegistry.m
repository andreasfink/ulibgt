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

- (void)initWithConfigLines:(NSArray *)lines
{
    /* this will process a cisco ITP style GTT configuration */
    /* first we look for config lines starting with "cs7" */

    NSCharacterSet *whitespace  = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSCharacterSet *quotes      = [NSCharacterSet characterSetWithCharactersInString:@"\""];

    NSMutableArray *configFileSections = [[NSMutableArray alloc]init];
    NSMutableArray *currentSection = [[NSMutableArray alloc]init];

    for(NSString *line in lines)
    {
        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:whitespace];
        unichar firstChar = [trimmedLine characterAtIndex:0];
        if((firstChar == '!') || (firstChar='#'))
        {
            continue;
        }




    }
    cs7 instance 0 gtt address-conversion E212_E214
    update in-address 000000 out-address 000000 np 7 nai 4  remove 6
    update in-address 20201 out-address 3097 np 7 nai 4  remove 5
    update in-address 20205 out-address 30694 np 7 nai 4  remove 5
    update in-address 20209 out-address 30699 np 7 nai 4  remove 5
    update in-address 20210 out-address 30693 np 7 nai 4  remove 5
    update in-address 20402 out-address 00000 np 7 nai 4  remove 5
    update in-address 20404 out-address 31654 np 7 nai 4  remove 5
    update in-address 20408 out-address 31653 np 7 nai 4  remove 5
    update in-address 20412 out-address 31626 np 7 nai 4  remove 5
    update in-address 20416 out-address 31624 np 7 nai 4  remove 5
    update in-address 20420 out-address 31628 np 7 nai 4  remove 5
    update in-address 20601 out-address 32475 np 7 nai 4  remove 5
    update in-address 20610 out-address 32495 np 7 nai 4  remove 5
    update in-address 20620 out-address 32486 np 7 nai 4  remove 5
}
@end
