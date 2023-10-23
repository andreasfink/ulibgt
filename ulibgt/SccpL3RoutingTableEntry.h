//
//  SccpL3RoutingTableEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 19.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulibmtp3/ulibmtp3.h>
#import "SccpL3RouteStatus.h"


@interface SccpL3RoutingTableEntry : UMObject
{
    UMMTP3PointCode *_pc;
    SccpL3RouteStatus _status;
}

@property(readwrite,atomic,strong)  UMMTP3PointCode *pc;
@property(readwrite,atomic,assign)  SccpL3RouteStatus status;

- (UMSynchronizedSortedDictionary *)statusDict;

@end;
