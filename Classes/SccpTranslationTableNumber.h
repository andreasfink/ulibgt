//
//  SccpTranslationTableNumber.h
//  ulibgt
//
//  Created by Andreas Fink on 31.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

#import <ulib/ulib.h>

@interface SccpTranslationTableNumber : UMObject
{
    int tt;
}

- (SccpTranslationTableNumber *)initWithInt:(int)i;
- (NSString *)description;

@property(readwrite,assign) int tt;

@end