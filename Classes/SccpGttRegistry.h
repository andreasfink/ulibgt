//
//  SccpGttRegistry.h
//  MessageMover
//
//  Created by Andreas Fink on 29/05/15.
//
//

#import <ulib/ulib.h>


@class SccpGttSelector;

@interface SccpGttRegistry : UMObject
{
    UMSynchronizedDictionary *entries;
}

- (SccpGttSelector *)selectorForInstance:(NSString *)instance
                                      tt:(int)tt
                                     gti:(int)gti
                                      np:(int)np
                                     nai:(int)nai
                            internalOnly:(BOOL)internal_only
                            externalOnly:(BOOL)external_only;

- (void)addEntry:(SccpGttSelector *)sel;


@end
