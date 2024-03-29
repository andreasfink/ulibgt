//
//  SccpNumberTranslationEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibgt/SccpAddress.h>

@interface SccpNumberTranslationEntry : UMObject
{
    NSString *_inAddress;
    NSString *_outAddress;
    NSNumber *_replacementNAI;
    NSNumber *_replacementTT;
    NSNumber *_replacementCallingPartyTT;
    NSNumber *_replacementCalledPartyTT;
    NSNumber *_replacementNP;
    NSNumber *_removeDigits;
    NSString *_appendDigits;
}

- (SccpNumberTranslationEntry *)initWithConfig:(NSDictionary *)cfg;

@property(readwrite,strong,atomic)  NSString *inAddress;
@property(readwrite,strong,atomic)  NSString *outAddress;
@property(readwrite,strong,atomic)  NSNumber *replacementTT;
@property(readwrite,strong,atomic)  NSNumber *replacementCallingPartyTT;
@property(readwrite,strong,atomic)  NSNumber *replacementCalledPartyTT;
@property(readwrite,strong,atomic)  NSNumber *replacementNAI;
@property(readwrite,strong,atomic)  NSNumber *replacementNP;
@property(readwrite,strong,atomic)  NSNumber *removeDigits;
@property(readwrite,strong,atomic)  NSString *appendDigits;

- (SccpAddress *)translateAddress:(SccpAddress *)inAddr;
- (SccpAddress *)translateAddress:(SccpAddress *)in newCallingTT:(NSNumber **)cpatt newCalledTT:(NSNumber **)cgatt;
@end
