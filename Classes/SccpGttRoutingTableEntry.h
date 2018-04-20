//
//  SccpGttRoutingTableEntry.h
//  ulibgt
//
//  Created by Andreas Fink on 09.02.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

@class SccpGttRoutingTableAction;
@class SccpDestinationGroup;
@class SccpApplicationGroup;
@class SccpNumberTranslation;

@interface SccpGttRoutingTableEntry : UMObject
{
    NSString            *_digits;
    SccpDestinationGroup     *_routeTo;
    NSString            *_routeToName;
    NSString            *_postTranslationName;
    SccpNumberTranslation *_postTranslation;
}

@property(readwrite,atomic,strong)  NSString *digits;
@property(readwrite,atomic,strong)  SccpDestinationGroup *routeTo;
@property(readwrite,atomic,strong)  NSString *routeToName;
@property(readwrite,atomic,strong)  NSString    *postTranslationName;
@property(readwrite,atomic,strong)  SccpNumberTranslation *postTranslation;

- (SccpGttRoutingTableEntry *)initWithConfig:(NSDictionary *)cfg;
@end

