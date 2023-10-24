//
//  SccpAddress.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>
#import <ulibmtp3/ulibmtp3.h>

#import <ulibgt/SccpAddressIndicator.h>
#import <ulibgt/SccpNatureOfAddressIndicator.h>
#import <ulibgt/SccpTypeOfNumberIndicator.h>
#import <ulibgt/SccpNumberPlanIndicator.h>
#import <ulibgt/SccpSubSystemNumber.h>
#import <ulibgt/SccpTranslationTableNumber.h>
#import <ulibgt/SccpVariant.h>

@interface SccpAddress : UMObject
{
    SccpAddressIndicator            *ai;
    SccpNatureOfAddressIndicator    *nai;
    SccpNumberPlanIndicator         *npi;
    SccpSubSystemNumber             *ssn;
    SccpTranslationTableNumber      *tt;
    NSString                        *address;
    UMMTP3PointCode                 *pc;
    NSNumber                        *_encodingScheme;
}

#define MAX_SCCP_DIGITS 64

@property(readwrite,strong)     SccpAddressIndicator            *ai;
@property(readwrite,strong)     SccpNatureOfAddressIndicator    *nai;
@property(readwrite,strong)     SccpNumberPlanIndicator         *npi;
@property(readwrite,strong)     SccpSubSystemNumber             *ssn;
@property(readwrite,strong)     SccpTranslationTableNumber      *tt;
@property(readwrite,strong)     NSString                        *address;
@property(readwrite,strong)     UMMTP3PointCode                 *pc;
@property(readwrite,strong)     NSNumber                        *encodingScheme;

- (void)setAiFromInt:(int)i;
- (void)setNaiFromInt:(int)i;
- (void)setNpiFromInt:(int)i;
- (void)setSsnFromInt:(int)i;
- (void)setTtFromInt:(int)i;
- (NSData *)encode:(SccpVariant) variant;
- (NSData *)encoded;
- (void)decodeItu:(NSData *)d;
- (void)decodeAnsi:(NSData *)d;
- (SccpAddress *)initWithItuData:(NSData *)data;
- (SccpAddress *)initWithAnsiData:(NSData *)data;
- (SccpAddress *)initWithData:(NSData *)data;

- (SccpAddress *)initWithHumanReadableString:(NSString *)msisdn variant:(UMMTP3Variant)var;
- (SccpAddress *)initWithHumanReadableString:(NSString *)msisdn sccpVariant:(SccpVariant)svar mtp3Variant:(UMMTP3Variant)m3var;
- (NSString *)country;

- (NSDictionary *)dictionaryValue;
- (UMSynchronizedSortedDictionary *)objectValue;
- (NSString *)debugDescription;

- (SccpAddress *)anyAddress;
+ (SccpAddress *)anyAddress;
- (SccpAddress *)anySsnAddress;

- (NSString *)stringValueE164;
@end

int sccp_digit_to_nibble(unichar digit, int def);
