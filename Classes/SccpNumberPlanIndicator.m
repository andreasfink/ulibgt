//
//  SccpNumberPlanIndicator.m
//  ulibgt
//
//  Created by Andreas Fink on 24.03.16.
//  Copyright (c) 2016 Andreas Fink (andreas@fink.org)
//

#import "SccpNumberPlanIndicator.h"

@implementation SccpNumberPlanIndicator
@synthesize npi;


- (SccpNumberPlanIndicator *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        npi = i;
    }
    return self;
}

- (NSString *)description
{
    NSString *str = @"";
    switch (npi)
    {
        case SCCP_NPI_UNKNOWN:
            str = @"UNKNOWN";
            break;
        case SCCP_NPI_ISDN_E164:
            str = @"ISDN_E164";
            break;
        case SCCP_NPI_GENERIC:
            str = @"GENERIC";
            break;
        case SCCP_NPI_DATA_X121:
            str = @"DATA_X121";
            break;
        case SCCP_NPI_TELEX:
            str = @"TELEX";
            break;            
        case SCCP_NPI_MARITIME_MOBILE:
            str = @"MARITIME_MOBILE";
            break;
        case SCCP_NPI_LAND_MOBILE_E212:
            str = @"LAND_MOBILE_E212";
            break;
        case SCCP_NPI_ISDN_MOBILE_E214:
            str = @"ISDN_MOBILE_E214";
            break;
        case SCCP_NPI_NATIONAL:
            str = @"NATIONAL";
            break;
        case SCCP_NPI_PRIVATE:
            str = @"PRIVATE";
            break;
        case SCCP_NPI_ERMES:
            str = @"ERMES";
            break;
        case SCCP_NPI_RESERVED:
            str = @"RESERVED";
            break;
        case SCCP_NPI_IMSI:
            str = @"IMSI";
            break;
        case SCCP_NPI_INTERNET:
            str = @"INTERNET";
            break;
        case SCCP_NPI_POINTCODE:
            str = @"POINTCODE";
            break;
        default:
            return [NSString stringWithFormat:@"NPI_%d",npi];
    }
    return [NSString stringWithFormat:@"NPI_%@_%d",str,npi];
}
@end
