//
//  SccpSubSystemNumber.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>


#define SCCP_SSN_SCCP_MG	                    1
#define SCCP_SSN_ISUP                           3   /* defined in ANSI */
#define SCCP_SSN_OMAP                           4   /* ANSI */
#define SCCP_SSN_MAP                            5   /* ANSI */
#define SCCP_SSN_HLR                            6
#define SCCP_SSN_VLR		                    7
#define SCCP_SSN_MSC		                    8
#define SCCP_SSN_EIR		                    9
#define SCCP_SSN_AUTH                           10
#define SCCP_SSN_SMSC                           12
#define SCCP_SSN_RANAP	                        142
#define SCCP_SSN_RNSAP	                        143
#define SCCP_SSN_GMLC	                        145
#define SCCP_SSN_CAP	                        146
#define SCCP_SSN_GSMSCF	                        147
#define SCCP_SSN_SIWF	                        148
#define SCCP_SSN_SGSN	                        149
#define SCCP_SSN_GGSN	                        150
#define SCCP_SSN_ULIBTRANSPORT                  199
#define SCCP_SSN_CNAM                           232
#define SCCP_SSN_INAP	                        241
#define SCCP_SSN_LNP	                        247
#define SCCP_SSN_800_NUMBER_TRANSLATION_AIN	    248
#define SCCP_SSN_PCAP                           249
#define SCCP_SSN_BSC_BSSAP_LE                   250
#define SCCP_SSN_MSC_BSSAP_LE                   251
#define SCCP_SSN_SMLC_BSSAP_LE                  252
#define SCCP_SSN_BSS_O_AND_M                    253
#define SCCP_SSN_800_NUMBER_TRANSLATION_TCAP	254

@interface SccpSubSystemNumber : UMObject
{
    int _ssn;
}

@property(readwrite,assign) int ssn;
- (SccpSubSystemNumber *)initWithInt:(int)i;
- (SccpSubSystemNumber *)initWithName:(NSString *)n;

@end
