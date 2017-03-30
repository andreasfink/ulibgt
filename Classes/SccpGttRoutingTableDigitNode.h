//
//  SccpGttRoutingTableDigitNode.h
//  ulibgt
//
//  Created by Andreas Fink on 27.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
@class SccpGttRoutingTableEntry;

@interface SccpGttRoutingTableDigitNode : UMObject
{
    SccpGttRoutingTableDigitNode    *_next[16];
    SccpGttRoutingTableEntry        *_entry;
}

@property(readwrite,strong,atomic)  SccpGttRoutingTableEntry *entry;

- (SccpGttRoutingTableDigitNode *)nextNode:(char)nextDigit create:(BOOL)create;

@end
