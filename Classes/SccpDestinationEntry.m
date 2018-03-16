//
//  SccpDestinationEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpDestinationEntry.h"

#import <ulibmtp3/ulibmtp3.h>

@implementation SccpDestinationEntry

- (SccpDestinationEntry *)init
{
    self = [super init];
    if(self)
    {
        _priority = 5;
        _weight   = 100;
    }
    return self;
}


@end
