//
//  SccpNumberTranslation.h
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
@class SccpNumberTranslationEntry;

@class SccpAddress;

@interface SccpNumberTranslation : UMObject
{
    NSString *_name;
    NSMutableArray *_entries;
}

@property(readwrite,strong,atomic)     NSString *name;

- (SccpNumberTranslation *)initWithConfig:(NSDictionary *)cfg;
- (SccpAddress *)translateAddress:(SccpAddress *)in;
- (void)addEntry:(SccpNumberTranslationEntry *)entry;

@end

