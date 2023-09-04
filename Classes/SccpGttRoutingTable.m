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
            if(entry.isMainEntry)
            {
                newRoot.mainEntry = entry;
            }
            newRoot.entries = [[UMSynchronizedArray alloc]init];
            [newRoot.entries addObject:entry];
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
            [currentNode.entries addObject:entry];
        }
    }
    self.rootNode = newRoot;
}

#if 0
- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
{
    return [self findEntryByDigits:digits
                 transactionNumber:NULL
                               ssn:NULL
                         operation:NULL
                        appContext:NULL];
}
#endif

- (SccpGttRoutingTableEntry *)findEntryByDigits:(NSString *)digits
                              transactionNumber:(NSNumber *)tid
                                            ssn:(NSNumber *)ssn
                                      operation:(NSNumber *)op
                                     appContext:(NSString *)ac
{
    NSInteger n = [digits length];

    SccpGttRoutingTableDigitNode *currentNode = self.rootNode;
    SccpGttRoutingTableEntry    *myMainEntry = currentNode.mainEntry;
    UMSynchronizedArray         *myEntries   = currentNode.entries;
    SccpGttRoutingTableEntry    *returnValue = NULL;

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
        }
        if(currentNode.entries)
        {
                myEntries   = currentNode.entries;
        }
    }

    returnValue = myMainEntry;
    if(myEntries.count > 0)
    {
        for(SccpGttRoutingTableEntry *entry in myEntries)
        {
            if([entry isMainEntry])
            {
                returnValue = entry; /* this is the unspecific entry by GT only */
                myMainEntry= entry;
            }
        }

        for(SccpGttRoutingTableEntry *entry in currentNode.entries)
        {
            if([entry isMainEntry])
            {
                continue; /* We already have this default one */
            }
            if([entry matchingTransactionNumber:tid
                                            ssn:ssn
                                         opcode:op
                                     appcontext:ac])
            {
                returnValue = entry; /* setting more specific route */
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


#if 0
this has to be revisted as we only want to delete the single entry, not any other subentries...

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
    currentNode.entries removeObject:<#(id)#> = NULL;
}
#endif

/* to be revisited */
#if 0
- (void)deleteEntryByDigits:(NSString *)digits
{
    SccpGttRoutingTableEntry *entry = [self findEntryByDigits:digits ...];
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
    currentNode.entries = NULL;
}
#endif


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
        [_rootNode.entries addObject:entry];
        if(entry.isMainEntry)
        {
            _rootNode.mainEntry = entry;
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
    [currentNode.entries addObject:entry];
    if(entry.isMainEntry)
    {
        currentNode.mainEntry = entry;
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
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"translation_table_name"
                       size:255
                  canBeNull:NO
                    indexed:YES
                    primary:YES
                        tag:1];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"sccp"
                       size:255
                  canBeNull:NO
                    indexed:YES
                    primary:NO
                        tag:2];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithInteger:@"tt"
                  canBeNull:NO
                    indexed:NO
                    primary:NO
                        tag:3];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithInteger:@"gti"
                  canBeNull:NO
                    indexed:NO
                    primary:NO
                        tag:4];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithInteger:@"np"
                  canBeNull:NO
                    indexed:NO
                    primary:NO
                        tag:5];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithInteger:@"nai"
                  canBeNull:NO
                    indexed:NO
                    primary:NO
                        tag:6];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"pre_translation"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:7];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"post_translation"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:8];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"default_destination"
                       size:255
                  canBeNull:YES
                    indexed:NO
                    primary:NO
                        tag:9];
    [ttTableDef addFieldDef:[UMDbFieldDefinition alloc]initWithVarchar:@"last_modified_ts"
                       size:32
                  canBeNull:YES
                    indexed:YES
                    primary:NO
                        tag:10];
    return ttTableDef;
}
@end
