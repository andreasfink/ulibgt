//
//  SccpL3Provider.h
//  MessageMover
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#import <ulib/ulib.h>
#import <ulibmtp3/ulibmtp3.h>


@interface SccpL3Provider : UMObject
{
    NSString     *name;
    NSDictionary *dpcRoutingTable;
    UMMTP3PointCode *opc;
    UMMTP3PointCode *dpc;
    UMMTP3Variant variant;
    int          ntt;
    UMLayerMTP3  *mtp3Layer;
}

@property(readwrite,strong) NSString *name;
@property(readwrite,strong) NSDictionary *dpcRoutingTable;

@property(readwrite,strong) UMMTP3PointCode *opc;
@property(readwrite,strong) UMMTP3PointCode *dpc;
@property(readwrite,assign) int          ntt;
@property(readwrite,assign) UMMTP3Variant variant;
@property(readwrite,strong) UMLayerMTP3  *mtp3Layer;


- (BOOL)isAvailable;
- (BOOL)dpcIsAvailable:(UMMTP3PointCode *)dpc;

-(UMMTP3_Error) sendPDU:(NSData *)pdu
                    opc:(UMMTP3PointCode *)opc
                    dpc:(UMMTP3PointCode *)dpc;
-(int) maxPduSize;
@end
