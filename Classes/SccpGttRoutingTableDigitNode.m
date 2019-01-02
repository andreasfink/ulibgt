//
//  SccpGttRoutingTableDigitNode.m
//  ulibgt
//
//  Created by Andreas Fink on 27.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpGttRoutingTableDigitNode.h"
#import "SccpAddress.h"

@implementation SccpGttRoutingTableDigitNode


- (SccpGttRoutingTableDigitNode *)nextNode:(unichar)nextDigit create:(BOOL)create
{
    SccpGttRoutingTableDigitNode *nextEntry = NULL;
    int index = sccp_digit_to_nibble(nextDigit,-1);
    if(index == -1)
    {
        /* if we encounter a non digit (something like + or - or space or ( ) ) its just cosmetic glibberish and is ignored */
        return self;
    }

    nextEntry =  _next[index];
    if((nextEntry == NULL) && (create))
    {
        _next[index] = [[SccpGttRoutingTableDigitNode alloc]init];
        nextEntry = _next[index] ;
    }
    return nextEntry;
}

@end
