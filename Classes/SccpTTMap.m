//
//  SccpTTMap.m
//  ulibgt
//
//  Created by Andreas Fink on 27.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpTTMap.h"

@implementation SccpTTMap

- (SccpTTMap *)init
{
    self = [super init];
    if(self)
    {
        for(int i=0;i<256;i++)
        {
            _ttmap[i] = 0;
        }
    }
    return self;
}

- (void)setMap:(int)in to:(int)to
{
    @synchronized(self)
    {
        if((in>=0) && (in < 256))
        {
            _ttmap[in] = to;
        }
    }
}

- (int)map:(int)in
{
    @synchronized(self)
    {
        return _ttmap[in];
    }
}

@end
