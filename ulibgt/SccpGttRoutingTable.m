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
#import <ulibdb/ulibdb.h>
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
            entry.digits=@"";
            if(newRoot.entries==NULL)
            {
                newRoot.entries = [[UMSynchronizedArray alloc]init];
            }
            if(entry.isMainEntry)
            {
                newRoot.mainEntry = entry;
            }
            else
            {
                [newRoot.entries addObject:entry];
            }
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
            if(currentNode.entries == NULL)
            {
                currentNode.entries = [[UMSynchronizedArray alloc]init];
            }
            if(entry.isMainEntry)
            {
                currentNode.mainEntry = entry;
            }
            else
            {
                [currentNode.entries addObject:entry];
            }
        }
    }
    self.rootNode = newRoot;
}

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
                              transactionNumber:(NSNumber *)tid
                                            ssn:(NSNumber *)ssn
                                      operation:(NSNumber *)op
                                     appContext:(NSString *)ac
{
    NSInteger n = [digits length];
    
    SccpGttRoutingTableDigitNode    *currentNode = self.rootNode;
    SccpGttRoutingTableEntry        *myMainEntry = currentNode.mainEntry;
    SccpGttRoutingTableEntry        *returnValue = NULL;
    UMSynchronizedArray             *applicableEntries = [[UMSynchronizedArray alloc]init];
    for(SccpGttRoutingTableEntry *e in currentNode.entries)
    {
        [applicableEntries addObject:e];
    }
    
    if([digits isEqualToString:@"default"])
    {
        digits = @"";
    }
    
    if(_logLevel <=UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"called findEntryByDigits:%@ transactionNumber:%@ ssn:%@ operation:%@ appContext:%@",digits,tid,ssn,op,ac];
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
        if(currentNode.mainEntry)
        {
            myMainEntry = currentNode.mainEntry;
            [applicableEntries addObject:myMainEntry];
        }
        if(currentNode.entries)
        {
            for(SccpGttRoutingTableEntry *e in currentNode.entries)
            {
                [applicableEntries addObject:e];
            }
        }
    }
    
    returnValue = myMainEntry;
    if(applicableEntries.count > 0)
    {
        /* filter for only applicable entries */
        UMSynchronizedArray *myEntries = [[UMSynchronizedArray alloc]init];
        for(SccpGttRoutingTableEntry *entry in applicableEntries)
        {
            if([entry matchingTransactionNumber:tid
                                            ssn:ssn
                                         opcode:op
                                     appcontext:ac])
                [myEntries addObject:entry];
        }
        /* and sort by priorities */
        if(myEntries.count > 1)
        {
            myEntries = [myEntries sortedArrayUsingComparator:^NSComparisonResult(SccpGttRoutingTableEntry *a, SccpGttRoutingTableEntry *b)
                         { return [a priorityComparision:b]; } ];
            /* now the last entry is the most specific entry */
        }
        returnValue = [myEntries lastObject];
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

- (void)addEntry:(SccpGttRoutingTableEntry *)entry
{
    NSString *digits = entry.digits;
    NSInteger n = [digits length];
    
    if(_rootNode == NULL)
    {
        _rootNode = [[SccpGttRoutingTableDigitNode alloc]init];
    }
    
    if(([digits isEqualToString:@""]) || ([digits isEqualToString:@"default"]))
    {
        _rootNode.entries = [[UMSynchronizedArray alloc]init];
        if(entry.isMainEntry)
        {
            _rootNode.mainEntry = entry;
        }
        else
        {
            [_rootNode.entries addObject:entry];
        }
        _entries[@""] = entry;
        return;
    }
    SccpGttRoutingTableDigitNode *currentNode = _rootNode;
    
    for(NSInteger i = 0;i<n;i++)
    {
        unichar uc = [digits characterAtIndex:i];
        currentNode = [currentNode nextNode:(int)uc create:YES];
    }
    
    if(currentNode.entries == NULL)
    {
        currentNode.entries = [[UMSynchronizedArray alloc]init];
    }
    if(entry.isMainEntry)
    {
        currentNode.mainEntry = entry;
    }
    else
    {
        [currentNode.entries addObject:entry];
    }
    _entries[entry.name] = entry;
}

- (UMSynchronizedSortedDictionary *)list
{
    return _entries;
}

+ (UMDbTableDefinition *)routingTableDbDefinition
{
    UMDbTableDefinition *ttTableDef = [[UMDbTableDefinition alloc] init];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"translation_table_name"
                                                                   size:255
                                                              canBeNull:NO
                                                                indexed:YES
                                                                primary:YES
                                                                    tag:1]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"sccp"
                                                                   size:255
                                                              canBeNull:NO
                                                                indexed:YES
                                                                primary:NO
                                                                    tag:2]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithInteger:@"tt"
                                                              canBeNull:NO
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:3]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithInteger:@"gti"
                                                              canBeNull:NO
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:4]] ;
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithInteger:@"np"
                                                              canBeNull:NO
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:5]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithInteger:@"nai"
                                                              canBeNull:NO
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:6]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"pre_translation"
                                                                   size:255
                                                              canBeNull:YES
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:7]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"post_translation"
                                                                   size:255
                                                              canBeNull:YES
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:8]];
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"default_destination"
                                                                   size:255
                                                              canBeNull:YES
                                                                indexed:NO
                                                                primary:NO
                                                                    tag:9]] ;
    [ttTableDef addFieldDef:[[UMDbFieldDefinition alloc]initWithVarchar:@"last_modified_ts"
                                                                   size:32
                                                              canBeNull:YES
                                                                indexed:YES
                                                                primary:NO
                                                                    tag:10]];
    return ttTableDef;
}



- (NSString *)dumpTable
{
    NSMutableString *s = [[NSMutableString alloc]init];
    NSArray *keys = [_entries allKeys];
    
    for(NSString *key in keys)
    {
        SccpGttRoutingTableEntry *entry = _entries[key];
        [s appendString:entry.description];
        [s appendString:@"\n"];
    }
    return s;
}


- (NSString *)dumpTree
{
    return [_rootNode dumpTreeEntryWithIdent:@""];
}

- (UMSynchronizedSortedDictionary *)status
{
    UMSynchronizedSortedDictionary *d = [[UMSynchronizedSortedDictionary alloc]init];
    if(_entries==NULL)
    {
        d[@"comment"] = @"_entries is NULL";
    }
    else
    {
        NSArray *keys = [_entries allKeys];
        if(keys.count==0)
        {
            d[@"comment"] = @"_entries has zero entries";
        }
        else
        {
            for(NSString *key in keys)
            {
                SccpGttRoutingTableEntry *entry = _entries[key];
                d[key] = [entry status];
            }
        }
    }
    return d;
}

@end
