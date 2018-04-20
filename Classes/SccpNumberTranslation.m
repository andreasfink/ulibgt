//
//  SccpNumberTranslation.m
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpNumberTranslation.h"

@implementation SccpNumberTranslation

- (SccpAddress *)translateAddress:(SccpAddress *)in
{
    SccpAddress *addr = in;
    for(SccpNumberTranslationEntry *e in _entries)
    {
        addr = [e translateAddress:addr];
    }
    return addr;
}

@end
