//
//  SccpSubSystemNumber.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpSubSystemNumber.h"

@implementation SccpSubSystemNumber

@synthesize ssn;

- (SccpSubSystemNumber *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        ssn = i;
    }
    return self;
}

-(NSString *)description
{
    NSString *str = @"";
    switch (ssn)
    {
        case SCCP_SSN_ISUP:
            str = @"ISUP";
            break;
        case SCCP_SSN_OMAP:
            str = @"OMAP";
            break;
        case SCCP_SSN_MAP:
            str = @"MAP";
            break;            
        case SCCP_SSN_HLR:
            str = @"HLR";
            break;
        case SCCP_SSN_VLR	:
            str = @"VLR	";
            break;
        case SCCP_SSN_MSC	:
            str = @"MSC	";
            break;
        case SCCP_SSN_EIR	:
            str = @"EIR	";
            break;
        case SCCP_SSN_AUTH:
            str = @"AUTH";
            break;
        case SCCP_SSN_SMSC:
            str = @"SMSC";
            break;
        case SCCP_SSN_PCAP:
            str = @"PCAP";
            break;
        case SCCP_SSN_BSC_BSSAP_LE:
            str = @"BSC_BSSAP_LE";
            break;
        case SCCP_SSN_MSC_BSSAP_LE:
            str = @"MSC_BSSAP_LE";
            break;
        case SCCP_SSN_SMLC_BSSAP_LE:
            str = @"SMLC_BSSAP_LE";
            break;
        case SCCP_SSN_BSS_O_AND_M:
            str = @"BSS_O_AND_M";
            break;
        case SCCP_SSN_RANAP:
            str = @"RANAP";
            break;
        case SCCP_SSN_RNSAP:
            str = @"RNSAP";
            break;
        case SCCP_SSN_GMLC:
            str = @"GMLC";
            break;
        case SCCP_SSN_CAP:
            str = @"CAP";
            break;
        case SCCP_SSN_GSMSCF:
            str = @"GSMSCF";
            break;
        case SCCP_SSN_SIWF:
            str = @"SIWF";
            break;
        case SCCP_SSN_SGSN:
            str = @"SGSN";
            break;
        case SCCP_SSN_GGSN:
            str = @"GGSN";
            break;
        case SCCP_SSN_INAP:
            str = @"INAP";
            break;
        case SCCP_SSN_CNAM:
            str = @"CNAM";
            break;
        case SCCP_SSN_LNP:
            str = @"LNP";
            break;
        case SCCP_SSN_800_NUMBER_TRANSLATION_AIN:
            str = @"800_NUMBER_TRANSLATION_AIN";
            break;
        case SCCP_SSN_800_NUMBER_TRANSLATION_TCAP:
            str = @"800_NUMBER_TRANSLATION_TCAP";
            break;
        default:
            return [NSString stringWithFormat:@"SSN_%d",ssn];
    }
    return [NSString stringWithFormat:@"SSN_%@",str];
}

- (SccpSubSystemNumber *)initWithName:(NSString *)n;
{
    if(n==NULL)
    {
        return NULL;
    }
    else if ([n caseInsensitiveCompare:@"SCCP_MG"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_SCCP_MG];
    }
    else if ([n caseInsensitiveCompare:@"ISUP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_ISUP];
    }
    else if ([n caseInsensitiveCompare:@"OMAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_OMAP];
    }
    else if ([n caseInsensitiveCompare:@"MAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_MAP];
    }
    else if ([n caseInsensitiveCompare:@"HLR"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_HLR];
    }
    else if ([n caseInsensitiveCompare:@"VLR"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_VLR];
    }
    else if ([n caseInsensitiveCompare:@"MSC"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_MSC];
    }
    else if ([n caseInsensitiveCompare:@"EIR"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_EIR];
    }
    else if ([n caseInsensitiveCompare:@"AUTH"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_AUTH];
    }
    else if ([n caseInsensitiveCompare:@"SMSC"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_SMSC];
    }
    else if ([n caseInsensitiveCompare:@"PCAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_PCAP];
    }
    else if ([n caseInsensitiveCompare:@"BSC_BSSAP_LE"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_BSC_BSSAP_LE];
    }
    else if ([n caseInsensitiveCompare:@"MSC_BSSAP_LE"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_MSC_BSSAP_LE];
    }
    else if ([n caseInsensitiveCompare:@"SMLC_BSSAP_LE"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_SMLC_BSSAP_LE];
    }
    else if ([n caseInsensitiveCompare:@"BSS_O_AND_M"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_BSS_O_AND_M];
    }
    else if ([n caseInsensitiveCompare:@"RANAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_RANAP];
    }
    else if ([n caseInsensitiveCompare:@"RNSAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_RNSAP];
    }
    else if ([n caseInsensitiveCompare:@"GMLC"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_GMLC];
    }
    else if ([n caseInsensitiveCompare:@"CAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_CAP];
    }
    else if ([n caseInsensitiveCompare:@"GSMSCF"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_GSMSCF];
    }
    else if ([n caseInsensitiveCompare:@"SIWF"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_SIWF];
    }
    else if ([n caseInsensitiveCompare:@"SGSN"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_SGSN];
    }
    else if ([n caseInsensitiveCompare:@"GGSN"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_GGSN];
    }
    else if ([n caseInsensitiveCompare:@"INAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_INAP];
    }
    else if ([n caseInsensitiveCompare:@"CNAM"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_CNAM];
    }
    else if ([n caseInsensitiveCompare:@"LNP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_LNP];
    }
    else if ([n caseInsensitiveCompare:@"800_NUMBER_TRANSLATION_AIN"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_800_NUMBER_TRANSLATION_AIN];
    }
    else if ([n caseInsensitiveCompare:@"800_NUMBER_TRANSLATION_TCAP"] == NSOrderedSame)
    {
        return [self initWithInt:SCCP_SSN_800_NUMBER_TRANSLATION_TCAP];
    }
    int k = [n intValue];
    if(k==0)
    {
        return NULL;
    }
    return [self initWithInt:k];
}


- (SccpSubSystemNumber *)copyWithZone:(NSZone *)zone
{
    return [[SccpSubSystemNumber allocWithZone:zone]initWithInt:ssn];
}

@end
