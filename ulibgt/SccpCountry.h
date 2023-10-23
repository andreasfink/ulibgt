//
//  SccpCountry.h
//  ulibgt
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <Foundation/Foundation.h>

const char *sccp_get_country_from_msisdn(const char *msisdn);
NSString * SccpCountryFromMSISDN(NSString *msisdn);
