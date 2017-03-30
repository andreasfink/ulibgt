//
//  SccpTTMap.h
//  ulibgt
//
//  Created by Andreas Fink on 27.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

@interface SccpTTMap : UMObject
{
    int _ttmap[256];
}

- (void)setMap:(int)in to:(int)to;
- (int)map:(int)in;

@end
