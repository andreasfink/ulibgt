//
//  SccpGttRoutingTableDigitNode.m
//  ulibgt
//
//  Created by Andreas Fink on 27.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpGttRoutingTableDigitNode.h"
#import "SccpAddress.h"
#import "SccpGttRoutingTableEntry.h"

@implementation SccpGttRoutingTableDigitNode

- (SccpGttRoutingTableDigitNode *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
    }
    return self;
}

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


- (NSString *)dumpTreeEntryWithIdent:(NSString *)ident
{
    NSMutableString *s = [[NSMutableString alloc]init];
    if(_mainEntry)
    {
        [s appendFormat:@"%@mainEntry: %@\n",ident,_mainEntry.description];
    }
    if(_entries)
    {
        [s appendFormat:@"%@subentries:\n",ident];
        [s appendFormat:@"%@{\n",ident];
        for(SccpGttRoutingTableEntry *e in _entries)
        {
            [s appendFormat:@"%@   %@\n",ident,e.description];
        }
        [s appendFormat:@"%@}\n",ident];
        for(int i=0;i<16;i++)
        {
            SccpGttRoutingTableDigitNode *n = _next[i];
            if(n)
            {
                [s appendFormat:@"%@[%d]:\n",ident,i];
                [s appendFormat:@"%@{\n",ident];
                NSString *ident2 = [NSString stringWithFormat:@"%@  ",ident];
                NSString *sub = [n dumpTreeEntryWithIdent:ident2];
                [s appendString:sub];
                [s appendFormat:@"%@}\n",ident];
            }
        }
    }
    return s;
}

@end
