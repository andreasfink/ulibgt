//
//  UMSyntaxGT.m
//  ulibgt
//
//  Created by Andreas Fink on 28.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//
//
#import <ulibmtp3/ulibmtp3.h>

#import "UMSyntaxGT.h"

@implementation UMSyntaxGT

- (UMSyntaxGT *)initWithDelegate:(id<UMCommandActionProtocol>)delegate
{

    self = [super init];
    if(self)
    {

        UMSyntaxToken_Const *quit  = [[UMSyntaxToken_Const  alloc]initWithString:@"quit"
                                                                            help:@"Quitting telnet session"
                                                                   caseSensitive:NO];
        [self addSubtoken:quit];
        quit.delegate = delegate;
        quit.commandAction = @"quit";


        UMSyntaxToken_Const *exit  = [[UMSyntaxToken_Const  alloc]initWithString:@"exit"
                                                                            help:@"terminating telnet session"
                                                                   caseSensitive:NO];
        exit.delegate = delegate;
        exit.commandAction = @"exit";

        [self addSubtoken:exit];

        UMSyntaxToken_Const *cs7  = [[UMSyntaxToken_Const  alloc]initWithString:@"cs7"
                                                                           help:@"Configure UniversalSS7 over IP"
                                                                  caseSensitive:NO];
        [self addSubtoken:cs7];

        UMSyntaxToken_Const *accounting  = [[UMSyntaxToken_Const  alloc]initWithString:@"accounting"
                                                                                  help:@"Configure CS7 Accounting Options"
                                                                         caseSensitive:NO];
        [cs7 addSubtoken:accounting];


        UMSyntaxToken_Const *as  = [[UMSyntaxToken_Const  alloc]initWithString:@"as"
                                                                          help:@"Configure ASs for M3UA/SUA"
                                                                 caseSensitive:NO];
        [cs7 addSubtoken:as];

        UMSyntaxToken_Const *asp  = [[UMSyntaxToken_Const  alloc]initWithString:@"asp"
                                                                           help:@"Configure ASPs for M3UA/SUA"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:asp];

        UMSyntaxToken_Const *billing  = [[UMSyntaxToken_Const  alloc]initWithString:@"billing"
                                                                               help:@"billing configuration"
                                                                      caseSensitive:NO];
        [cs7 addSubtoken:billing];

        UMSyntaxToken_Const *cdr  = [[UMSyntaxToken_Const  alloc]initWithString:@"cdr"
                                                                           help:@"CDR Configuration commands"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:cdr];

        UMSyntaxToken_Const *clli  = [[UMSyntaxToken_Const  alloc]initWithString:@"clli"
                                                                            help:@"Common Language Location Code"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:clli];


        UMSyntaxToken_Const *dcs  = [[UMSyntaxToken_Const  alloc]initWithString:@"dcs"
                                                                           help:@"Configure Data Collector Server"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:dcs];

        UMSyntaxToken_Const *dcs_group  = [[UMSyntaxToken_Const  alloc]initWithString:@"dcs-group"
                                                                                 help:@"Configure Data Collector Server Group"
                                                                        caseSensitive:NO];
        [cs7 addSubtoken:dcs_group];

        UMSyntaxToken_Const *errors_gtt_interval  = [[UMSyntaxToken_Const  alloc]initWithString:@"errors-gtt-interval"
                                                                                           help:@"GTT errors interval"
                                                                                  caseSensitive:NO];
        [cs7 addSubtoken:errors_gtt_interval];


        UMSyntaxToken_Const *errors_gtt_recovery  = [[UMSyntaxToken_Const  alloc]initWithString:@"errors-gtt-recovery"
                                                                                           help:@"GTT errors recovery count(def 3)"
                                                                                  caseSensitive:NO];
        [cs7 addSubtoken:errors_gtt_recovery];


        UMSyntaxToken_Const *group  = [[UMSyntaxToken_Const  alloc]initWithString:@"group"
                                                                             help:@"Configure STP Group"
                                                                    caseSensitive:NO];
        [cs7 addSubtoken:group];

        UMSyntaxToken_Const *gtt  = [[UMSyntaxToken_Const  alloc]initWithString:@"gtt"
                                                                           help:@"GTT Configuration commands"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:gtt];


        UMSyntaxToken_Const *host  = [[UMSyntaxToken_Const  alloc]initWithString:@"host"
                                                                            help:@"Add an entry to the cs7 nodename table"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:host];

        UMSyntaxToken_Const *instance  = [[UMSyntaxToken_Const  alloc]initWithString:@"instance"
                                                                                help:@"Specify a specific CS7 instance"
                                                                       caseSensitive:NO];
        [cs7 addSubtoken:instance];

        UMSyntaxToken_Const *local_peer  = [[UMSyntaxToken_Const  alloc]initWithString:@"local-peer"
                                                                                  help:@"Configure CS7 local peer"
                                                                         caseSensitive:NO];
        [cs7 addSubtoken:local_peer];


        UMSyntaxToken_Const *log  = [[UMSyntaxToken_Const  alloc]initWithString:@"log-peer"
                                                                           help:@"log related options"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:log];

        UMSyntaxToken_Const *m3ua  = [[UMSyntaxToken_Const  alloc]initWithString:@"m3ua"
                                                                            help:@"Configure M3UA"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:m3ua];

        UMSyntaxToken_Const *map  = [[UMSyntaxToken_Const  alloc]initWithString:@"map"
                                                                           help:@"Configure CS7 MAP"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:map];

        UMSyntaxToken_Const *mapua  = [[UMSyntaxToken_Const  alloc]initWithString:@"mapua"
                                                                             help:@"Configure CS7 MAPUA"
                                                                    caseSensitive:NO];
        [cs7 addSubtoken:mapua];


        UMSyntaxToken_Const *mated_sg  = [[UMSyntaxToken_Const  alloc]initWithString:@"mated-sg"
                                                                                help:@"Configure connection to mated SG"
                                                                       caseSensitive:NO];
        [cs7 addSubtoken:mated_sg];

        UMSyntaxToken_Const *max_dynamic_routes  = [[UMSyntaxToken_Const  alloc]initWithString:@"max-dynamic-routes"
                                                                                          help:@"Maximum number of dynamic route entries"
                                                                                 caseSensitive:NO];
        [cs7 addSubtoken:max_dynamic_routes];

        UMSyntaxToken_Const *mlr  = [[UMSyntaxToken_Const  alloc]initWithString:@"mlr"
                                                                           help:@"Configure Multi-Layer Routing"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:mlr];


        UMSyntaxToken_Const *msu_rates  = [[UMSyntaxToken_Const  alloc]initWithString:@"msu-rates"
                                                                                 help:@"Config CS7 msu-rates parameters"
                                                                        caseSensitive:NO];
        [cs7 addSubtoken:msu_rates];


        UMSyntaxToken_Const *mtp3  = [[UMSyntaxToken_Const  alloc]initWithString:@"mtp3"
                                                                            help:@"Config MTP3"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:mtp3];


        UMSyntaxToken_Const *multi_instance  = [[UMSyntaxToken_Const  alloc]initWithString:@"multi-instance"
                                                                                      help:@"enable multiple instance configuration"
                                                                             caseSensitive:NO];
        [cs7 addSubtoken:multi_instance];


        UMSyntaxToken_Const *paklog  = [[UMSyntaxToken_Const  alloc]initWithString:@"paklog"
                                                                              help:@"Configure the IP address and port where pkts are copied out via UDP"
                                                                     caseSensitive:NO];
        [cs7 addSubtoken:paklog];


        UMSyntaxToken_Const *pc_conversion  = [[UMSyntaxToken_Const  alloc]initWithString:@"pc-conversion"
                                                                                     help:@"Convert a point code in this instance to a pointcode in another instance"
                                                                            caseSensitive:NO];
        [cs7 addSubtoken:pc_conversion];


        UMSyntaxToken_Const *pmp  = [[UMSyntaxToken_Const  alloc]initWithString:@"pmp"
                                                                           help:@"Probless Monitoring Global configuration"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:pmp];



        UMSyntaxToken_Const *profile  = [[UMSyntaxToken_Const  alloc]initWithString:@"profile"
                                                                               help:@"Configure CS7 link profile"
                                                                      caseSensitive:NO];
        [cs7 addSubtoken:profile];

        UMSyntaxToken_Const *prompt  = [[UMSyntaxToken_Const  alloc]initWithString:@"prompt"
                                                                              help:@"enable options relating to the prompt displayed on the CLI"
                                                                     caseSensitive:NO];
        [cs7 addSubtoken:prompt];


        UMSyntaxToken_Const *rate_limit  = [[UMSyntaxToken_Const  alloc]initWithString:@"rate-limit"
                                                                                  help:@"GTT overflow loadshare"
                                                                         caseSensitive:NO];
        [cs7 addSubtoken:rate_limit];


        UMSyntaxToken_Const *sccp  = [[UMSyntaxToken_Const  alloc]initWithString:@"sccp"
                                                                            help:@"SCCP Configuration commands"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:sccp];

        UMSyntaxToken_Const *sg_event_history  = [[UMSyntaxToken_Const  alloc]initWithString:@"sg-event-history"
                                                                                        help:@"Set maximum number of events to save in history"
                                                                               caseSensitive:NO];
        [cs7 addSubtoken:sg_event_history];

        UMSyntaxToken_Const *sgmp  = [[UMSyntaxToken_Const  alloc]initWithString:@"sgmp"
                                                                            help:@"Configure SGMP (Signaling Gateway Mate Protocol)"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:sgmp];



        UMSyntaxToken_Const *sms  = [[UMSyntaxToken_Const  alloc]initWithString:@"sms"
                                                                           help:@"Configure SMS"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:sms];


        UMSyntaxToken_Const *snmp  = [[UMSyntaxToken_Const  alloc]initWithString:@"snmp"
                                                                            help:@"SNMP related options"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:snmp];

        UMSyntaxToken_Const *sua  = [[UMSyntaxToken_Const  alloc]initWithString:@"sua"
                                                                           help:@"Configure SUA"
                                                                  caseSensitive:NO];
        [cs7 addSubtoken:sua];


        UMSyntaxToken_Const *tcap  = [[UMSyntaxToken_Const  alloc]initWithString:@"tcap"
                                                                            help:@"Configure CS7 TCAP"
                                                                   caseSensitive:NO];
        [cs7 addSubtoken:tcap];



        UMSyntaxToken_Const *util_abate  = [[UMSyntaxToken_Const  alloc]initWithString:@"util-abate"
                                                                                  help:@"Adjustment for falling threshold"
                                                                         caseSensitive:NO];
        [cs7 addSubtoken:util_abate];


        UMSyntaxToken_Const *util_plan_capacity  = [[UMSyntaxToken_Const  alloc]initWithString:@"util-plan-capacity"
                                                                                          help:@"util-plan-capacity"
                                                                                 caseSensitive:NO];
        [cs7 addSubtoken:util_plan_capacity];


        UMSyntaxToken_Const *util_sample_interval  = [[UMSyntaxToken_Const  alloc]initWithString:@"util-sample-interval"
                                                                                            help:@"Sample Interval for Link Utilization"
                                                                                   caseSensitive:NO];
        [cs7 addSubtoken:util_sample_interval];



        UMSyntaxToken_Const *util_threshold  = [[UMSyntaxToken_Const  alloc]initWithString:@"util-threshold"
                                                                                      help:@"Threshold for link utilization"
                                                                             caseSensitive:NO];
        [cs7 addSubtoken:util_threshold];


        UMSyntaxToken_Const *xua_as_based_congestion  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-as-based-congestion"
                                                                                               help:@"Base M3UA/SUA congestion on AS congestion level"
                                                                                      caseSensitive:NO];
        [cs7 addSubtoken:xua_as_based_congestion];


        UMSyntaxToken_Const *xua_daud_inactive  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-daud-inactive"
                                                                                         help:@"Allow DAUD from inactive ASPs"
                                                                                caseSensitive:NO];
        [cs7 addSubtoken:xua_daud_inactive];


        UMSyntaxToken_Const *xua_err_diag_fmt  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-err-diag-fmt"
                                                                                        help:@"M3UA/SUA ERR msg diagnostic info parameter format"
                                                                               caseSensitive:NO];
        [cs7 addSubtoken:xua_err_diag_fmt];


        UMSyntaxToken_Const *xua_errhandling  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-errhandling"
                                                                                       help:@"xua-errhandling"
                                                                              caseSensitive:NO];
        [cs7 addSubtoken:xua_errhandling];


        UMSyntaxToken_Const *xua_ssnm_filtering  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-ssnm-filtering"
                                                                                          help:@"Enable M3UA/SUA SSNM Filtering"
                                                                                 caseSensitive:NO];
        [cs7 addSubtoken:xua_ssnm_filtering];


        UMSyntaxToken_Const *xua_tfc_allowed  = [[UMSyntaxToken_Const  alloc]initWithString:@"xua-tfc-allowed"
                                                                                       help:@"Allow TFCs and SCONs for M3UA/SUA congestion"
                                                                              caseSensitive:NO];
        [cs7 addSubtoken:xua_tfc_allowed];


        UMSyntaxToken_Number *instance_number = [[UMSyntaxToken_Number  alloc]initWithString:@"<0-7>"
                                                                                        help:@"instance number"
                                                                               caseSensitive:NO];
        instance_number.min = 0;
        instance_number.max = 7;

        [instance addSubtoken:instance_number];

        UMSyntaxToken_Const *instance_as  = [[UMSyntaxToken_Const  alloc]initWithString:@"as"
                                                                                   help:@"Configure ASs for M3UA/SUA"
                                                                          caseSensitive:NO];
        [instance_number addSubtoken:instance_as];

        UMSyntaxToken_Const *instance_billing  = [[UMSyntaxToken_Const  alloc]initWithString:@"billing"
                                                                                        help:@"billing configuration"
                                                                               caseSensitive:NO];
        [instance_number addSubtoken:instance_billing];

        UMSyntaxToken_Const *instance_capability_pc  = [[UMSyntaxToken_Const  alloc]initWithString:@"capability-pc"
                                                                                              help:@"Configure Routers Capability point code"
                                                                                     caseSensitive:NO];
        [instance_number addSubtoken:instance_capability_pc];

        UMSyntaxToken_Const *instance_cdr  = [[UMSyntaxToken_Const  alloc]initWithString:@"cdr"
                                                                                    help:@"CDR Configuration commands"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_cdr];

        UMSyntaxToken_Const *instance_dcs  = [[UMSyntaxToken_Const  alloc]initWithString:@"dcs"
                                                                                    help:@"Configure Data Collector Server"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_dcs];

        UMSyntaxToken_Const *instance_dcs_group  = [[UMSyntaxToken_Const  alloc]initWithString:@"dcs-group"
                                                                                          help:@"Configure Data Collector Server Group"
                                                                                 caseSensitive:NO];
        [instance_number addSubtoken:instance_dcs_group];

        UMSyntaxToken_Const *instance_description  = [[UMSyntaxToken_Const  alloc]initWithString:@"description"
                                                                                            help:@"Description of Signalling Point"
                                                                                   caseSensitive:NO];
        [instance_number addSubtoken:instance_description];

        UMSyntaxToken_Const *instance_display_name  = [[UMSyntaxToken_Const  alloc]initWithString:@"display-name"
                                                                                             help:@"Display name for Signalling Point"
                                                                                    caseSensitive:NO];
        [instance_number addSubtoken:instance_display_name];

        UMSyntaxToken_Const *instance_distribute_sccp_sequenced  = [[UMSyntaxToken_Const  alloc]initWithString:@"distribute-sccp-sequenced"
                                                                                                          help:@"Evenly distribute Class 1 SCCP non segmented messages"
                                                                                                 caseSensitive:NO];
        [instance_number addSubtoken:instance_distribute_sccp_sequenced];

        UMSyntaxToken_Const *instance_distribute_sccp_unsequenced  = [[UMSyntaxToken_Const  alloc]initWithString:@"distribute-sccp-unsequenced"
                                                                                                            help:@"Evenly distribute Class 0 SCCP messages"
                                                                                                   caseSensitive:NO];
        [instance_number addSubtoken:instance_distribute_sccp_unsequenced];

        UMSyntaxToken_Const *instance_fast_restart  = [[UMSyntaxToken_Const  alloc]initWithString:@"fast-restart"
                                                                                             help:@"Enable MTP3 fast restart"
                                                                                    caseSensitive:NO];
        [instance_number addSubtoken:instance_fast_restart];

        UMSyntaxToken_Const *instance_gtt  = [[UMSyntaxToken_Const  alloc]initWithString:@"gtt"
                                                                                    help:@"GTT Configuration commands"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_gtt];

        UMSyntaxToken_Const *instance_gws  = [[UMSyntaxToken_Const  alloc]initWithString:@"gws"
                                                                                    help:@"Configure Enhanced Gateway Screening"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_gws];

        UMSyntaxToken_Const *instance_host  = [[UMSyntaxToken_Const  alloc]initWithString:@"host"
                                                                                     help:@"Add an entry to the cs7 nodename table"
                                                                            caseSensitive:NO];
        [instance_number addSubtoken:instance_host];

        UMSyntaxToken_Const *instance_ignore_sccp_pcconv  = [[UMSyntaxToken_Const  alloc]initWithString:@"ignore-sccp-pcconv"
                                                                                                   help:@"ignore pc conversion failure in CxPA"
                                                                                          caseSensitive:NO];
        [instance_number addSubtoken:instance_ignore_sccp_pcconv];

        UMSyntaxToken_Const *instance_large_msu_support  = [[UMSyntaxToken_Const  alloc]initWithString:@"large-msu-support"
                                                                                                  help:@"Configure large MSU support"
                                                                                         caseSensitive:NO];
        [instance_number addSubtoken:instance_large_msu_support];

        UMSyntaxToken_Const *instance_linkset  = [[UMSyntaxToken_Const  alloc]initWithString:@"linkset"
                                                                                        help:@"Configure CS7 linkset"
                                                                               caseSensitive:NO];
        [instance_number addSubtoken:instance_linkset];

        UMSyntaxToken_Const *instance_local_peer  = [[UMSyntaxToken_Const  alloc]initWithString:@"local-peer"
                                                                                           help:@"Configure CS7 local peer"
                                                                                  caseSensitive:NO];
        [instance_number addSubtoken:instance_local_peer];

        UMSyntaxToken_Const *instance_local_sccp_addr_ind  = [[UMSyntaxToken_Const  alloc]initWithString:@"local-sccp-addr-ind"
                                                                                                    help:@"Configure address indicator for local SCCP msgs"
                                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_local_sccp_addr_ind];

        UMSyntaxToken_Const *instance_mlr  = [[UMSyntaxToken_Const  alloc]initWithString:@"mlr"
                                                                                    help:@"Configure Multi-Layer Routing"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_mlr];

        UMSyntaxToken_Const *instance_mtp3  = [[UMSyntaxToken_Const  alloc]initWithString:@"mtp3"
                                                                                     help:@"Configure MTP3"
                                                                            caseSensitive:NO];
        [instance_number addSubtoken:instance_mtp3];

        UMSyntaxToken_Const *instance_national_options  = [[UMSyntaxToken_Const  alloc]initWithString:@"national-options"
                                                                                                 help:@"Configure options for variant specific national routing"
                                                                                        caseSensitive:NO];
        [instance_number addSubtoken:instance_national_options];

        UMSyntaxToken_Const *instance_network_indicator  = [[UMSyntaxToken_Const  alloc]initWithString:@"network-indicator"
                                                                                                  help:@"Configure network indicator"
                                                                                         caseSensitive:NO];
        [instance_number addSubtoken:instance_network_indicator];

        UMSyntaxToken_Const *instance_network_name  = [[UMSyntaxToken_Const  alloc]initWithString:@"network-name"
                                                                                             help:@"Network Name for Signalling Point"
                                                                                    caseSensitive:NO];
        [instance_number addSubtoken:instance_network_name];

        UMSyntaxToken_Const *instance_pam  = [[UMSyntaxToken_Const  alloc]initWithString:@"pam"
                                                                                    help:@"Configure Packet Address Modification"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_pam];

        UMSyntaxToken_Const *instance_pc_conversion  = [[UMSyntaxToken_Const  alloc]initWithString:@"pc-conversion"
                                                                                              help:@"Convert a point code in this instance to a point code in another instance"
                                                                                     caseSensitive:NO];
        [instance_number addSubtoken:instance_pc_conversion];

        UMSyntaxToken_Const *instance_pmp  = [[UMSyntaxToken_Const  alloc]initWithString:@"pmp"
                                                                                    help:@"Probless Monitoring Global configuration"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_pmp];

        UMSyntaxToken_Const *instance_point_code  = [[UMSyntaxToken_Const  alloc]initWithString:@"point-code"
                                                                                           help:@"Configure routers MTP3 point code"
                                                                                  caseSensitive:NO];
        [instance_number addSubtoken:instance_point_code];

        UMSyntaxToken_Const *instance_qos  = [[UMSyntaxToken_Const  alloc]initWithString:@"qos"
                                                                                    help:@"Configure CS7 qos"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_qos];

        UMSyntaxToken_Const *instance_rate_limit  = [[UMSyntaxToken_Const  alloc]initWithString:@"rate-limit"
                                                                                           help:@"GTT overflow loadshare"
                                                                                  caseSensitive:NO];
        [instance_number addSubtoken:instance_rate_limit];

        UMSyntaxToken_Const *instance_remote_congestion_msgs  = [[UMSyntaxToken_Const  alloc]initWithString:@"remote-congestion-msgs"
                                                                                                       help:@"Allow remote congestion status console messages"
                                                                                              caseSensitive:NO];
        [instance_number addSubtoken:instance_remote_congestion_msgs];

        UMSyntaxToken_Const *instance_route_mgmt_sls  = [[UMSyntaxToken_Const  alloc]initWithString:@"route-mgmt-sls"
                                                                                               help:@"Configure route management sls assignment option"
                                                                                      caseSensitive:NO];
        [instance_number addSubtoken:instance_route_mgmt_sls];

        UMSyntaxToken_Const *instance_route_table  = [[UMSyntaxToken_Const  alloc]initWithString:@"route-table"
                                                                                            help:@"Configure CS7 route table"
                                                                                   caseSensitive:NO];
        [instance_number addSubtoken:instance_route_table];

        UMSyntaxToken_Const *instance_sccp  = [[UMSyntaxToken_Const  alloc]initWithString:@"sccp"
                                                                                     help:@"SCCP Configuration commands"
                                                                            caseSensitive:NO];
        [instance_number addSubtoken:instance_sccp];

        UMSyntaxToken_Const *instance_sccp_allow_pak_conv  = [[UMSyntaxToken_Const  alloc]initWithString:@"sccp-allow-pak-conv"
                                                                                                    help:@"Configure sccp packet conversion from XUDT/S to UDT/S and vice versa."
                                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_sccp_allow_pak_conv];

        UMSyntaxToken_Const *instance_sccp_class1_loadshare  = [[UMSyntaxToken_Const  alloc]initWithString:@"sccp-class1-loadshare"
                                                                                                      help:@"Configure loadshare method for SCCP class1 in GTT appgrp"
                                                                                             caseSensitive:NO];
        [instance_number addSubtoken:instance_sccp_class1_loadshare];

        UMSyntaxToken_Const *instance_sccp_class1_wrr  = [[UMSyntaxToken_Const  alloc]initWithString:@"sccp-class1-wrr"
                                                                                                help:@"Configure weighted round robin method for SCCP class1 in GTT appgrp"
                                                                                       caseSensitive:NO];
        [instance_number addSubtoken:instance_sccp_class1_wrr];

        UMSyntaxToken_Const *instance_secondary_pc  = [[UMSyntaxToken_Const  alloc]initWithString:@"secondary-pc"
                                                                                             help:@"Configure Routers Secondary point code"
                                                                                    caseSensitive:NO];
        [instance_number addSubtoken:instance_secondary_pc];

        UMSyntaxToken_Const *instance_sls_opc_dpc  = [[UMSyntaxToken_Const  alloc]initWithString:@"sls-opc-dpc"
                                                                                            help:@"Create additional SLS bits based on OPC and DPC"
                                                                                   caseSensitive:NO];
        [instance_number addSubtoken:instance_sls_opc_dpc];

        UMSyntaxToken_Const *instance_sls_shift  = [[UMSyntaxToken_Const  alloc]initWithString:@"sls-shift"
                                                                                          help:@"Shift which SLS bits are used for link and linkset selection"
                                                                                 caseSensitive:NO];
        [instance_number addSubtoken:instance_sls_shift];

        UMSyntaxToken_Const *instance_sms  = [[UMSyntaxToken_Const  alloc]initWithString:@"sms"
                                                                                    help:@"Configure SMS"
                                                                           caseSensitive:NO];
        [instance_number addSubtoken:instance_sms];

        UMSyntaxToken_Const *instance_sua_allow_xudt_request  = [[UMSyntaxToken_Const  alloc]initWithString:@"sua-allow-xudt-request"
                                                                                                       help:@"Request XUDT msg when hop count or importance rcvd from ASP"
                                                                                              caseSensitive:NO];
        [instance_number addSubtoken:instance_sua_allow_xudt_request];

        UMSyntaxToken_Const *instance_summary_routing_exception  = [[UMSyntaxToken_Const  alloc]initWithString:@"summary-routing-exception"
                                                                                                          help:@"No summary/cluster routing for configured full PC members"
                                                                                                 caseSensitive:NO];
        [instance_number addSubtoken:instance_summary_routing_exception];

        UMSyntaxToken_Const *instance_tfc_pacing_ratio  = [[UMSyntaxToken_Const  alloc]initWithString:@"tfc-pacing-ratio"
                                                                                                 help:@"Ratio of TFCs to received messages"
                                                                                        caseSensitive:NO];
        [instance_number addSubtoken:instance_tfc_pacing_ratio];

        UMSyntaxToken_Const *instance_variant  = [[UMSyntaxToken_Const  alloc]initWithString:@"variant"
                                                                                        help:@"Configure SS7 protocol variant"
                                                                               caseSensitive:NO];
        [instance_number addSubtoken:instance_variant];



        UMSyntaxToken_Number *instance_local_peer_port_number = [[UMSyntaxToken_Number  alloc]initWithString:@"<1024-49151>"
                                                                                                        help:@"local-peer port number"
                                                                                               caseSensitive:NO];
        instance_local_peer_port_number.min = 1024;
        instance_local_peer_port_number.max = 49151;
        [instance_local_peer addSubtoken:instance_local_peer_port_number];

        UMSyntaxToken_Const *instance_local_peer_port_number_offload  = [[UMSyntaxToken_Const  alloc]initWithString:@"offload"
                                                                                                               help:@"Configure local peer for VIP offload"
                                                                                                      caseSensitive:NO];
        [instance_local_peer_port_number addSubtoken:instance_local_peer_port_number_offload];
        
        
        
        UMSyntaxToken_Name *instance_linkset_name = [[UMSyntaxToken_Name alloc]init];
        [instance_linkset addSubtoken:instance_linkset_name];
        
        UMSyntaxToken_Pointcode *instance_linkset_name_pointcode = [[UMSyntaxToken_Pointcode alloc]init];
        [instance_linkset_name addSubtoken:instance_linkset_name_pointcode];
        
        instance_linkset_name.delegate = delegate;
        instance_linkset_name.commandAction = @"select-linkset";
        
        instance_linkset_name_pointcode.delegate = delegate;
        instance_linkset_name_pointcode.commandAction = @"linkset-pointcode";
        
    }
    return self;
}
@end


