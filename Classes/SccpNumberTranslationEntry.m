//
//  SccpNumberTranslationEntry.m
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpNumberTranslationEntry.h"


#define SET_DICT_INTEGER(dict,name,value) \
if(dict[name]) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithInt:[o intValue]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithInt:[o[0] intValue]]; \
    } \
    else if([o isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithInt:[o intValue]]; \
    } \
}

#define SET_DICT_STRING(dict,name,value) \
if(dict[name]) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = o; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
         value = [((NSArray *)o) componentsJoinedByString:@";"]; \
    } \
}


@implementation SccpNumberTranslationEntry


- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"in-address",_inAddress);
    SET_DICT_STRING(dict,@"out-address",_outAddress);
    SET_DICT_INTEGER(dict,@"new-nai",_replacementNAI);
    SET_DICT_INTEGER(dict,@"new-np",_replacementNP);
    SET_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
}

- (SccpAddress *)translateAddress:(SccpAddress *)inAddr
{
    if(_inAddress)
    {

    }
}

@end
