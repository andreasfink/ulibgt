//
//  SccpDestination.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
#import "SccpDestination.h"

@interface SccpDestinationGroup : SccpDestination
{
    UMSynchronizedArray *_entries;
}

@end
