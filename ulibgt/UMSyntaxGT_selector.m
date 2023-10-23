//
//  UMSyntaxGT_selector.m
//  ulibgt
//
//  Created by Andreas Fink on 28.03.17.
//  Copyright © 2017 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "UMSyntaxGT_selector.h"

@implementation UMSyntaxGT_selector

- (UMSyntaxGT_selector *)initWithDelegate:(id<UMCommandActionProtocol>)delegate
{

    self = [super init];
    if(self)
    {
        /* exit */
        UMSyntaxToken_Const *exit  = [[UMSyntaxToken_Const  alloc]initWithString:@"exit"
                                                                            help:
                                @"Exit from SS7 GTT Selector configuration sub-mode"
                                                                   caseSensitive:NO];
        exit.delegate = delegate;
        exit.commandAction = @"exit";
        [self addSubtoken:exit];


        /* gta */
        UMSyntaxToken_Const *gta  = [[UMSyntaxToken_Const  alloc]initWithString:@"gta"
                                                                           help:@"update a GTA in the selector table"
                                                                  caseSensitive:NO];
        [self addSubtoken:gta];

        /*gta {digits} */
        UMSyntaxToken_Digits *digits = [[UMSyntaxToken_Digits alloc]init];
        [gta addSubtoken:digits];


        /* gta {digits} app-grp */
        UMSyntaxToken_Const *app_grp  = [[UMSyntaxToken_Const  alloc]initWithString:@"app-grp"
                                                                                  help:@" WORD  name of Application Group"
                                                                         caseSensitive:NO];
        [digits addSubtoken:app_grp];


        /* gta {digits} app-grp {NAME) */
        UMSyntaxToken_Name *app_grp_name  = [[UMSyntaxToken_Name alloc]initWithHelp:@"name of Application Group"];
        [app_grp addSubtoken:app_grp_name];


        /* gta {digits} asname */
        UMSyntaxToken_Const *asname  = [[UMSyntaxToken_Const  alloc]initWithString:@"asname"
                                                                              help:@"gta translates to M3UA or SUA application server name"
                                                                     caseSensitive:NO];
        [digits addSubtoken:asname];


        /**********************************************/
        /* gta {digits} asname {NAME)                 */
        /**********************************************/
        UMSyntaxToken_Name *asname_name  = [[UMSyntaxToken_Name alloc]initWithHelp:@"name of M3UA or SUA Application Server"];
        [asname addSubtoken:asname_name];


        /**********************************************/
        /* gta {digits} asname {NAME) gt              */
        /**********************************************/

        UMSyntaxToken_Const *asname_name_gt  = [[UMSyntaxToken_Const alloc]initWithString:@"gt"
                                                                                 help:@"Set RI to Route on Global Title"
                                                                        caseSensitive:NO];

        [asname_name addSubtoken:asname_name_gt];



        /**********************************************/
        /* gta {digits} asname {NAME) gt ntt          */
        /**********************************************/

        UMSyntaxToken_Const *asname_name_gt_ntt  = [[UMSyntaxToken_Const alloc]initWithString:@"ntt"
                                                                                     help:@"Specify a new Translation Type"
                                                                            caseSensitive:NO];

        [asname_name_gt addSubtoken:asname_name_gt_ntt];


        /**********************************************/
        /* gta {digits} asname {NAME) gt ntt {number} */
        /**********************************************/
        UMSyntaxToken_Number *asname_name_gt_ntt_number  = [[UMSyntaxToken_Number alloc]initWithString:@"<0-255>"
                                                                                                  help:@"new translation type"
                                                                                         caseSensitive:NO];

        [asname_name_gt_ntt addSubtoken:asname_name_gt_ntt_number];


        /**********************************************/
        /* gta {digits} asname {NAME) gt ssn          */
        /**********************************************/

        UMSyntaxToken_Const *asname_name_gt_ssn  = [[UMSyntaxToken_Const alloc]initWithString:@"ssn"
                                                                                        help:@"specify a subsystem number"
                                                                                         caseSensitive:NO];
        [asname_name_gt addSubtoken:asname_name_gt_ssn];


        /**********************************************/
        /* gta {digits} asname {NAME) gt ssn {number} */
        /**********************************************/
        UMSyntaxToken_Number *asname_name_gt_ssn_number  = [[UMSyntaxToken_Number alloc]initWithString:@"<0,2-255>"
                                                                                                  help:@"subsystem number"
                                                                                         caseSensitive:NO];

        [asname_name_gt_ssn addSubtoken:asname_name_gt_ssn_number];


        /**********************************************/
        /* gta {digits} asname {NAME) pcssn          */
        /**********************************************/
        UMSyntaxToken_Const *asname_name_pcssn = [[UMSyntaxToken_Const alloc]initWithString:@"pcssn"
                                                                                       help:@"Set RI to Route on Point Code and Subsystem Number"
                                                                                         caseSensitive:NO];

        [asname_name addSubtoken:asname_name_pcssn];
        [asname_name_pcssn addSubtoken:asname_name_gt_ntt]; /*reuse */
        [asname_name_pcssn addSubtoken:asname_name_gt_ssn]; /*reuse */

        /**********************************************/
        /* gta {digits} pcssn                         */
        /**********************************************/
        UMSyntaxToken_Const *pcssn  = [[UMSyntaxToken_Const  alloc]initWithString:@"pcssn"
                                                                              help:@"gta translates to point-code and optional ssn"
                                                                     caseSensitive:NO];
        [digits addSubtoken:pcssn];


        UMSyntaxToken_Pointcode *pointcode  = [[UMSyntaxToken_Pointcode  alloc]initWithString:@"zone-region-sp"
                                                                             help:@"SS7 Point Code"
                                                                    caseSensitive:NO];

        [pcssn addSubtoken:pointcode];

        [pointcode addSubtoken:asname_name_gt]; /* we reuse the same entry as under asname XXX */
        [pointcode addSubtoken:asname_name_pcssn]; /* we reuse the same entry as under asname XXX */


        /**********************************************/
        /* gta {digits} pcssn                         */
        /**********************************************/


        /* gta {digits} qos-class */
        UMSyntaxToken_Const *qos_class  = [[UMSyntaxToken_Const  alloc]initWithString:@"qos-class"
                                                                             help:@"Set QoS class for gta entry"
                                                                    caseSensitive:NO];
        [digits addSubtoken:qos_class];
    }
    return self;
}
@end
