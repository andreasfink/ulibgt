//
//  SccpGttRoutingTable.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.2017
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>
#import "SccpGttRoutingTableEntry.h"

@interface SccpGttRoutingTable : UMObject
{
    SccpGttRoutingTableEntry *rootNode;
}


@end
