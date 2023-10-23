//
//  SccpNumberPlanIndicator.h
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.

// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>


#define SCCP_NPI_UNKNOWN			0
#define SCCP_NPI_ISDN_E164			1
#define SCCP_NPI_GENERIC            2
#define SCCP_NPI_DATA_X121			3
#define SCCP_NPI_TELEX 				4
#define SCCP_NPI_MARITIME_MOBILE    5 /* E.210/E.211 */
#define SCCP_NPI_LAND_MOBILE_E212   6 /* E.212 */
#define SCCP_NPI_ISDN_MOBILE_E214   7
#define SCCP_NPI_NATIONAL			8
#define SCCP_NPI_PRIVATE            9
#define SCCP_NPI_ERMES 				10
#define SCCP_NPI_RESERVED 			15
#define SCCP_NPI_IMSI 				100
#define SCCP_NPI_INTERNET 			101
#define SCCP_NPI_POINTCODE			103


@interface SccpNumberPlanIndicator : UMObject
{
    int npi;
}

@property(readwrite,assign) int npi;

- (SccpNumberPlanIndicator *)initWithInt:(int)i;

@end
