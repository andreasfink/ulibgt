//
//  SccpNumberTranslation.h
//  ulibgt
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import <ulib/ulib.h>

@interface SccpNumberTranslation : UMObject
{
    NSString *_name;
    NSArray *_entries;
}

- (SccpAddress *)translateAddress:(SccpAddress *)in;

@end

