//
//  SccpDestinationEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
@class UMMTP3PointCode;
@class UMLayerSCCP;

@interface SccpDestination : UMObject
{
    /* one of these should be set but only one */
    NSNumber        *_ssn;              /* send to internal subsystem       */
    UMMTP3PointCode *_dpc;              /* send to pointcode                */
    NSString        *_m3uaAs;           /* send to m3ua application servber */
    int             _priority;          /* priority group 0...7 of this route */
    int             _weight;            /* weight of this route used for load distribution among equal priority entries */

}

@property(readwrite,strong,atomic)  NSNumber        *ssn;
@property(readwrite,strong,atomic)  UMMTP3PointCode *dpc;
@property(readwrite,strong,atomic)  NSString        *m3uaAs;
@property(readwrite,assign,atomic)  int             priority;
@property(readwrite,assign,atomic)  int             weight;



@end
