//
//  SccpRoutingTable.h
//  MessageMover
//
//  Created by Andreas Fink on 22/05/15.
//
//

#import <ulib/ulib.h>


@class SccpApplicationGroup;
@class SccpNextHop;
@class SccpL3Provider;

@interface SccpGttSelector : UMObject
{
    NSString        *sccp_instance;
    NSString        *gtt_selector;
    int             tt;
    int             gti;
    int             np;
    int             nai;
    int             external;
    int             internal;
    NSMutableDictionary  *_entries;
    SccpNextHop     *defaultEntry;
    NSDictionary    *statusOfProviders;
}

@property(readwrite,strong) SccpNextHop *defaultEntry;
-(SccpNextHop *) routeToProvider:(NSString *)digits;


@property(readwrite,strong) NSString        *sccp_instance;
@property(readwrite,strong) NSString        *gtt_selector;
@property(readwrite,assign) int             tt;
@property(readwrite,assign) int             gti;
@property(readwrite,assign) int             np;
@property(readwrite,assign) int             nai;
@property(readwrite,assign) int             external;
@property(readwrite,assign) int             internal;

-(SccpGttSelector *)initWithInstanceNameE164:(NSString *)name;

@end
