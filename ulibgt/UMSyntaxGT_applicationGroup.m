//
//  UMSyntaxGT_applicationGroup.m
//  ulibgt
//
//  Created by Andreas Fink on 28.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "UMSyntaxGT_applicationGroup.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSyntaxGT_applicationGroup

- (UMSyntaxGT_applicationGroup *)initWithDelegate:(id<UMCommandActionProtocol>)delegate
{
    self = [super init];
    if(self)
    {
        /* exit */
        UMSyntaxToken_Const *exit  = [[UMSyntaxToken_Const  alloc]initWithString:@"exit"
                                                                            help:
                                      @"Exit from SS7 GTT Application Group sub-mode"
                                                                   caseSensitive:NO];
        exit.delegate = delegate;
        exit.commandAction = @"exit";
        [self addSubtoken:exit];



        /**********************************************/
        /* asname                                     */
        /**********************************************/
        UMSyntaxToken_Const *asname  = [[UMSyntaxToken_Const  alloc]initWithString:@"asname"
                                                                              help:@"add/remove/change an M3UA or SUA AS and optional ssn"
                                                                     caseSensitive:NO];
        [self  addSubtoken:asname];


        /**********************************************/
        /* asname {NAME}                              */
        /**********************************************/
        UMSyntaxToken_Name *asname_name  = [[UMSyntaxToken_Name alloc]initWithHelp:@"name of M3UA or SUA Application Server"];
        [asname addSubtoken:asname_name];


        /**********************************************/
        /* asname {NAME} {NUMBER}                     */
        /**********************************************/
        UMSyntaxToken_Number *asname_name_cost  = [[UMSyntaxToken_Number alloc]initWithString:@"<1-64>"
                                                                                help:@"cost of AS within application group"];
        [asname_name addSubtoken:asname_name_cost];


        /**********************************************/
        /* asname {NAME) {NUMBER} gt                  */
        /**********************************************/
        UMSyntaxToken_Const *asname_name_cost_gt  = [[UMSyntaxToken_Const alloc]initWithString:@"gt"
                                                                                         help:@"Set RI to Route on Global Title"];
        [asname_name_cost addSubtoken:asname_name_cost_gt];

        /**********************************************/
        /* asname {NAME) {NUMBER} gt ntt              */
        /**********************************************/
        UMSyntaxToken_Const *asname_name_cost_gt_ntt  = [[UMSyntaxToken_Const alloc]initWithString:@"ntt"
                                                                                           help:@"Specify a new Translation Type"];
        [asname_name_cost_gt addSubtoken:asname_name_cost_gt_ntt];

        /**********************************************/
        /* asname {NAME) {NUMBER} gt ntt {NUMBER}          */
        /**********************************************/
        UMSyntaxToken_Number *asname_name_cost_gt_ntt_num  = [[UMSyntaxToken_Number alloc]initWithString:@"<0-255>Y"
                                                                                               help:@"new translation type"];
        [asname_name_cost_gt_ntt addSubtoken:asname_name_cost_gt_ntt_num];

        /**********************************************/
        /* asname {NAME) {NUMBER} pcssn               */
        /**********************************************/
        UMSyntaxToken_Const *asname_name_cost_pcssn  = [[UMSyntaxToken_Const alloc]initWithString:@"pcssn"
                                                                                           help:@"Set RI to Route on Point Code and Subsystem Number"];
        [asname_name_cost addSubtoken:asname_name_cost_pcssn];

        /**********************************************/
        /* asname {NAME) {NUMBER} ssn                 */
        /**********************************************/
        UMSyntaxToken_Const *asname_name_cost_ssn  = [[UMSyntaxToken_Const alloc]initWithString:@"ssn"
                                                                                           help:@"specify a subsystem number"];
        [asname_name_cost addSubtoken:asname_name_cost_ssn];


        /**********************************************/
        /* asname {NAME) {NUMBER} ssn {NUMBER}        */
        /**********************************************/
        UMSyntaxToken_Number *asname_name_cost_ssn_number  = [[UMSyntaxToken_Number alloc]initWithString:@"<0,2-255>"
                                                                                            help:@"subsystem number"];
        [asname_name_cost_ssn addSubtoken:asname_name_cost_ssn_number];


        /**********************************************/
        /* asname {NAME) {NUMBER} ssn {NUMBER} gt     */
        /**********************************************/
        [asname_name_cost_ssn addSubtoken:asname_name_cost_gt]; /* reuse */
        [asname_name_cost_ssn addSubtoken:asname_name_cost_pcssn]; /* reuse */


        /**********************************************/
        /* pc                                         */
        /**********************************************/
        UMSyntaxToken_Const *pc  = [[UMSyntaxToken_Const alloc]initWithString:@"pc"
                                                                         help:@"add/remove/change a pc and optional ssn"];
        [self addSubtoken:pc];


        /**********************************************/
        /* pc {POINTCODE}                             */
        /**********************************************/
        UMSyntaxToken_Pointcode *pc_pointcode  = [[UMSyntaxToken_Pointcode alloc]initWithString:@"zone-region-sp"
                                                                                           help:@"SS7 point code"];
        [pc addSubtoken:pc_pointcode];


        /**********************************************/
        /* pc {POINTCODE}  {NUMBER}                   */
        /**********************************************/
        UMSyntaxToken_Number *pc_pointcode_cost  = [[UMSyntaxToken_Number alloc]initWithString:@"<1-64>"
                                                                                           help:@"cost"];
        [pc_pointcode addSubtoken:pc_pointcode_cost];

        [pc_pointcode_cost addSubtoken:asname_name_cost_gt]; /* reuse */
        [pc_pointcode_cost addSubtoken:asname_name_cost_pcssn]; /* reuse */


        /**********************************************/
        /* pc {POINTCODE} ssn                         */
        /**********************************************/
        [pc_pointcode addSubtoken:asname_name_cost_ssn]; /* reuse */

        /**********************************************/
        /* no                                         */
        /**********************************************/
        UMSyntaxToken_Const *no  = [[UMSyntaxToken_Const alloc]initWithString:@"no"
                                                                         help:@"Negate a command or set its default"];
        [self addSubtoken:no];
        [no addSubtoken:self];
    }
    return self;
}

@end
