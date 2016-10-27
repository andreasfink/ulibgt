//
//  SccpApplicationGroup.h
//  MessageMover
//
//  Created by Andreas Fink on 22/05/15.
//
//

#import <ulib/ulib.h>

#import "SccpNextHop.h"

@interface SccpApplicationGroup : SccpNextHop
{
    NSMutableArray *_entries; /* entries of SccpNextHop objects */
}

-(void)addNextHop:(SccpNextHop *)hop;
- (SccpNextHop *)pickHopUsingProviders:(UMSynchronizedDictionary *)allProviders;
@end
