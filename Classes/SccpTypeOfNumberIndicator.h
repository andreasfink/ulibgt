//
//  SccpTypeOfNumberIndicator.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

#import <ulib/ulib.h>

#define SCCP_TON_UNKNOWN            0
#define SCCP_TON_INTERNATIONAL      1
#define SCCP_TON_NATIONAL           2
#define SCCP_TON_NETWORK_SPECIFIC   3
#define SCCP_TON_SUBSCRIBER 		4
#define SCCP_TON_ALPHANUMERIC       5
#define SCCP_TON_ABBREVIATED		6
#define SCCP_TON_RESERVED 			7
/* internal */
#define SCCP_TON_IMSI 				100
#define SCCP_TON_URL				101
#define SCCP_TON_EMAIL              102
#define SCCP_TON_POINTCODE			103
#define SCCP_TON_EMPTY              104
#define SCCP_TON_MISSING            105

@interface SccpTypeOfNumberIndicator : UMObject
{
    int ton;
}

@property (readwrite,assign) int ton;


- (SccpTypeOfNumberIndicator *)initWithInt:(int)i;

@end
