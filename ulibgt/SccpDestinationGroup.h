//
//  SccpDestinationGroup.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulibmtp3/ulibmtp3.h>
#import <ulibgt/SccpDestinationEntry.h>
#import <ulibgt/SccpL3RoutingTable.h>
@class SccpNumberTranslation;

typedef enum SccpDestinationGroupDistributionMethod
{
    SccpDestinationGroupDistributionMethod_cost  = 0,   /* equal distribution on lowest cost entries */
    SccpDestinationGroupDistributionMethod_share = 1,   /* equal distribution on all entries */
    SccpDestinationGroupDistributionMethod_wrr   = 2,   /* weighted distribution on lowest cost entries */
    SccpDestinationGroupDistributionMethod_cgpa  = 3,  /* not implemented yet */
} SccpDestinationGroupDistributionMethod;

@interface SccpDestinationGroup : UMObject
{
    NSString                                *_name;
    UMSynchronizedArray                     *_entries;
    SccpDestinationGroupDistributionMethod  _distributionMethod;
    BOOL                                    _class1LoadBalance;
    BOOL                                    _distributeSccpSequencedNegate;
    NSString                                *_dpcInstance;
    int                                     _lastIndex;
    NSString                                *_postTranslationName;
    SccpNumberTranslation                   *_postTranslation;
}

@property(readwrite,strong,atomic)  NSString *name;
@property(readwrite,assign,atomic)  SccpDestinationGroupDistributionMethod distributionMethod;
@property(readwrite,assign,atomic)  BOOL class1LoadBalance;
@property(readwrite,assign,atomic)  BOOL distributeSccpSequencedNegate;
@property(readwrite,strong,atomic)  NSString *dpcInstance;
@property(readwrite,strong,atomic)  NSString              *postTranslationName;
@property(readwrite,strong,atomic)  SccpNumberTranslation *postTranslation;
@property(readwrite,strong,atomic)  UMSynchronizedArray *entries;

- (void)addEntry:(SccpDestinationEntry *)dst;
- (SccpDestinationEntry *)entryAtIndex:(int)idx;

//- (SccpDestinationGroup *)initWithDpcString:(NSString *)string variant:(UMMTP3Variant)variant;
- (SccpDestinationEntry *)chooseNextHopWithRoutingTable:(SccpL3RoutingTable *)rt;
- (void)setConfig:(NSDictionary *)cfg applicationContext:(id)appContext;
- (SccpDestinationEntry *)pickRandom;
- (UMSynchronizedSortedDictionary *)status;
- (UMSynchronizedSortedDictionary *)statusForL3RoutingTable:(SccpL3RoutingTable *)rt;
- (NSString *)descriptionWithRt:(SccpL3RoutingTable *)rt;

@end
