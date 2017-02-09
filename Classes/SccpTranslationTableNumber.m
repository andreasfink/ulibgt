//
//  SccpTranslationTableNumber
//  ulibgt
//
//  Created by Andreas Fink on 31.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpTranslationTableNumber.h"

@implementation SccpTranslationTableNumber

@synthesize tt;

- (SccpTranslationTableNumber *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        tt = i;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"TT_%d",tt];
}

@end
