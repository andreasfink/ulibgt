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


- (SccpNumberTranslationEntry *)initWithConfig:(NSDictionary *)cfg
{
    self = [super init];
    if(self)
    {
        [self setConfig:cfg];
    }
    return self;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"in-address",_inAddress);
    SET_DICT_STRING(dict,@"out-address",_outAddress);
    SET_DICT_INTEGER(dict,@"new-tt",_replacementTT);
    SET_DICT_INTEGER(dict,@"new-nai",_replacementNAI);
    SET_DICT_INTEGER(dict,@"new-np",_replacementNP);
    SET_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
    SET_DICT_STRING(dict,@"append-digits",_appendDigits);
    SET_DICT_INTEGER(dict,@"new-calling-party-tt",_replacementCallingPartyTT);
    SET_DICT_INTEGER(dict,@"new-called-party-tt",_replacementCalledPartyTT);
}

- (SccpAddress *)translateAddress:(SccpAddress *)in
{
    return [self translateAddress:in newCallingTT:NULL newCalledTT:NULL];
}

- (SccpAddress *)translateAddress:(SccpAddress *)in newCallingTT:(NSNumber **)callingPartyTT newCalledTT:(NSNumber **)calledPartyTT

{
    BOOL doTranslate = NO;
    //NSString *matchingDigits;
    NSString *remainingDigits;
    
    if(_inAddress)
    {
        if([in.address hasPrefix:_inAddress])
        {
            /* a matching entry */
            //matchingDigits = _inAddress;
            remainingDigits =  [in.address substringFromIndex:_inAddress.length];
            doTranslate = YES;
        }
    }
    else
    {
        /* a default entry */
        //matchingDigits = @"";
        remainingDigits = in.address;
        doTranslate = YES;
    }
    if(doTranslate == NO)
    {
        return NULL;
    }
    
    SccpAddress *out = [in copy];

    NSString *outStr = [NSString stringWithFormat: @"%@%@",_outAddress ,remainingDigits];
    if(_removeDigits)
    {
        outStr = [[outStr substringFromIndex:_removeDigits.integerValue] mutableCopy];
    }
    out.address = outStr;

    if(_replacementNP)
    {
        if(out.npi == NULL)
        {
            out.npi = [[SccpNumberPlanIndicator alloc]init];
        }
        out.npi.npi = _replacementNP.intValue;
    }
    if(_replacementNAI)
    {
        if(out.nai ==NULL)
        {
            out.nai = [[SccpNatureOfAddressIndicator alloc]init];
        }
        out.nai.nai = _replacementNAI.intValue;
    }
    
    if(_appendDigits)
    {
        out.address = [NSString stringWithFormat:@"%@%@",out.address,_appendDigits];
    }
    if(_replacementTT)
    {
        out.tt = [[SccpTranslationTableNumber alloc]initWithInt:_replacementTT.intValue];
    }
    if(_replacementCallingPartyTT)
    {
        if(callingPartyTT)
        {
            *callingPartyTT = [_replacementCallingPartyTT copy];
        }
    }
    if(_replacementCalledPartyTT)
    {
        if(calledPartyTT)
        {
            *calledPartyTT = [_replacementCalledPartyTT copy];
        }
    }
    return out;
}



@end
