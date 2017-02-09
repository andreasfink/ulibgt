//
//  SccpGttRoutingTableEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

#import "SccpGttRoutingTableAction.h"

@interface SccpGttRoutingTableEntry : UMObject
{
    SccpGttRoutingTableEntry    *next[16];
    SccpGttRoutingTableAction   *action;
}
@end

