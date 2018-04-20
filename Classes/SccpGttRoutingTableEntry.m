//
//  SccpGttRoutingTableEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpGttRoutingTableEntry.h"

@implementation SccpGttRoutingTableEntry

- (SccpGttRoutingTableEntry *)initWithConfig:(NSDictionary *)cfg
{
    self = [super init];
    if(self)
    {
        if(cfg[@"gta"])
        {
            _digits = [cfg[@"gta"] stringValue];
        }

        if(cfg[@"destination"])
        {
            _routeToName = [cfg[@"destination"] stringValue];
        }
        if(cfg[@"post-translation"])
        {
            _postTranslationName = [cfg[@"post-translation"] stringValue];
        }
    }
    return self;
}
@end
