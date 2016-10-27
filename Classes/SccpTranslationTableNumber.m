//
//  SccpTranslationTableNumber
//  ulibgt
//
//  Created by Andreas Fink on 31.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

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
