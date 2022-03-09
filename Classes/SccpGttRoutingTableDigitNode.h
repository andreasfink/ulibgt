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
    SccpGttRoutingTableEntry        *_mainEntry;
    UMSynchronizedArray             *_entries; /* array of SccpGttRoutingTableEntry * */
}

@property(readwrite,strong,atomic)  SccpGttRoutingTableEntry *mainEntry;
@property(readwrite,strong,atomic)  UMSynchronizedArray *entries; /* array of SccpGttRoutingTableEntry * */

- (SccpGttRoutingTableDigitNode *)nextNode:(unichar)nextDigit create:(BOOL)create;

@end
