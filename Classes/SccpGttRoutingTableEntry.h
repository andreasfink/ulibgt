//
//  SccpGttRoutingTableEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

@class SccpGttRoutingTableAction;
@class SccpNextHop;
@class SccpApplicationGroup;

@interface SccpGttRoutingTableEntry : UMObject
{
    NSString             *_digits;
    SccpDestinationEntry *_nextHop;
}

@property(readwrite,atomic,strong)  NSString *digits;
@property(readwrite,atomic,strong)  SccpNextHop *nextHop;

@end

