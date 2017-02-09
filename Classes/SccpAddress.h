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

#import "SccpAddressIndicator.h"
#import "SccpNatureOfAddressIndicator.h"
#import "SccpTypeOfNumberIndicator.h"
#import "SccpNumberPlanIndicator.h"
#import "SccpSubSystemNumber.h"
#import "SccpTranslationTableNumber.h"
#import "SccpVariant.h"

@interface SccpAddress : UMObject
{
    SccpAddressIndicator            *ai;
    SccpNatureOfAddressIndicator    *nai;
    SccpNumberPlanIndicator         *npi;
    SccpSubSystemNumber             *ssn;
    SccpTranslationTableNumber      *tt;
    NSString                        *address;
    UMMTP3PointCode                 *pc;
}

#define MAX_SCCP_DIGITS 64

@property(readwrite,strong)     SccpAddressIndicator            *ai;
@property(readwrite,strong)     SccpNatureOfAddressIndicator    *nai;
@property(readwrite,strong)     SccpNumberPlanIndicator         *npi;
@property(readwrite,strong)     SccpSubSystemNumber             *ssn;
@property(readwrite,strong)     SccpTranslationTableNumber      *tt;
@property(readwrite,strong)     NSString                        *address;
@property(readwrite,strong)     UMMTP3PointCode                 *pc;

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
- (SccpAddress *)initWithHumanReadableString:(NSString *)msisdn;
- (NSDictionary *)dictionaryValue;
- (UMSynchronizedSortedDictionary *)objectValue;
- (NSString *)debugDescription;

- (SccpAddress *)anyAddress;
+ (SccpAddress *)anyAddress;
- (SccpAddress *)anySsnAddress;
@end
