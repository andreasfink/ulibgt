//
//  SccpDestination.h
//  ulibgt
//
//  Created by Andreas Fink on 17.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>
#import "SccpDestinationEntry.h"

@interface SccpDestinationGroup : SccpDestinationEntry
{
    UMSynchronizedArray *_entries;
}

@end
