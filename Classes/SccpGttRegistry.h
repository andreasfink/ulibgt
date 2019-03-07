//
//  SccpGttRegistry.h
//  ulibgt
//
//  Created by Andreas Fink on 29/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>


@class SccpGttSelector;
@class SccpDestinationGroup;

@interface SccpGttRegistry : UMObject
{
    UMLogLevel                _logLevel;
    UMSynchronizedDictionary *_entriesByKey;
    UMSynchronizedDictionary *_entriesByName;
    UMSynchronizedDictionary *_linksetTranslationsIncoming;
    UMSynchronizedDictionary *_linksetTranslationsOutgoing;

    UMSynchronizedDictionary    *_sccp_number_translations_dict;
    UMSynchronizedDictionary    *_sccp_destinations_dict;

}

@property(readwrite,assign,atomic)      UMLogLevel logLevel;
@property(readwrite,strong,atomic)      UMSynchronizedDictionary    *sccp_number_translations_dict;
@property(readwrite,strong,atomic)      UMSynchronizedDictionary    *sccp_destinations_dict;

- (SccpGttSelector *)selectorForInstance:(NSString *)instance
                                      tt:(int)tt
                                     gti:(int)gti
                                      np:(int)np
                                     nai:(int)nai;


- (void)addEntry:(SccpGttSelector *)sel;
- (void)updateEntry:(SccpGttSelector *)gsel;
- (void)removeEntry:(SccpGttSelector *)sel;
- (void)initWithConfigLines:(NSArray *)lines;
- (NSArray *)listSelectorNames;
- (SccpGttSelector *)getSelectorByName:(NSString *)name;
- (UMSynchronizedSortedDictionary *)config;
- (void)updateLogLevel:(UMLogLevel)newLogLevel;
- (void)updateLogFeed:(UMLogFeed *)newLogFeed;
- (void)finishUpdate;
- (SccpDestinationGroup *)getDestinationByName:(NSString *)name;

@end
