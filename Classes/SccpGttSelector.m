//
//  SccpRoutingTable.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpGttSelector.h"
#import "SccpL3Provider.h"
#import "SccpApplicationGroup.h"
#import "SccpNextHop.h"
#import "SccpL3Provider.h"

@implementation SccpGttSelector

@synthesize sccp_instance;
@synthesize gtt_selector;
@synthesize tt;
@synthesize gti;
@synthesize np;
@synthesize nai;
@synthesize external;
@synthesize internal;


@synthesize defaultEntry;

-(SccpGttSelector *)initWithInstanceNameE164:(NSString *)name
{
    self = [super init];
    if(self)
    {
        self.sccp_instance = name;
        self.gti =4;
        self.np = 1;
        self.nai =4;
        self.external = 1;
    }
    return self;
}

-(SccpNextHop *) routeToProvider:(NSString *)digits
{
    SccpNextHop *entry = NULL;
    @synchronized(_entries)
    {
        if([_entries count]>0)
        {
            NSUInteger n = [digits length];
            while(n>0)
            {
                NSString *substring = [digits substringWithRange:NSMakeRange(0,n--)];
                entry = _entries[substring];
                if(entry)
                {
                    break;
                }
            }
        }
    }
    if(entry == NULL)
    {
        entry = defaultEntry;
    }
    return entry;
}

@end
