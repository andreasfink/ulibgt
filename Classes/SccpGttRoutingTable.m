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

- (SccpGttRoutingTable *)init
{
    self = [super init];
    if(self)
    {
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
    self.logFeed = newLogFeed;
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

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
{
    NSInteger n = [digits length];

    if(_logLevel <=UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"called findEntryByDigits:%@",digits];
        [self.logFeed debugText:s];
    }
    SccpGttRoutingTableDigitNode *currentNode = self.rootNode;
    for(NSInteger i = 0;i<n;i++)
    {
        if(_logLevel <=UMLOG_DEBUG)
        {
            NSString *s = [NSString stringWithFormat:@" checking digit nr  %d",(int)i];
            [self.logFeed debugText:s];
        }

        if(currentNode.entry.enabled==NO)
        {
            if(_logLevel <=UMLOG_DEBUG)
            {
                NSString *s = [NSString stringWithFormat:@" currentNode.entry.enabled == NO"];
                [self.logFeed debugText:s];
            }
            break;
        }
        unichar uc = [digits characterAtIndex:i];
        SccpGttRoutingTableDigitNode *nextNode = [currentNode nextNode:(int)uc create:NO];
        if(nextNode == NULL)
        {
            break;
        }
        if(currentNode.entry.enabled==YES)
        {
            currentNode = nextNode;
        }
        else
        {
            break;
        }
    }
    if(currentNode.entry.enabled == YES)
    {
        return currentNode.entry;
    }
    return NULL;
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
    SccpGttRoutingTableDigitNode *currentNode = _rootNode;

    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        currentNode = [currentNode nextNode:(int)uc create:YES];
    }
    currentNode.entry = entry;
    _entries [entry.name] = entry;
}

- (UMSynchronizedSortedDictionary *)list
{
	return _entries;
}

@end
