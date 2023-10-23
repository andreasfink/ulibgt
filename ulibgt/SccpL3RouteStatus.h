//
//  SccpL3RouteStatus.h
//  ulibgt
//
//  Created by Andreas Fink on 19.03.18.
//  Copyright © 2018 Andreas Fink (andreas@fink.org). All rights reserved.
//



typedef enum SccpL3RouteStatus
{
    SccpL3RouteStatus_unknown = 0,
    SccpL3RouteStatus_available = 1,
    SccpL3RouteStatus_restricted = 2,
    SccpL3RouteStatus_unavailable = 3,
} SccpL3RouteStatus;

