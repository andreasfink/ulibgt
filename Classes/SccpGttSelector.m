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
#import "SccpGttRoutingTable.h"

@implementation SccpGttSelector


@synthesize defaultEntry;

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
    }
    return self;
}


- (NSString *)selectorKey
{
    return [SccpGttSelector selectorKeyForTT:_tt gti:_gti np:_np nai:_nai internalOnly:_internal externalOnly:_external];
}

+ (NSString *)selectorKeyForTT:(int)tt gti:(int)gti np:(int)np nai:(int)nai  internalOnly:(int)internalOnly externalOnly:(int)externalOnly
{
    NSString *key;
    if(gti==2)
    {
        if(internalOnly)
        {
            return [NSString stringWithFormat:@"tt %d gti 2 internal",tt];
        }
        else if(externalOnly)
        {
            return [NSString stringWithFormat:@"tt %d gti 2 external",tt];
        }
        else
        {
            return [NSString stringWithFormat:@"tt %d gti 2",tt];
        }
    }
    else
    {
        if(internalOnly)
        {
            return [NSString stringWithFormat:@"tt %d gti %d np %d nai %d internal",tt,gti,np,nai];
        }
        else if(externalOnly)
        {
            return [NSString stringWithFormat:@"tt %d gti %d np %d nai %d external",tt,gti,np,nai];
        }
        return [NSString stringWithFormat:@"tt %d gti %d np %d nai %d",tt,gti,np,nai];
    }
}


-(SccpNextHop *) routeToProvider:(NSString *)digits
{
    SccpGttRoutingTableEntry *routingTableEntry = [_routingTable findEntry:digits];

    SccpNextHop *nextHop = routingTableEntry.nextHop;
    if(nextHop == NULL)
    {
        nextHop = defaultEntry;
    }
    return nextHop;
}

@end
