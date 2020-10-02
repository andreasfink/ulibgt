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
#import "SccpAddress.h"

@implementation SccpGttRoutingTable

- (SccpGttRoutingTable *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedSortedDictionary alloc]init];
    }
    return self;
}

- (SccpGttRoutingTable *)initWithName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        _name = name;
        _entries = [[UMSynchronizedSortedDictionary alloc]init];
    }
    return self;
}

- (void)setLogLevel:(UMLogLevel)newLogLevel
{
    _logLevel = newLogLevel;

    NSArray *keys = [_entries allKeys];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *entry = _entries[key];
        entry.logLevel = newLogLevel;
    }
}


- (UMLogLevel) logLevel
{
    return _logLevel;
}

- (void)setLogFeed:(UMLogFeed *)newLogFeed
{
    [super setLogFeed:newLogFeed];
    NSArray *keys = [_entries allKeys];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *entry = _entries[key];
        entry.logFeed = newLogFeed;
    }
}

- (UMLogFeed *) logFeed
{
    return [super logFeed];
}


- (void)entriesToDigitTree
{
    SccpGttRoutingTableDigitNode *newRoot = [[SccpGttRoutingTableDigitNode alloc]init];

    NSArray *keys = [_entries allKeys];
    for(id key in keys)
    {
        SccpGttRoutingTableEntry *entry = _entries[key];

        NSString *digits = entry.digits;
        if(([digits isEqualToString:@""]) || ([digits isEqualToString:@"default"]))
        {
            //digits=@"";
            newRoot.entry = entry;
        }
        else
        {
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
    }
    self.rootNode = newRoot;
}

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
{
    return [self findEntryByDigits:digits transactionNumber:NULL];
}

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
                              transactionNumber:(NSNumber *)tid
{
    NSInteger n = [digits length];

    SccpGttRoutingTableDigitNode *currentNode = self.rootNode;
    SccpGttRoutingTableEntry *returnValue = currentNode.entry;

    if(([digits isEqualToString:@""]) || ([digits isEqualToString:@"default"]))
    {
        return returnValue;
    }

    if(_logLevel <=UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"called findEntryByDigits:%@",digits];
        [self.logFeed debugText:s];
    }
    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        int k = sccp_digit_to_nibble(uc,-1);

        if(_logLevel <=UMLOG_DEBUG)
        {
            NSString *s = [NSString stringWithFormat:@" checking digit nr  %d=%d",(int)i,k];
            [self.logFeed debugText:s];
        }
        if(k<0)
        {
            continue;
        }
        SccpGttRoutingTableDigitNode *nextNode = [currentNode nextNode:(int)uc create:NO];
        if(nextNode == NULL)
        {
            if(_logLevel <=UMLOG_DEBUG)
            {
                [self.logFeed debugText:@" no next node found"];
            }
            break;
        }
        currentNode = nextNode;
        if(currentNode.entry)
        {
            if(tid==NULL)
            {
                returnValue = currentNode.entry;
            }
            else if(currentNode.entry.hasSubentries)
            {
                SccpGttRoutingTableEntry *e = [currentNode.entry findSubentryByTransactionNumber:tid];
                if(e)
                {
                    returnValue  = e;
                }
            }
            else
            {
                if([currentNode.entry matchingTransactionNumber:tid]==YES)
                {
                    returnValue  = currentNode.entry;
                }
            }
        }
    }
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self.logFeed debugText:[NSString stringWithFormat:@" returning %@",returnValue]];
    }
    return returnValue;
}

- (SccpGttRoutingTableEntry *)findEntryByName:(NSString *)name
{
    return _entries[name];
}


- (void)deleteEntryByName:(NSString *)name
{
    SccpGttRoutingTableEntry *entry = [self findEntryByName:name];
    if(entry == NULL)
    {
        return;
    }
    [_entries removeObjectForKey:name];

    NSString *digits = entry.digits;
    NSInteger n = [digits length];

    if(_rootNode == NULL)
    {
        _rootNode = [[SccpGttRoutingTableDigitNode alloc]init];
    }
    SccpGttRoutingTableDigitNode *currentNode = _rootNode;
    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        currentNode = [currentNode nextNode:(int)uc create:YES];
    }
    currentNode.entry = NULL;
}


- (void)deleteEntryByDigits:(NSString *)digits
{
    SccpGttRoutingTableEntry *entry = [self findEntryByDigits:digits];
    if(entry == NULL)
    {
        return;
    }
    [_entries removeObjectForKey:entry.name];

    NSInteger n = [digits length];

    if(_rootNode == NULL)
    {
        _rootNode = [[SccpGttRoutingTableDigitNode alloc]init];
    }
    SccpGttRoutingTableDigitNode *currentNode = _rootNode;
    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        int k = sccp_digit_to_nibble(uc,-1);
        if(k<0)
        {
            continue;
        }
        currentNode = [currentNode nextNode:(int)uc create:YES];
    }
    currentNode.entry = NULL;
}


- (void)addEntry:(SccpGttRoutingTableEntry *)entry
{
    NSString *digits = entry.digits;
    NSInteger n = [digits length];

    if(_rootNode == NULL)
    {
        _rootNode = [[SccpGttRoutingTableDigitNode alloc]init];
    }

    if([digits isEqualToString:@"default"])
    {
        _rootNode.entry = entry;
        _entries [entry.table] = entry;
        return;
    }

    SccpGttRoutingTableDigitNode *currentNode = _rootNode;

    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        currentNode = [currentNode nextNode:(int)uc create:YES];
    }
    if(currentNode.entry != NULL)
    {
        [currentNode.entry addSubentry:entry];
    }
    else
    {
        currentNode.entry = entry;
    }
    _entries [entry.name] = currentNode.entry;
}

- (UMSynchronizedSortedDictionary *)list
{
	return _entries;
}


@end
