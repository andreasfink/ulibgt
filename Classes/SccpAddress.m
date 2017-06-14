//  SccpAddress.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpAddress.h"
#import <ulibmtp3/ulibmtp3.h>

static int is_all_digits(const char *text, int startpos, unsigned long len);

int sccp_digit_to_nibble(int digit, int def)
{
    switch(digit)
    {
        case '0':
            return 0;
        case '1':
            return 1;
        case '2':
            return 2;
        case '3':
            return 3;
        case '4':
            return 4;
        case '5':
            return 5;
        case '6':
            return 6;
        case '7':
            return 7;
        case '8':
            return 8;
        case '9':
            return 9;
        case 'A':
        case 'a':
        case '*':
            return 0x0A;
        case 'B':
        case 'b':
        case '#':
            return 0x0B;
        case 'C':
        case 'c':
            return 0x0C;
        case 'D':
        case 'd':
            return 0x0d;
        case 'E':
        case 'e':
            return 0x0E;
        case 'F':
        case 'f':
            return 0x0F;
    }
    return def;
}


@implementation SccpAddress

@synthesize ai;
@synthesize nai;
//@synthesize ton;
@synthesize npi;
@synthesize ssn;
@synthesize pc;
@synthesize address;
@synthesize tt;

- (SccpAddress *)init
{
    self = [super init];
    if(self)
    {
        [self genericIntialisation];
    }
    return self;
}

- (void)genericIntialisation
{
    ai = [[SccpAddressIndicator alloc]init];
    nai = [[SccpNatureOfAddressIndicator alloc]init];
    npi = [[SccpNumberPlanIndicator alloc]init];
    ssn = [[SccpSubSystemNumber alloc]init];
    tt = [[SccpTranslationTableNumber alloc]init];
    address = @"";
    pc = NULL;
}
- (SccpAddress *)initWithItuData:(NSData *)data
{
    self = [super init];
    if(self)
    {
        [self genericIntialisation];
        [self decodeItu:data];
    }
    return self;
}

- (SccpAddress *)initWithData:(NSData *)data
{
    self = [super init];
    if(self)
    {
        [self genericIntialisation];
        [self decodeItu:data];
    }
    return self;
}

- (SccpAddress *)initWithAnsiData:(NSData *)data
{
    self = [super init];
    if(self)
    {
        [self genericIntialisation];
        [self decodeAnsi:data];
    }
    return self;
}

- (void)setAiFromInt:(int)i
{
    ai = [[SccpAddressIndicator alloc]initWithInt:i];
}

- (void)setNaiFromInt:(int)i
{
    nai = [[SccpNatureOfAddressIndicator alloc]initWithInt:i];

}

- (void)setNpiFromInt:(int)i
{
    npi = [[SccpNumberPlanIndicator alloc]initWithInt:i];

}

- (void)setSsnFromInt:(int)i
{
    ssn = [[SccpSubSystemNumber alloc]initWithInt:i];
    ai.subSystemIndicator = YES;
}

- (void)setTtFromInt:(int)i
{
    tt = [[SccpTranslationTableNumber alloc]initWithInt:i];
}

- (NSData *)encoded
{
    if(ai.nationalReservedBit)
    {
        return [self encode:SCCP_VARIANT_ANSI];
    }
    else
    {
        return [self encode:SCCP_VARIANT_ITU];
    }
}

- (NSData *)encode:(SccpVariant)variant
{
    int	i = 0;
    NSUInteger len = 0;
    int c1 = 0;
    int c2 = 0;
    int	odd = 0;
    
    int gt_pres = 0;
    int nai_pres = 0;
    int np_pres = 0;
    int tt_pres = 0;
    int en_pres = 0;
    
    NSMutableData *packet = [[NSMutableData alloc]init];

    if(nai)
    {
        nai_pres=1;
    }
    if(npi)
    {
        np_pres = 1;
    }
    if(tt)
    {
        tt_pres = 1;
    }
    if(address)
    {
        gt_pres=1;
        ai.routingIndicatorBit = NO;
    }

    if((variant==SCCP_VARIANT_ITU) && (nai_pres) && (np_pres) && (gt_pres) &&(tt_pres) )
    {
        ai.nationalReservedBit=NO;
        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
    }
    else if((variant==SCCP_VARIANT_ITU) && (np_pres) && (gt_pres) &&(tt_pres) )
    {
        ai.nationalReservedBit=NO;
        ai.globalTitleIndicator = SCCP_GTI_ITU_TT_NP_ENCODING;
    }
    else if((variant==SCCP_VARIANT_ITU) && (tt_pres))
    {
        ai.nationalReservedBit=NO;
        ai.globalTitleIndicator = SCCP_GTI_ITU_TT_ONLY;
    }
    else if((variant==SCCP_VARIANT_ITU) && (nai_pres))
    {
        ai.nationalReservedBit=NO;
        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_ONLY;
    }

    else if((variant==SCCP_VARIANT_ANSI) && (np_pres))
    {
        ai.nationalReservedBit=YES;
        ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
    }
    else if(variant==SCCP_VARIANT_ANSI)
    {
        ai.nationalReservedBit=YES;
        ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_ONLY;
    }

    if(pc)
    {
        ai.pointCodeIndicator = YES;
    }
    if(ssn)
    {
        ai.subSystemIndicator = YES;
    }

    if(variant==SCCP_VARIANT_ANSI)
    {
        ai.nationalReservedBit=YES;
        [packet appendByte:[ai addressIndicatorANSI]];
    }
    else
    {
        ai.nationalReservedBit=NO;
        [packet appendByte:[ai addressIndicatorITU]];
    }

    int gti = ai.globalTitleIndicator;
    if(variant == SCCP_VARIANT_ITU)
    {
        switch(gti)	/* bits 6,5,4,3 according to Q.731 page 8 */
        {
            case SCCP_GTI_NONE:
                gt_pres = 0;
                break;
            case SCCP_GTI_ITU_NAI_ONLY:
                gt_pres = 1;
                nai_pres = 1;
                break;
            case SCCP_GTI_ITU_TT_ONLY:
                gt_pres = 1;
                tt_pres = 1;
                np_pres = 0;
                nai_pres = 0;
                break;
            case SCCP_GTI_ITU_TT_NP_ENCODING:
                gt_pres = 1;
                tt_pres = 1;
                np_pres = 1;
                en_pres = 1;
                break;
            case SCCP_GTI_ITU_NAI_TT_NPI_ENCODING:
                tt_pres = 1;
                np_pres = 1;
                nai_pres = 1;
                en_pres = 1;
                break;
            default:
                gt_pres = 0;
        }
    }
    else if(variant == SCCP_VARIANT_ANSI)
    {
        switch(gti)
        {
        case SCCP_GTI_NONE:
            gt_pres = 0;
            break;
        case SCCP_GTI_ANSI_TT_NP_ENCODING:
            tt_pres = 1;
            np_pres = 1;
            en_pres = 1;
            break;
        case SCCP_GTI_ANSI_TT_ONLY:
            tt_pres = 1;
            gt_pres = 0;
            break;
        default:
            gt_pres = 0;
        }
    }
    
    /* pointcode */
    if(ai.pointCodeIndicator)
    {
        int dpc = pc.pc;
        if(variant == SCCP_VARIANT_ITU)
        {
            [packet appendByte:(dpc & 0xFF)];
            [packet appendByte:((dpc >> 8) & 0x3F)];
        }
        else if(variant == SCCP_VARIANT_ANSI)
        {
            [packet appendByte:(dpc & 0xFF)];
            [packet appendByte:((dpc >> 8) & 0xFF)];
            [packet appendByte:((dpc >> 16) & 0xFF)];
        }
    }
    
    /* subsystem number */
    if(ai.subSystemIndicator)
    {
        uint8_t byte = ssn.ssn;
        [packet appendByte:byte];
    }
    else
    {
        [packet appendByte:0];
    }
    
    /* translation type */
    if(tt_pres)
    {
        uint8_t byte = tt.tt;
        [packet appendByte:byte];
    }
    
    len = [address length];
    const char *addr = (const char *)address.UTF8String;
    
    odd = len % 2;
    
    /* number plan present */
    if(np_pres)
    {
        if(odd)
        {
            [packet appendByte:(((npi.npi & 0x0F) << 4) | 0x01)]; /* encoding BCD odd */
        }
        else
        {
            [packet appendByte:(((npi.npi & 0x0F) << 4) | 0x02)]; /* encoding BCD even */
        }
    }
    
    /* nature of address indicator */
    if(nai_pres)
    {
        if((odd==1) & !np_pres)
        {
            [packet appendByte:((nai.nai & 0x7F) | 0x80)];
        }
        else
        {
            [packet appendByte:(nai.nai & 0x7F)];
        }
    }

    if(nai.nai == SCCP_NAI_ALPHANUMERIC)
    {
        NSData *addressData = [address unhexedData];
        [packet appendData:addressData];
    }
    else
    {
        for(i=0;i<len;i++)
        {
            if( (i % 2) == 0)
            {
                c1 = sccp_digit_to_nibble(addr[i],0);
            }
            else
            {
                c2 = sccp_digit_to_nibble(addr[i],0);
                [packet appendByte:(c2 << 4 | c1)];
            }
        }
    }
    if(odd)
    {
        c2 = 0x00;
        [packet appendByte:(c2 << 4 | c1)];
    }
    
    return packet;
}

- (void)decode:(NSData *)pdu
{
    const uint8_t *bytes = pdu.bytes;
    if(bytes[0] & 0x80)
    {
        [self decodeAnsi:pdu];
    }
    else
    {
        [self decodeItu:pdu];
    }
}

- (void)decodeItu:(NSData *)pdu
{
    NSUInteger	len = 0;
    int a=0;
    int b=0;
    int	odd = 0;
    int x = 0;
    int k=0;
    const char hex[]="0123456789ABCDEF";

    len = pdu.length;
    if(len==0)
    {
        @throw([NSException exceptionWithName:@"INVALID_SCCP_ADDRESS" reason:NULL userInfo:@{@"backtrace": UMBacktrace(NULL,0)}] );
    }
    /* first we get the indicator 			*/
    /* bit 8: national bit                  */
    /* bit 7: routing indicator 			*/
    /* bit 6,5,4,3 global title indicator	*/
    /* bit 2: SSN present			(bit 1 & 2 are swapped in ansi */
    /* bit 1: point code present 			*/

    int p=0;
    const uint8_t *bytes = pdu.bytes;
    [self setAiFromInt:bytes[p++]];

    /* first in order is pointcode if present */
    if(ai.pointCodeIndicator)	/* pointcode present */
    {
        int pc1 = bytes[p++];
        int pc2 = bytes[p++];
        int pc0 = pc1 + ((pc2 & 0x3F )<<8);
        pc =[[UMMTP3PointCode alloc]initWitPc:pc0 variant:UMMTP3Variant_ITU];
    }
    else
    {
        pc = NULL;
    }

    if(ai.subSystemIndicator)	/* ssn present */
    {
        ssn = [[SccpSubSystemNumber alloc]initWithInt:bytes[p++]];
    }
    else
    {
        ssn = NULL;
    }

    if(ai.nationalReservedBit)
    {
        /* this is now ANSI stuff */
        switch(ai.globalTitleIndicator)
        {
            case 0:	/* no GTT present */
                break;
            case 1: /* GTT includes translation type , numbering plan & encoding, digits */
                tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
                x = bytes[p++];
                npi = [[SccpNumberPlanIndicator alloc]initWithInt:((x & 0xF0) > 4)];
                int encoding = (x & 0x0F);
                odd = (encoding & 0x01);
                return;
            case 2: /* GT include tt only */
                tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
                /* the number encoding is national specific */
                /* so we simply get the digits as usual and read including filler F's */
                odd = 0;
                break;
        }
    }
    else
    {
        switch(ai.globalTitleIndicator)
        {
            case 0:	/* no GTT present */
                break;
            case 1: /* GTT includes nature of address only */
                /* 0 = unknown						*/
                /* 1 = subscriber					*/
                /* 2 = reserved national			*/
                /* 3 = national significant number	*/
                /* 4 = international number 		*/
                x = bytes[p++];
                odd = (x & 0x80);
                nai = [[SccpNatureOfAddressIndicator alloc]initWithInt:( bytes[p++] & 0x7F)];
                return;
            case 2: /* GT include tt only */
                tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];

                /* the number encoding is national specific */
                /* so we simply get the digits as usual and read including filler F's */
                odd = 0;
                break;

            case 3: /* GT include tt npi and encoding */
                tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
                x = bytes[p++];
                npi = [[SccpNumberPlanIndicator alloc]initWithInt:((x & 0xF0) > 4)];
                odd = ((x & 0x0F) == 1);
                break;

            case 4: /* GT include tt npi encoding and nai(ton) */
                tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
                x = bytes[p++];
                npi = [[SccpNumberPlanIndicator alloc]initWithInt:((x & 0xF0) > 4)];
                odd = ((x & 0x0F) == 1);
                nai = [[SccpNatureOfAddressIndicator alloc]initWithInt:( bytes[p++] & 0x7F)];
                break;
        }
    }

    uint8_t addr[MAX_SCCP_DIGITS+2];
    memset(addr,0x00,sizeof(addr));
    k=0;
    while (p < pdu.length)
    {
        x = bytes[p++];
        b = (x & 0xF0) >> 4;
        a = x & 0x0F;

        if(k < MAX_SCCP_DIGITS)
        {
            addr[k++] = hex[a];
        }
        if(k < MAX_SCCP_DIGITS)
        {
            addr[k++] = hex[b];
        }
    }
    addr[k] = '\0';
    if((odd) && (k>0))
    {
        addr[--k] = '\0';
    }
    address = [NSString stringWithUTF8String:(const char *)&addr[0]];
}

- (void)decodeAnsi:(NSData *)pdu
{
    NSUInteger	len = 0;
    int a=0;
    int b=0;
    int	odd = 0;
    int x = 0;
    int k=0;
    const char hex[]="0123456789ABCDEF";
    
    len = pdu.length;
    if(len==0)
    {
        @throw([NSException exceptionWithName:@"INVALID_SCCP_ADDRESS" reason:NULL userInfo:@{@"backtrace": UMBacktrace(NULL,0)}] );
    }
    /* first we get the indicator 			*/
    /* bit 8: national bit                  */
    /* bit 7: routing indicator 			*/
    /* bit 6,5,4,3 global title indicator	*/
    /* bit 2: SSN present			(bit 1 & 2 are swapped in ansi */
    /* bit 1: point code present 			*/
    
    int p=0;
    const uint8_t *bytes = pdu.bytes;
    [self setAiFromInt:bytes[p++]];
    
    /* first in order is pointcode if present */
    if(ai.pointCodeIndicator)	/* pointcode present */
    {
        int pc1 = bytes[p++];
        int pc2 = bytes[p++];
        int pc3 = bytes[p++];
        int pc0 = pc1 | (pc2<<8) | (pc3 << 16);
        pc =[[UMMTP3PointCode alloc]initWitPc:pc0 variant:UMMTP3Variant_ANSI];
    }
    else
    {
        pc = NULL;
    }
    
    if(ai.subSystemIndicator)	/* pointcode present */
    {
        ssn = [[SccpSubSystemNumber alloc]initWithInt:bytes[p++]];
    }
    else
    {
        ssn = NULL;
    }
    
    if(ai.nationalReservedBit != YES)
    {
        NSLog(@"huh. decodeANSI returns non national reserved bit being set?!?");
    }

    /* this is now ANSI stuff */
    switch(ai.globalTitleIndicator)
    {
        case 0:	/* no GTT present */
            break;
        case 1: /* GTT includes translation type , numbering plan & encoding, digits */
            tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
            x = bytes[p++];
            npi = [[SccpNumberPlanIndicator alloc]initWithInt:((x & 0xF0) > 4)];
            int encoding = (x & 0x0F);
            odd = (encoding & 0x01);
            return;
        case 2: /* GT include tt only */
            tt = [[SccpTranslationTableNumber alloc]initWithInt:bytes[p++]];
            /* the number encoding is national specific */
            /* so we simply get the digits as usual and read including filler F's */
            odd = 0;
            break;
    }
    
    k = 0;
    
    uint8_t addr[MAX_SCCP_DIGITS+2];
    memset(addr,0x00,sizeof(addr));
    k=0;
    while (p < pdu.length)
    {
        x = bytes[p++];
        b = (x & 0xF0) >> 4;
        a = x & 0x0F;
        
        if(k < MAX_SCCP_DIGITS)
        {
            addr[k++] = hex[a];
        }
        if(k < MAX_SCCP_DIGITS)
        {
            addr[k++] = hex[b];
        }
    }
    addr[k] = '\0';
    if((odd) && (k))
    {
        addr[--k] = '\0';
    }
    address = [NSString stringWithUTF8String:(const char *)&addr[0]];
}

- (SccpAddress *)initWithHumanReadableString:(NSString *)msisdn variant:(UMMTP3Variant)mvar
{
    SccpVariant svar;
    
    if(mvar == UMMTP3Variant_ANSI)
    {
        svar = SCCP_VARIANT_ANSI;
    }
    else
    {
        svar = SCCP_VARIANT_ITU;
    }
    return [self initWithHumanReadableString:msisdn sccpVariant:svar mtp3Variant:mvar];
}
            
- (SccpAddress *)initWithHumanReadableString:(NSString *)msisdn sccpVariant:(SccpVariant)svar mtp3Variant:(UMMTP3Variant)mvar
{
    self = [super init];
    if(self)
    {
        [self genericIntialisation];

        if([msisdn isEqualToString:@"any"])
        {
            nai.nai = SCCP_NAI_INTERNATIONAL;
            npi.npi = SCCP_NPI_ISDN_E164;
            ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
            address = @"any";
        }
        else
        {
            const char *str = msisdn.UTF8String;
            unsigned long len = msisdn.length;
            if( len > 1)
            {
                char c1 = str[0];
                if(c1 == '+')
                {
                    nai.nai = SCCP_NAI_INTERNATIONAL;
                    npi.npi = SCCP_NPI_ISDN_E164;
                    ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                    address = [msisdn substringFromIndex:1];
                }
                else if(len > 2)
                {
                    char c2 = str[1];
                    if((c1 == '0') && (c2 == '0'))
                    {
                        nai.nai = SCCP_NAI_INTERNATIONAL;
                        npi.npi = SCCP_NPI_ISDN_E164;
                        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        address = [msisdn substringFromIndex:2];
                    }
                    else if(c1 == '0')
                    {
                        nai.nai = SCCP_NAI_INTERNATIONAL;
                        npi.npi = SCCP_NPI_ISDN_E164;
                        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        address = [msisdn substringFromIndex:1];
                    }

                    else if(is_all_digits(str,0,len))
                    {
                        nai.nai = SCCP_NAI_UNKNOWN;
                        npi.npi = SCCP_NPI_ISDN_E164;
                        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        address = msisdn;
                    }
                    else if([msisdn hasPrefix:@"imsi:"])
                    {
                        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        npi.npi = SCCP_NPI_LAND_MOBILE_E212;
                        nai.nai= SCCP_NAI_INTERNATIONAL;
                        address = [msisdn substringFromIndex:5];
                    }
                    else if([msisdn hasPrefix:@"mgt:"])
                    {
                        ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        npi.npi = SCCP_NPI_ISDN_MOBILE_E214;
                        nai.nai= SCCP_NAI_INTERNATIONAL;
                        address = [msisdn substringFromIndex:4];
                    }
                    else if([msisdn hasPrefix:@"pc:"]) /* pointcode only */
                    {
                        /*
                            SYNTAX1:  pc:{pointcode}
                            SYNTAX2:  pc:{pointcode}:{address}
                            SYNTAX2b:  pc:{pointcode}:{+address}
                            SYNTAX3:  pc:{pointcode}:{npi}:{address}
                            SYNTAX4:  pc:{pointcode}:{nai}:{npi}:{address}

                        examples:
                            pc:1-99-1
                            pc:6283
                            pc:1-99-1:+173518158
                            pc:6283:0:1:173518158
                          */

                        address = NULL;
                        NSString *pcString = NULL;
                        msisdn = [msisdn substringFromIndex:3];
                        NSArray *components = [msisdn componentsSeparatedByString:@":"];
                        if([components count]==1)
                        {
                            /* syntax 1 pointcode */
                            if(svar == SCCP_VARIANT_ANSI)
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_ONLY;
                            }
                            else
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ITU_TT_ONLY;
                            }
                            pc = [[UMMTP3PointCode alloc]initWithString:components[0] variant: mvar];
                        }
                        else if([components count]==2)
                        {
                            /* syntax 2: pointcode,address */
                            pcString = components[0];
                            if(svar == SCCP_VARIANT_ANSI)
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                            }
                            else
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                                pc = [[UMMTP3PointCode alloc]initWithString:pcString variant: mvar];
                            }
                            address = components[1];
                            if([address hasPrefix:@"+"])
                            {
                                address = [address substringFromIndex:1];
                                if(svar == SCCP_VARIANT_ANSI)
                                {
                                    ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                                }
                                else
                                {
                                    ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                                }
                                nai.nai = SCCP_NAI_INTERNATIONAL;
                                npi.npi = SCCP_NPI_ISDN_E164;
                            }
                            else
                            {
                                if(svar == SCCP_VARIANT_ANSI)
                                {
                                    ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                                }
                                else
                                {
                                    ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                                }
                                nai.nai = SCCP_NAI_UNKNOWN;
                                npi.npi = SCCP_NPI_ISDN_E164;
                            }
                        }
                        else if([components count]==3)
                        {
                            /* syntax 3: pointcode,nai,npi,address */
                            if(svar == SCCP_VARIANT_ANSI)
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                            }
                            else
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ITU_TT_NP_ENCODING;
                            }
                            pc = [[UMMTP3PointCode alloc]initWithString:components[0] variant: mvar];
                            npi.npi = [components[1] intValue];
                            address = components[2];
                        }
                        else if([components count]>3)
                        {
                            if(svar == SCCP_VARIANT_ANSI)
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                            }
                            else
                            {
                                ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                            }
                                pc = [[UMMTP3PointCode alloc]initWithString:components[0] variant: mvar];
                            /* syntax 3: pointcode,nai,npi,address */
                            nai.nai = [components[1] intValue];
                            npi.npi = [components[2] intValue];
                            address = components[3];
                        }
                        ai.pointCodeIndicator=YES;
                    }

                    else if(    (c1 =='{')  /* ITU Encoding of the style { ai : nai : npi : digits : pointcode } */
                            ||  (c1 =='[')) /* ANSI Encoding of the style [ ai : nai : npi : digits : pointcode ] */
                    {
                        BOOL ansi = (c1 =='[');
                        msisdn = [msisdn substringWithRange:NSMakeRange(1,msisdn.length-2)];

                        if(ansi)
                        {
                            ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_ONLY;
                        }
                        else
                        {
                            ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
                        }
                        NSArray *components = [msisdn componentsSeparatedByString:@":"];
                        if(components.count > 0)
                        {
                            NSString *s = components[0];
                            if(s.length > 0)
                            {
                                ai.globalTitleIndicator  = [s intValue];
                            }
                        }
                        if(components.count > 1)
                        {
                            NSString *s = components[1];
                            if(s.length > 0)
                            {
                                nai.nai = [s intValue];
                            }
                        }
                        if(components.count > 2)
                        {
                            NSString *s = components[2];
                            if(s.length > 0)
                            {
                                npi.npi = [s intValue];
                                if(ansi)
                                {
                                    if(ai.globalTitleIndicator == SCCP_GTI_ANSI_TT_ONLY)
                                    {
                                        ai.globalTitleIndicator = SCCP_GTI_ANSI_TT_NP_ENCODING;
                                    }
                                }
                            }
                        }
                        if(components.count > 3)
                        {
                            NSString *s = components[3];
                            if(s.length > 0)
                            {
                                address = s;
                            }
                            else
                            {
                                address = @"";
                            }
                        }
                        if(components.count > 4)
                        {
                            NSString *s = components[4];
                            if(s.length > 0)
                            {
                                if(ansi)
                                {
                                    pc = [[UMMTP3PointCode alloc]initWithString:s variant: UMMTP3Variant_ANSI];
                                }
                                else
                                {
                                    pc = [[UMMTP3PointCode alloc]initWithString:s variant: UMMTP3Variant_ITU];
                                }
                                ai.pointCodeIndicator = YES;
                            }
                        }
                    }
                    else if(c1 =='$') /* direct pointcode entry */
                    {
                        const char *pcstr = &msisdn.UTF8String[1];
                        pc = [[UMMTP3PointCode alloc] initWithString:@(pcstr) variant:mvar];
                        ai.globalTitleIndicator = SCCP_GTI_NONE;
                        ai.pointCodeIndicator = YES;
                    }
                    else
                    {
                        nai.nai= SCCP_NAI_ALPHANUMERIC;
                        npi.npi = SCCP_NPI_UNKNOWN;
                        address = msisdn;
                    }
                }
            }
        }
    }
    return self;
}

- (NSDictionary *)dictionaryValue
{
    UMSynchronizedSortedDictionary *d = [self objectValue];
    return [NSDictionary dictionaryWithDictionary:[d mutableCopy]];
}

- (UMSynchronizedSortedDictionary *)objectValue
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    if(ai)
    {
        dict[@"ai"] = [ai dictionaryValue];
    }
    if(pc)
    {
        dict[@"point-code"] = [pc stringValue];
    }
    if(ssn)
    {
        dict[@"ssn"] = @(ssn.ssn);
    }
    if(tt)
    {
        dict[@"tt"] = @(tt.tt);
    }

    if(nai)
    {
        dict[@"nai"] = @(nai.nai);
    }
/*    if(ton)
    {
        dict[@"ton"] = @(ton.ton);
    }
*/
    if(npi)
    {
        dict[@"npi"] = @(npi.npi);
    }
    if(address)
    {
        dict[@"address"] = address;
    }
    return dict;
}

- (NSString *)description
{

    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"tt=%d gti=%d np=%d nai=%d",
                        tt.tt,
                        ai.globalTitleIndicator,
                        npi.npi,
                        nai.nai];
    if(address)
    {
        [s appendFormat:@" gta=%@",address];
    }
    if(ai.pointCodeIndicator)
    {
        if(pc)
        {
            [s appendFormat:@" pc=%@",pc.stringValue];
        }
    }
    if(ai.subSystemIndicator)
    {
        if(ssn.ssn)
        {
            [s appendFormat:@" ssn=%d",ssn.ssn];
        }
    }
    return s;

}

- (NSString *)debugDescription
{
    NSMutableString *s = [[NSMutableString alloc]init];
    
    if(ai)
    {
        [s appendFormat:@"   ai=%@\r\n",[ai debugDescription]];
    }
    if(nai)
    {
        [s appendFormat:@"   nai=%d\r\n",(int)nai.nai];
    }
/*    if(ton)
    {
        [s appendFormat:@"   ton=%d\r\n",(int)ton.ton];
    }
*/
    if(npi)
    {
        [s appendFormat:@"   npi=%d\r\n",(int)npi.npi];
    }
    if(ssn)
    {
        [s appendFormat:@"   ssn=%d\r\n",(int)ssn.ssn];
    }
    if(tt)
    {
        [s appendFormat:@"   tt=%d\r\n",(int)tt.tt];
    }
    if(address)
    {
        [s appendFormat:@"   address=%@\r\n",address];
    }
    if(pc)
    {
        [s appendFormat:@"   point-code=%@\r\n",pc.stringValue];
    }
    return s;
}

- (SccpAddress *)anyAddress
{
    SccpAddress * a = [[SccpAddress alloc]init];

    [a setAiFromInt: ai.addressIndicator];
    [a setNaiFromInt: nai.nai];
    [a setNpiFromInt: npi.npi];
    [a setSsnFromInt: ssn.ssn];
    [a setTtFromInt: tt.tt];
    [a setAddress:@"any"];
    [a setPc:pc];
    return a;
}

+ (SccpAddress *)anyAddress
{
    SccpAddress * a = [[SccpAddress alloc]init];
    [a setAddress:@"any"];
    return a;
}


- (SccpAddress *)anySsnAddress
{
    SccpAddress * a = [[SccpAddress alloc]init];

    [a setAiFromInt: ai.addressIndicator];
    [a setNaiFromInt: nai.nai];
    [a setNpiFromInt: npi.npi];
    [a setSsnFromInt: 0];
    [a setTtFromInt: tt.tt];
    [a setAddress:address];
    [a setPc:pc];
    return a;
}


@end

static int is_all_digits(const char *text, int startpos, unsigned long len)
{
    int i=0;
    for(i=startpos;i<len;i++)
    {
        switch(text[i])
        {
            case	'0':
            case	'1':
            case	'2':
            case	'3':
            case	'4':
            case	'5':
            case	'6':
            case	'7':
            case	'8':
            case	'9':
            case	'*':
            case	'#':
            case	'a':
                break;
            default:
                return 0;
        }
    }
    return 1;
}

