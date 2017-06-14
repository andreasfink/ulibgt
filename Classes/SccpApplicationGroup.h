//
//  SccpApplicationGroup.h
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>

#import "SccpNextHop.h"

@interface SccpApplicationGroup : SccpNextHop
{
    NSMutableArray *_entries; /* entries of SccpNextHop objects */
}

- (void)addNextHop:(SccpNextHop *)hop;
- (SccpNextHop *)pickHopUsingProviders:(UMSynchronizedDictionary *)allProviders;
@end
