//
//  ulibgtTests.m
//  ulibgtTests
//
//  Created by Andreas Fink on 29/05/15.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>
#import <ulibgt/ulibgt.h>
#import <XCTest/XCTest.h>

@interface ulibgtTests : XCTestCase
{
    SccpGttRoutingTable *_routingTable;
    SccpGttSelector *_selector;

    SccpGttRoutingTableEntry *_rtEntryDefault;
    SccpGttRoutingTableEntry *_rtEntry1;
    SccpGttRoutingTableEntry *_rtEntry2;
    SccpGttRoutingTableEntry *_rtEntry21;
    SccpGttRoutingTableEntry *_rtEntry21tt500;
    SccpGttRoutingTableEntry *_rtEntry21tt600700;
    SccpGttRoutingTableEntry *_rtEntry21ssn10;
    SccpGttRoutingTableEntry *_rtEntry22;
    SccpGttRoutingTableEntry *_rtEntry22op10;
    SccpGttRoutingTableEntry *_rtEntry22op1516;
    SccpGttRoutingTableEntry *_rtEntry22ac1000_2000;
    SccpGttRoutingTableEntry    *_rt85513000222_ttrange1;
    SccpGttRoutingTableEntry    *_rt85513000222_ttrange2;
    SccpGttRoutingTableEntry    *_rt85513000222_ttrange3;
    SccpGttRoutingTableEntry    *_rt85513000222_default;
    

}
@end

@implementation ulibgtTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
        
    _selector = [[SccpGttSelector alloc]initWithConfig:@{
                    @"name" : @"E164-TT0",
                    @"sccp" : @"sccp-1",
                    @"tt" : @(0),
                    @"gti" : @(4),
                    @"np" : @(1),
                    @"nai" : @(4),
                    @"pre-translation": @"pre-translation1",
                    @"post-translation": @"post-translation1",
                    @"default-destination": @"default-destination1",
                    }];
    _routingTable = _selector.routingTable;

    _rtEntryDefault = [[SccpGttRoutingTableEntry alloc]initWithConfig:
                                                @{
                                                    @"table" : @"E164-TT0",
                                                    @"gta"   : @"default",
                                                    @"destination": @"default-destination2",
                                                    @"post-translation": @"post-translation2",
                                                    @"gt-owner": @"owner2",
                                                    @"gt-user": @"user2",
                                                }];
    [_routingTable addEntry:_rtEntryDefault];

    _rtEntry1 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
                                                @{
                                                    @"table" : @"E164-TT0",
                                                    @"gta"   : @"1",
                                                    @"destination": @"destination-1",
                                                }];
    [_routingTable addEntry:_rtEntry1];

    /*------*/

    _rtEntry2 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table" : @"E164-TT0",
        @"gta"   : @"2",
        @"destination": @"destination-2",
    }];
    [_routingTable addEntry:_rtEntry2];

    /*------*/

    _rtEntry21 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table" : @"E164-TT0",
        @"gta"   : @"21",
        @"destination": @"destination-21",
    }];
    [_routingTable addEntry:_rtEntry21];

    /*------*/

    _rtEntry22 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table" : @"E164-TT0",
        @"gta"   : @"22",
        @"destination": @"destination-22",
    }];
    [_routingTable addEntry:_rtEntry22];

    /*------*/

    _rtEntry21tt500 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"21",
        @"destination"          : @"destination-21-500",
        @"transaction-id-start" : @(500),
        @"transaction-id-end"   : @(500),
    }];
    [_routingTable addEntry:_rtEntry21tt500];

    /*------*/

    _rtEntry21tt600700 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"21",
        @"destination"          : @"destination-21-600-700",
        @"transaction-id-start" : @(600),
        @"transaction-id-end"   : @(700),
    }];
    [_routingTable addEntry:_rtEntry21tt600700];

    /*------*/

    _rtEntry21ssn10 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"21",
        @"destination"          : @"destination-22ssn10",
        @"ssn"                  : @(20),
    }];
    [_routingTable addEntry:_rtEntry21ssn10];

    /*------*/

    _rtEntry22op10 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"22",
        @"destination"          : @"destination-22op10",
        @"opcopde"              : @"20",
    }];
    [_routingTable addEntry:_rtEntry22op10];

    /*------*/

    _rtEntry22op1516 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"22",
        @"destination"          : @"destination-22op1516",
        @"opcopde"              : @"15,16",
    }];
    [_routingTable addEntry:_rtEntry22op1516];

    
    _rtEntry22ac1000_2000 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"22",
        @"destination"          : @"destination-22ac1000_2000",
        @"application-context"  : @"100,200",
    }];
    [_routingTable addEntry:_rtEntry22ac1000_2000];
    
    
    _rt85513000222_default = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"85513000222",
        @"destination"          : @"default",
    }];
    [_routingTable addEntry:_rt85513000222_default];
    
    _rt85513000222_ttrange1 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"85513000222",
        @"destination"          : @"range1",
        @"transaction-id-start" : @(0),
        @"transaction-id-end"   : @(65535),

    }];
    [_routingTable addEntry:_rt85513000222_ttrange1];

    _rt85513000222_ttrange2 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"85513000222",
        @"destination"          : @"range2",
        @"transaction-id-start" : @(655360),
        @"transaction-id-end"   : @(720895),

    }];
    [_routingTable addEntry:_rt85513000222_ttrange3];

    _rt85513000222_ttrange3 = [[SccpGttRoutingTableEntry alloc]initWithConfig:
    @{
        @"table"                : @"E164-TT0",
        @"gta"                  : @"85513000222",
        @"destination"          : @"range3",
        @"transaction-id-start" : @(655360),
        @"transaction-id-end"   : @(720895),
    }];
    [_routingTable addEntry:_rt85513000222_ttrange3];

    _routingTable.logLevel = 0;
    UMLogHandler *h = [[UMLogHandler alloc]initWithConsole];
    _routingTable.logFeed = [[UMLogFeed alloc]initWithHandler:h];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _routingTable = NULL;
    [super tearDown];
}

- (void)testExample
{
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}
/*
- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/
- (void)testRouting1
{
    /*
    SccpGttRoutingTableEntry *_rtEntryDefault;
    SccpGttRoutingTableEntry *_rtEntry1;
    SccpGttRoutingTableEntry *_rtEntry2;
    SccpGttRoutingTableEntry *_rtEntry21;
    SccpGttRoutingTableEntry *_rtEntry21_tt600700;
    SccpGttRoutingTableEntry *_rtEntry21ssn10;
    SccpGttRoutingTableEntry *_rtEntry22;
    SccpGttRoutingTableEntry *_rtEntry22tt500;
    SccpGttRoutingTableEntry *_rtEntry22op10;
    SccpGttRoutingTableEntry *_rtEntry22op1516;
    SccpGttRoutingTableEntry *_rtEntry22ac1000_2000;
     */

    SccpGttRoutingTableEntry *e;
    e = [_routingTable findEntryByDigits:@"999"      transactionNumber:@(99) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntryDefault , @"Pass");
    
    e = [_routingTable findEntryByDigits:@"1"        transactionNumber:@(99) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry1 , @"Pass");

    e = [_routingTable findEntryByDigits:@"2"        transactionNumber:@(99) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry2 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(99) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(500) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21tt500 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(599) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(600) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21tt600700 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(601) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21tt600700 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(699) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21tt600700 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(700) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21tt600700 , @"Pass");

    e = [_routingTable findEntryByDigits:@"21"        transactionNumber:@(701) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    XCTAssert(e ==_rtEntry21 , @"Pass");
    
    e = [_routingTable findEntryByDigits:@"85513000222"        transactionNumber:@(701) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    NSLog(@"85513000222 tid701 -> %@",e.routeToName);
    XCTAssert(e ==_rt85513000222_ttrange1 , @"Pass");

    e = [_routingTable findEntryByDigits:@"85513000222"        transactionNumber:@(655370) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    NSLog(@"85513000222 tid655370 -> %@",e.routeToName);
    XCTAssert(e ==_rt85513000222_ttrange3 , @"Pass");

    e = [_routingTable findEntryByDigits:@"85513000222"        transactionNumber:@(720895) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    NSLog(@"85513000222 tid720895 -> %@",e.routeToName);
    XCTAssert(e ==_rt85513000222_ttrange3 , @"Pass");

    e = [_routingTable findEntryByDigits:@"85513000222"        transactionNumber:@(800000) ssn:@(11)   operation:@(00) appContext:@"aaaa"];
    NSLog(@"85513000222 tid800000 -> %@",e.routeToName);
    XCTAssert(e ==_rt85513000222_default , @"Pass");
}
@end
