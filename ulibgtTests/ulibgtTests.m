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
    SccpGttRoutingTable *_routingTableE164;
    SccpGttSelector *_selectorE164;

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
        
    _selectorE164 = [[SccpGttSelector alloc]initWithConfig:@{
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

    _routingTableE164 = _selectorE164.routingTable;

    NSArray *configs = @[
    @{
      @"table": @"e164-tt0",
      @"group": @"sccp-translation-table-entry",
      @"gta": @"default",
      @"destination": @"default-route"
    }
    ,
    @{
      @"group": @"sccp-translation-table-entry",
      @"table": @"e164-tt0",
      @"gta": @"85513000222",
      @"transaction-id-range": @"100-199",
      @"destination": @"route-100-199"
    }
    ,
    @{
      @"group": @"sccp-translation-table-entry",
      @"table": @"e164-tt0",
      @"gta": @"85513000222",
      @"transaction-id-range": @"0-99",
      @"destination": @"route-0-99"
    }
    ,
    @{
      @"group": @"sccp-translation-table-entry",
      @"table": @"e164-tt0",
      @"gta": @"85513000222",
      @"destination": @"default-88"
    }
    ];
    
    for (NSDictionary *config in configs)
    {
        SccpGttRoutingTableEntry *e = [[SccpGttRoutingTableEntry alloc]initWithConfig:config];
        [_routingTableE164 addEntry:e];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _routingTableE164 = NULL;
    [super tearDown];
}

/*
- (void)testExample
{
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

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
    SccpGttRoutingTableEntry *e;
    e = [_routingTableE164 findEntryByDigits:@"999"      transactionNumber:@(99) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"999->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"default-route"] , @"Pass");
    
    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(0) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt0->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-0-99"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(1) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt1->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-0-99"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(99) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt99->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-0-99"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(100) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt100->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-100-199"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(101) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt101->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-100-199"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(199) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt199->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"route-100-199"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(200) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt200->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"default-88"] , @"Pass");

    e = [_routingTableE164 findEntryByDigits:@"85513000222"        transactionNumber:@(201) ssn:@(11)   operation:NULL appContext:NULL];
    NSLog(@"85513000222:tt201->%@",e.routeToName);
    XCTAssert([e.routeToName isEqualToString:@"default-88"] , @"Pass");
}
@end
