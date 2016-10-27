//
//  SccpAddressIndicator.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

#import <ulib/ulib.h>


/* 
 ITU Recommendation Q.713 (07/96):
    bit 8: reserved
    bit 7: routing indicator
     1 Route on SSN
     0 Route on GT.
    bit 6543: global title indicator
     0000 no global title included
     0001 global title includes nature of address indicator only
     0010 global title includes translation type only
     0011 global title includes translation type, numbering plan and encoding scheme
     0100 global title includes translation type, numbering plan, encoding scheme and nature of address indicator
     bit 2: SSN present
     bit 1: Pointcode present

    ANSI:
    bit 8: national use
      0  international
      1  national
    bit 7: routing indicator
      1 Route on SSN
      0 Route on GT.
    bit 6543: global title indicator
      0000 no global title included
      0001 Global title includes translation type, numbering plan and encoding scheme
      0010 Global title includes translation type
    bit 2: Pointcode present
    bit 1: SSN present

*/

@interface SccpAddressIndicator : UMObject
{
    BOOL nationalReservedBit;
    BOOL routingIndicatorBit;
    int  globalTitleIndicator;
    BOOL subSystemIndicator;
    BOOL pointCodeIndicator;
}

@property(readwrite,assign) BOOL nationalReservedBit;
@property(readwrite,assign) BOOL routingIndicatorBit;
@property(readwrite,assign) int  globalTitleIndicator;
@property(readwrite,assign) BOOL subSystemIndicator;
@property(readwrite,assign) BOOL pointCodeIndicator;


- (SccpAddressIndicator *)initWithInt:(int)i;
- (void)setAddressIndicatorANSI:(int)i;
- (void)setAddressIndicatorITU:(int)i;
- (int)addressIndicatorANSI;
- (int)addressIndicatorITU;
- (int)addressIndicator;
- (NSDictionary *) dictionaryValue;
- (NSString *) debugDescription;
@end

#define SCCP_GTI_NONE                       0x00
#define SCCP_GTI_ANSI_TT_NP_ENCODING        0x01
#define SCCP_GTI_ANSI_TT_ONLY               0x02

#define SCCP_GTI_ITU_NAI_ONLY               0x01
#define SCCP_GTI_ITU_TT_ONLY                0x02
#define SCCP_GTI_ITU_TT_NP_ENCODING         0x03
#define SCCP_GTI_ITU_NAI_TT_NPI_ENCODING    0x04
