//
//  SccpGttRoutingTable.m
//  ulibgt
//
//  Created by Andreas Fink on 09.02.2017
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import "SccpGttRoutingTable.h"

@implementation SccpGttRoutingTable


- (void)entriesToDigitTree
{
    SccpGttRoutingTableDigitNode *newRoot = [[SccpGttRoutingTableDigitNode alloc]init];

    NSArray *keys = [_entries allKeys];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *entry = _entries[key];

        NSString *digits = entry.digits;

        const char *str = digits.UTF8String;
        int n = (int)strlen(str);

        SccpGttRoutingTableDigitNode *currentNode = newRoot;
        for(int i = 0;i<n;i++)
        {
            int c = str[i];
            currentNode = [currentNode nextNode:c create:YES];
        }
        currentNode.entry = entry;
    }
    self.rootNode = newRoot;
}

- (SccpGttRoutingTableEntry *)findEntry:(NSString *)digits
{
    const char *str = digits.UTF8String;
    size_t n = strlen(str);

    SccpGttRoutingTableDigitNode *currentNode = self.rootNode;
    for(int i = 0;i<n;i++)
    {
        int c = str[i];
        SccpGttRoutingTableDigitNode *nextNode = [currentNode nextNode:c create:NO];
        if(nextNode == NULL)
        {
            break;
        }
        currentNode = nextNode;
    }
    return currentNode.entry;
}


@end
