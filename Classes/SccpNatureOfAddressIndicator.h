//
//  SccpNatureOfAddressIndicator.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

#import <ulib/ulib.h>

#define SCCP_NAI_UNKNOWN 		0
#define SCCP_NAI_SUBSCRIBER     1
#define SCCP_NAI_RESERVED 		2
#define SCCP_NAI_NATIONAL 		3
#define SCCP_NAI_INTERNATIONAL  4
#define SCCP_NAI_ALPHANUMERIC   5
/* internal */
#define SCCP_NAI_POINTCODE      103
#define SCCP_NAI_EMPTY          104
#define SCCP_NAI_MISSING        105

@interface SccpNatureOfAddressIndicator : UMObject
{
    int nai;
}

@property(readwrite,assign) int nai;

- (SccpNatureOfAddressIndicator *)initWithInt:(int)i;

@end
