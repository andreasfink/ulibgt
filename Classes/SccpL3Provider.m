//
//  SccpL3Provider.m
//  ulibgt
//
//  Created by Andreas Fink on 22/05/15.
//
//
// This source is dual licensed either under the GNU GENERAL PUBLIC LICENSE
// Version 3 from 29 June 2007 and other commercial licenses available by
// the author.

#if 0
#import "SccpL3Provider.h"

@implementation SccpL3Provider

@synthesize name;
@synthesize dpcRoutingTable;
@synthesize opc;
@synthesize dpc;
@synthesize ntt;
@synthesize variant;
@synthesize mtp3Layer;


- (SccpL3Provider *)copyWithZone:(NSZone *)zone
{
    SccpL3Provider *newObject = [[SccpL3Provider allocWithZone:zone]init];
    newObject->name=name;
    newObject->opc=opc;
    newObject->dpc=dpc;
    newObject->ntt=ntt;
    newObject->variant=variant;
    return newObject;
}


-(UMMTP3_Error) sendPDU:(NSData *)pdu
                    opc:(UMMTP3PointCode *)override_opc
                    dpc:(UMMTP3PointCode *)override_dpc
{
    UMMTP3PointCode *use_opc = opc;
    UMMTP3PointCode *use_dpc = dpc;
    if(override_opc)
    {
        use_opc = override_opc;
    }

    if(override_dpc)
    {
        use_dpc = override_dpc;
    }
    
    return [mtp3Layer sendPDU:pdu
                          opc:use_opc
                          dpc:use_dpc
                           si:MTP3_SERVICE_INDICATOR_SCCP
                           mp:0];
}

-(void)sendDataToProvider:(NSData *)ttlv priority:(int)p
{
#if 0
    if(layer_type==0)
    {
        mm_generic_layer *g = get_layer_by_name(MM_LAYER_MTP3,name.UTF8String);
        if(g)
        {
            layer_instance = g->layer_instance;
            layer_type = g->layer_type;
        }
        else
        {
            g = get_layer_by_name(MM_LAYER_M3UA,name.UTF8String);
            if(g)
            {
                layer_instance = g->layer_instance;
                layer_type = g->layer_type;
            }
        }
    }
    gw_assert(layer_instance >0);
 
    mm_layer_pass_message_down(mm_new_layer_message(
                                                    this_layer_type,
                                                    this_layer_instance,
                                                    layer_type,
                                                    layer_instance,
                                                    MT_MTP3_DATA,
                                                    MM_REQ,
                                                    0,
                                                    MS_UNSPECIFIED,
                                                    octstr_len(ttlv),
                                                    octstr_get_cstr(ttlv)),p);
#endif
}

-(BOOL)isAvailable
{
    return YES;
}

- (BOOL)dpcIsAvailable:(UMMTP3PointCode *)dpc
{
    return YES;
}

- (int)maxPduSize
{
    return mtp3Layer.maxPduSize;
}
@end

#endif

