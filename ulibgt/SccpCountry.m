//
//  SccpCountry.m
//  ulibgt
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink (andreas@fink.org). All rights reserved.
//

#import "SccpCountry.h"

NSString * SccpCountryFromMSISDN(NSString *msisdn)
{
    return @(sccp_get_country_from_msisdn(msisdn.UTF8String));
}

const char *sccp_get_country_from_msisdn(const char *msisdn)
{
    if(msisdn==NULL)
    {
        return "";
    }
    if(*msisdn=='\0')
    {
        return "";
    }
    if(*msisdn=='+')
    {
        msisdn++;
        if(*msisdn=='\0')
        {
            return "";
        }
    }
    const char *country = "";
    switch(msisdn[0])
    {
        case '1':
        {
            /* 1 */
            country = "USA";
            switch(msisdn[1])
            {
                case '2':
                {
                    /* 12 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 120 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1201 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1202 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1203 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1204 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1205 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1206 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1207 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1208 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1209 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 121 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1210 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1212 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1213 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1214 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1215 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1216 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1217 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1218 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1219 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 122 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1220 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1223 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1224 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1225 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1226 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1228 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1229 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 123 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1231 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1234 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1236 */
                                    country = "CAN";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1239 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 124 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1240 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1242 */
                                    country = "BHS";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1246 */
                                    country = "BRB";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1248 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1249 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 125 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1250 */
                                    country = "CAN";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1251 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1252 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1253 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1254 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1256 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 126 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1260 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1262 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1264 */
                                    country = "AIA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1267 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1268 */
                                    country = "ATG";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 127 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1270 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1272 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1276 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1279 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 128 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1281 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1284 */
                                    country = "VGB";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1289 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    /* 13 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 130 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1301 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1304 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1305 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1306 */
                                    country = "CAN";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1307 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1308 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1309 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 131 */
                            switch(msisdn[3])
                            {
                                case '2':
                                {
                                    /* 1312 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1313 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1314 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1315 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1316 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1317 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1318 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1319 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 132 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1320 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1321 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1323 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1325 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 133 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1330 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1331 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1332 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1334 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1336 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1337 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1339 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 134 */
                            switch(msisdn[3])
                            {
                                case '3':
                                {
                                    /* 1343 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1345 */
                                    country = "CYM";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1346 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1347 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 135 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1351 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1352 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 136 */
                            switch(msisdn[3])
                            {
                                case '5':
                                {
                                    /* 1365 */
                                    country = "CAN";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1367 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 138 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1380 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1385 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1386 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    /* 14 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 140 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1401 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1402 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1403 */
                                    country = "CAN";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1404 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1405 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1406 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1407 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1408 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1409 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 141 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1410 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1412 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1413 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1414 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1415 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1416 */
                                    country = "CAN";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1417 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1418 */
                                    country = "CAN";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1419 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 142 */
                            switch(msisdn[3])
                            {
                                case '3':
                                {
                                    /* 1423 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1424 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1425 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1428 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 143 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1430 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1431 */
                                    country = "CAN";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1432 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1434 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1435 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1437 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1438 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 144 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1440 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1441 */
                                    country = "BMU";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1442 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1443 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1445 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 145 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1450 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1458 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 146 */
                            switch(msisdn[3])
                            {
                                case '3':
                                {
                                    /* 1463 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1469 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 147 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1470 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1475 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1478 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1479 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 148 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1480 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1484 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    /* 15 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 150 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1501 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1502 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1503 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1504 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1505 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1506 */
                                    country = "CAN";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1507 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1508 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1509 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 151 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1510 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1512 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1513 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1514 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1515 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1516 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1517 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1518 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1519 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 152 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1520 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 153 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1530 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1531 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1534 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1539 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 154 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1540 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1541 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1548 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 155 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1551 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1559 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 156 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1561 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1562 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1563 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1564 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1567 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 157 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1570 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1571 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1573 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1574 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1575 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1579 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 158 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1580 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1581 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1585 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1586 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1587 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    /* 16 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 160 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1601 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1602 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1603 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1604 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1605 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1606 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1607 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1608 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1609 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 161 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1610 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1612 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1613 */
                                    country = "CAN";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1614 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1615 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1616 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1617 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1618 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1619 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 162 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1620 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1623 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1626 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1628 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1629 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 163 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1630 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1631 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1636 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1639 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 164 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1641 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1646 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1647 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 165 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1650 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1651 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1657 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 166 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1660 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1661 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1662 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1667 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1669 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 167 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1671 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1672 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1678 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 168 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1680 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1681 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1682 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1684 */
                                    country = "ASM";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    /* 17 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 170 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1701 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1702 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1703 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1704 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1705 */
                                    country = "CAN";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1706 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1707 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1708 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1709 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 171 */
                            switch(msisdn[3])
                            {
                                case '2':
                                {
                                    /* 1712 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1713 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1714 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1715 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1716 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1717 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1718 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1719 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 172 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1720 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1724 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1725 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1726 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1727 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 173 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1731 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1732 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1734 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1737 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 174 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1740 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1743 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1747 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 175 */
                            switch(msisdn[3])
                            {
                                case '4':
                                {
                                    /* 1754 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1757 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 176 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1760 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1762 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1763 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1765 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1769 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 177 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1770 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1772 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1773 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1774 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1775 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1778 */
                                    country = "CAN";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1779 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 178 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1780 */
                                    country = "CAN";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1781 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1782 */
                                    country = "CAN";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1785 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1786 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    /* 18 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 180 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1801 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1802 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1803 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1804 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1805 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1806 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1807 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1808 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 181 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1810 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1812 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1813 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1814 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1815 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1816 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1817 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1818 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1819 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 182 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1820 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1825 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1828 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 183 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1830 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1831 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1832 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1838 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 184 */
                            switch(msisdn[3])
                            {
                                case '3':
                                {
                                    /* 1843 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1845 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1847 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1848 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 185 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1850 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1854 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1856 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1857 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1858 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1859 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            /* 186 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1860 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1862 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1863 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1864 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1865 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1867 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 187 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1870 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1872 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1873 */
                                    country = "CAN";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1878 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1879 */
                                    country = "CAN";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    /* 19 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 190 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1901 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1902 */
                                    country = "CAN";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1903 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1904 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1905 */
                                    country = "CAN";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1906 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1907 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1908 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1909 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            /* 191 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1910 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1912 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1913 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1914 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1915 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1916 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1917 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1918 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1919 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            /* 192 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1920 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1925 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1928 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1929 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            /* 193 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1930 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1931 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1934 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1936 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1937 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1938 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            /* 194 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1940 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1941 */
                                    country = "USA";
                                    break;
                                }
                                case '7':
                                {
                                    /* 1947 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1949 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            /* 195 */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 1951 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1952 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1954 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1956 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1959 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            /* 197 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1970 */
                                    country = "USA";
                                    break;
                                }
                                case '1':
                                {
                                    /* 1971 */
                                    country = "USA";
                                    break;
                                }
                                case '2':
                                {
                                    /* 1972 */
                                    country = "USA";
                                    break;
                                }
                                case '3':
                                {
                                    /* 1973 */
                                    country = "USA";
                                    break;
                                }
                                case '8':
                                {
                                    /* 1978 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1979 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            /* 198 */
                            switch(msisdn[3])
                            {
                                case '0':
                                {
                                    /* 1980 */
                                    country = "USA";
                                    break;
                                }
                                case '4':
                                {
                                    /* 1984 */
                                    country = "USA";
                                    break;
                                }
                                case '5':
                                {
                                    /* 1985 */
                                    country = "USA";
                                    break;
                                }
                                case '6':
                                {
                                    /* 1986 */
                                    country = "USA";
                                    break;
                                }
                                case '9':
                                {
                                    /* 1989 */
                                    country = "USA";
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '2':
        {
            /* 2 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 20 */
                    country = "EGY";
                    break;
                }
                case '1':
                {
                    /* 21 */
                    switch(msisdn[2])
                    {
                        case '1':
                        {
                            /* 211 */
                            country = "SSD";
                            break;
                        }
                        case '2':
                        {
                            /* 212 */
                            country = "MAR";
                            break;
                        }
                        case '3':
                        {
                            /* 213 */
                            country = "DZA";
                            break;
                        }
                        case '6':
                        {
                            /* 216 */
                            country = "TUN";
                            break;
                        }
                        case '8':
                        {
                            /* 218 */
                            country = "LBY";
                            break;
                        }
                    }
                    break;
                }
                case '2':
                {
                    /* 22 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 220 */
                            country = "GMB";
                            break;
                        }
                        case '1':
                        {
                            /* 221 */
                            country = "SEN";
                            break;
                        }
                        case '2':
                        {
                            /* 222 */
                            country = "MRT";
                            break;
                        }
                        case '3':
                        {
                            /* 223 */
                            country = "MLI";
                            break;
                        }
                        case '4':
                        {
                            /* 224 */
                            country = "GIN";
                            break;
                        }
                        case '5':
                        {
                            /* 225 */
                            country = "CIV";
                            break;
                        }
                        case '6':
                        {
                            /* 226 */
                            country = "BFA";
                            break;
                        }
                        case '7':
                        {
                            /* 227 */
                            country = "NER";
                            break;
                        }
                        case '8':
                        {
                            /* 228 */
                            country = "TGO";
                            break;
                        }
                        case '9':
                        {
                            /* 229 */
                            country = "BEN";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    /* 23 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 230 */
                            country = "MUS";
                            break;
                        }
                        case '1':
                        {
                            /* 231 */
                            country = "LBR";
                            break;
                        }
                        case '2':
                        {
                            /* 232 */
                            country = "SLE";
                            break;
                        }
                        case '3':
                        {
                            /* 233 */
                            country = "GHA";
                            break;
                        }
                        case '4':
                        {
                            /* 234 */
                            country = "NGA";
                            break;
                        }
                        case '5':
                        {
                            /* 235 */
                            country = "TCD";
                            break;
                        }
                        case '6':
                        {
                            /* 236 */
                            country = "CAF";
                            break;
                        }
                        case '7':
                        {
                            /* 237 */
                            country = "CMR";
                            break;
                        }
                        case '8':
                        {
                            /* 238 */
                            country = "CPV";
                            break;
                        }
                        case '9':
                        {
                            /* 239 */
                            country = "STP";
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    /* 24 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 240 */
                            country = "GNQ";
                            break;
                        }
                        case '1':
                        {
                            /* 241 */
                            country = "GAB";
                            break;
                        }
                        case '2':
                        {
                            /* 242 */
                            country = "COG";
                            break;
                        }
                        case '3':
                        {
                            /* 243 */
                            country = "COD";
                            break;
                        }
                        case '4':
                        {
                            /* 244 */
                            country = "AGO";
                            break;
                        }
                        case '5':
                        {
                            /* 245 */
                            country = "GNB";
                            break;
                        }
                        case '6':
                        {
                            /* 246 */
                            country = "IOT";
                            break;
                        }
                        case '8':
                        {
                            /* 248 */
                            country = "SYC";
                            break;
                        }
                        case '9':
                        {
                            /* 249 */
                            country = "SDN";
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    /* 25 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 250 */
                            country = "RWA";
                            break;
                        }
                        case '1':
                        {
                            /* 251 */
                            country = "ETH";
                            break;
                        }
                        case '2':
                        {
                            /* 252 */
                            country = "SOM";
                            break;
                        }
                        case '3':
                        {
                            /* 253 */
                            country = "DJI";
                            break;
                        }
                        case '4':
                        {
                            /* 254 */
                            country = "KEN";
                            break;
                        }
                        case '5':
                        {
                            /* 255 */
                            country = "TZA";
                            break;
                        }
                        case '6':
                        {
                            /* 256 */
                            country = "UGA";
                            break;
                        }
                        case '7':
                        {
                            /* 257 */
                            country = "BDI";
                            break;
                        }
                        case '8':
                        {
                            /* 258 */
                            country = "MOZ";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    /* 26 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 260 */
                            country = "ZMB";
                            break;
                        }
                        case '1':
                        {
                            /* 261 */
                            country = "MDG";
                            break;
                        }
                        case '2':
                        {
                            /* 262 */
                            country = "MYT";
                            break;
                        }
                        case '3':
                        {
                            /* 263 */
                            country = "ZWE";
                            break;
                        }
                        case '4':
                        {
                            /* 264 */
                            country = "NAM";
                            break;
                        }
                        case '5':
                        {
                            /* 265 */
                            country = "MWI";
                            break;
                        }
                        case '6':
                        {
                            /* 266 */
                            country = "LSO";
                            break;
                        }
                        case '7':
                        {
                            /* 267 */
                            country = "BWA";
                            break;
                        }
                        case '8':
                        {
                            /* 268 */
                            country = "SWZ";
                            break;
                        }
                        case '9':
                        {
                            /* 269 */
                            country = "COM";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    /* 27 */
                    country = "ZAF";
                    break;
                }
                case '9':
                {
                    /* 29 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 290 */
                            country = "SHN";
                            break;
                        }
                        case '1':
                        {
                            /* 291 */
                            country = "ERI";
                            break;
                        }
                        case '7':
                        {
                            /* 297 */
                            country = "ABW";
                            break;
                        }
                        case '8':
                        {
                            /* 298 */
                            country = "FRO";
                            break;
                        }
                        case '9':
                        {
                            /* 299 */
                            country = "GRL";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '3':
        {
            /* 3 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 30 */
                    country = "GRC";
                    break;
                }
                case '1':
                {
                    /* 31 */
                    country = "NLD";
                    break;
                }
                case '2':
                {
                    /* 32 */
                    country = "BEL";
                    break;
                }
                case '3':
                {
                    /* 33 */
                    country = "FRA";
                    break;
                }
                case '4':
                {
                    /* 34 */
                    country = "ESP";
                    break;
                }
                case '5':
                {
                    /* 35 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 350 */
                            country = "GIB";
                            break;
                        }
                        case '1':
                        {
                            /* 351 */
                            country = "PRT";
                            break;
                        }
                        case '2':
                        {
                            /* 352 */
                            country = "LUX";
                            break;
                        }
                        case '3':
                        {
                            /* 353 */
                            country = "IRL";
                            break;
                        }
                        case '4':
                        {
                            /* 354 */
                            country = "ISL";
                            break;
                        }
                        case '5':
                        {
                            /* 355 */
                            country = "ALB";
                            break;
                        }
                        case '6':
                        {
                            /* 356 */
                            country = "MLT";
                            break;
                        }
                        case '7':
                        {
                            /* 357 */
                            country = "CYP";
                            break;
                        }
                        case '8':
                        {
                            /* 358 */
                            country = "FIN";
                            break;
                        }
                        case '9':
                        {
                            /* 359 */
                            country = "BGR";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    /* 36 */
                    country = "HUN";
                    break;
                }
                case '7':
                {
                    /* 37 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 370 */
                            country = "LTU";
                            break;
                        }
                        case '1':
                        {
                            /* 371 */
                            country = "LVA";
                            break;
                        }
                        case '2':
                        {
                            /* 372 */
                            country = "EST";
                            break;
                        }
                        case '3':
                        {
                            /* 373 */
                            country = "MDA";
                            break;
                        }
                        case '4':
                        {
                            /* 374 */
                            country = "ARM";
                            break;
                        }
                        case '5':
                        {
                            /* 375 */
                            country = "BLR";
                            break;
                        }
                        case '6':
                        {
                            /* 376 */
                            country = "AND";
                            break;
                        }
                        case '7':
                        {
                            /* 377 */
                            country = "MCO";
                            break;
                        }
                        case '8':
                        {
                            /* 378 */
                            country = "SMR";
                            break;
                        }
                        case '9':
                        {
                            /* 379 */
                            country = "VAT";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    /* 38 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 380 */
                            country = "UKR";
                            break;
                        }
                        case '1':
                        {
                            /* 381 */
                            country = "SRB";
                            break;
                        }
                        case '2':
                        {
                            /* 382 */
                            country = "MNE";
                            break;
                        }
                        case '3':
                        {
                            /* 383 */
                            country = "XKX";
                            break;
                        }
                        case '5':
                        {
                            /* 385 */
                            country = "HRV";
                            break;
                        }
                        case '6':
                        {
                            /* 386 */
                            country = "SVN";
                            break;
                        }
                        case '7':
                        {
                            /* 387 */
                            country = "BIH";
                            break;
                        }
                        case '9':
                        {
                            /* 389 */
                            country = "MKD";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    /* 39 */
                    country = "ITA";
                    break;
                }
            }
            break;
        }
        case '4':
        {
            /* 4 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 40 */
                    country = "ROU";
                    break;
                }
                case '1':
                {
                    /* 41 */
                    country = "CHE";
                    break;
                }
                case '2':
                {
                    /* 42 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 420 */
                            country = "CZE";
                            break;
                        }
                        case '1':
                        {
                            /* 421 */
                            country = "SVK";
                            break;
                        }
                        case '3':
                        {
                            /* 423 */
                            country = "LIE";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    /* 43 */
                    country = "AUT";
                    break;
                }
                case '4':
                {
                    /* 44 */
                    country = "GBR";
                    switch(msisdn[2])
                    {
                        case '-':
                        {
                            /* 44- */
                            switch(msisdn[3])
                            {
                                case '1':
                                {
                                    /* 44-1 */
                                    switch(msisdn[4])
                                    {
                                        case '4':
                                        {
                                            /* 44-14 */
                                            switch(msisdn[5])
                                            {
                                                case '8':
                                                {
                                                    /* 44-148 */
                                                    switch(msisdn[6])
                                                    {
                                                        case '1':
                                                        {
                                                            /* 44-1481 */
                                                            country = "GGY";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '5':
                                        {
                                            /* 44-15 */
                                            switch(msisdn[5])
                                            {
                                                case '3':
                                                {
                                                    /* 44-153 */
                                                    switch(msisdn[6])
                                                    {
                                                        case '4':
                                                        {
                                                            /* 44-1534 */
                                                            country = "JEY";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '6':
                                        {
                                            /* 44-16 */
                                            switch(msisdn[5])
                                            {
                                                case '2':
                                                {
                                                    /* 44-162 */
                                                    switch(msisdn[6])
                                                    {
                                                        case '4':
                                                        {
                                                            /* 44-1624 */
                                                            country = "IMN";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                    }
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    /* 45 */
                    country = "DNK";
                    break;
                }
                case '6':
                {
                    /* 46 */
                    country = "SWE";
                    break;
                }
                case '7':
                {
                    /* 47 */
                    country = "NOR";
                    break;
                }
                case '8':
                {
                    /* 48 */
                    country = "POL";
                    break;
                }
                case '9':
                {
                    /* 49 */
                    country = "DEU";
                    break;
                }
            }
            break;
        }
        case '5':
        {
            /* 5 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 50 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 500 */
                            country = "FLK";
                            break;
                        }
                        case '1':
                        {
                            /* 501 */
                            country = "BLZ";
                            break;
                        }
                        case '2':
                        {
                            /* 502 */
                            country = "GTM";
                            break;
                        }
                        case '3':
                        {
                            /* 503 */
                            country = "SLV";
                            break;
                        }
                        case '4':
                        {
                            /* 504 */
                            country = "HND";
                            break;
                        }
                        case '5':
                        {
                            /* 505 */
                            country = "NIC";
                            break;
                        }
                        case '6':
                        {
                            /* 506 */
                            country = "CRI";
                            break;
                        }
                        case '7':
                        {
                            /* 507 */
                            country = "PAN";
                            break;
                        }
                        case '8':
                        {
                            /* 508 */
                            country = "SPM";
                            break;
                        }
                        case '9':
                        {
                            /* 509 */
                            country = "HTI";
                            break;
                        }
                    }
                    break;
                }
                case '1':
                {
                    /* 51 */
                    country = "PER";
                    break;
                }
                case '2':
                {
                    /* 52 */
                    country = "MEX";
                    break;
                }
                case '3':
                {
                    /* 53 */
                    country = "CUB";
                    break;
                }
                case '4':
                {
                    /* 54 */
                    country = "ARG";
                    break;
                }
                case '5':
                {
                    /* 55 */
                    country = "BRA";
                    break;
                }
                case '6':
                {
                    /* 56 */
                    country = "CHL";
                    break;
                }
                case '7':
                {
                    /* 57 */
                    country = "COL";
                    break;
                }
                case '8':
                {
                    /* 58 */
                    country = "VEN";
                    break;
                }
                case '9':
                {
                    /* 59 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 590 */
                            country = "BLM";
                            break;
                        }
                        case '1':
                        {
                            /* 591 */
                            country = "BOL";
                            break;
                        }
                        case '2':
                        {
                            /* 592 */
                            country = "GUY";
                            break;
                        }
                        case '3':
                        {
                            /* 593 */
                            country = "ECU";
                            break;
                        }
                        case '5':
                        {
                            /* 595 */
                            country = "PRY";
                            break;
                        }
                        case '7':
                        {
                            /* 597 */
                            country = "SUR";
                            break;
                        }
                        case '8':
                        {
                            /* 598 */
                            country = "URY";
                            break;
                        }
                        case '9':
                        {
                            /* 599 */
                            country = "ANT";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '6':
        {
            /* 6 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 60 */
                    country = "MYS";
                    break;
                }
                case '1':
                {
                    /* 61 */
                    country = "AUS";
                    break;
                }
                case '2':
                {
                    /* 62 */
                    country = "IDN";
                    break;
                }
                case '3':
                {
                    /* 63 */
                    country = "PHL";
                    break;
                }
                case '4':
                {
                    /* 64 */
                    country = "NZL";
                    break;
                }
                case '5':
                {
                    /* 65 */
                    country = "SGP";
                    break;
                }
                case '6':
                {
                    /* 66 */
                    country = "THA";
                    break;
                }
                case '7':
                {
                    /* 67 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 670 */
                            country = "TLS";
                            break;
                        }
                        case '2':
                        {
                            /* 672 */
                            country = "ATA";
                            break;
                        }
                        case '3':
                        {
                            /* 673 */
                            country = "BRN";
                            break;
                        }
                        case '4':
                        {
                            /* 674 */
                            country = "NRU";
                            break;
                        }
                        case '5':
                        {
                            /* 675 */
                            country = "PNG";
                            break;
                        }
                        case '6':
                        {
                            /* 676 */
                            country = "TON";
                            break;
                        }
                        case '7':
                        {
                            /* 677 */
                            country = "SLB";
                            break;
                        }
                        case '8':
                        {
                            /* 678 */
                            country = "VUT";
                            break;
                        }
                        case '9':
                        {
                            /* 679 */
                            country = "FJI";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    /* 68 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 680 */
                            country = "PLW";
                            break;
                        }
                        case '1':
                        {
                            /* 681 */
                            country = "WLF";
                            break;
                        }
                        case '2':
                        {
                            /* 682 */
                            country = "COK";
                            break;
                        }
                        case '3':
                        {
                            /* 683 */
                            country = "NIU";
                            break;
                        }
                        case '5':
                        {
                            /* 685 */
                            country = "WSM";
                            break;
                        }
                        case '6':
                        {
                            /* 686 */
                            country = "KIR";
                            break;
                        }
                        case '7':
                        {
                            /* 687 */
                            country = "NCL";
                            break;
                        }
                        case '8':
                        {
                            /* 688 */
                            country = "TUV";
                            break;
                        }
                        case '9':
                        {
                            /* 689 */
                            country = "PYF";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    /* 69 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 690 */
                            country = "TKL";
                            break;
                        }
                        case '1':
                        {
                            /* 691 */
                            country = "FSM";
                            break;
                        }
                        case '2':
                        {
                            /* 692 */
                            country = "MHL";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '7':
        {
            /* 7 */
            country = "KAZ";
            break;
        }
        case '8':
        {
            /* 8 */
            switch(msisdn[1])
            {
                case '1':
                {
                    /* 81 */
                    country = "JPN";
                    break;
                }
                case '2':
                {
                    /* 82 */
                    country = "KOR";
                    break;
                }
                case '4':
                {
                    /* 84 */
                    country = "VNM";
                    break;
                }
                case '5':
                {
                    /* 85 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 850 */
                            country = "PRK";
                            break;
                        }
                        case '2':
                        {
                            /* 852 */
                            country = "HKG";
                            break;
                        }
                        case '3':
                        {
                            /* 853 */
                            country = "MAC";
                            break;
                        }
                        case '5':
                        {
                            /* 855 */
                            country = "KHM";
                            break;
                        }
                        case '6':
                        {
                            /* 856 */
                            country = "LAO";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    /* 86 */
                    country = "CHN";
                    break;
                }
                case '8':
                {
                    /* 88 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 880 */
                            country = "BGD";
                            break;
                        }
                        case '6':
                        {
                            /* 886 */
                            country = "TWN";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '9':
        {
            /* 9 */
            switch(msisdn[1])
            {
                case '0':
                {
                    /* 90 */
                    country = "TUR";
                    break;
                }
                case '1':
                {
                    /* 91 */
                    country = "IND";
                    break;
                }
                case '2':
                {
                    /* 92 */
                    country = "PAK";
                    break;
                }
                case '3':
                {
                    /* 93 */
                    country = "AFG";
                    break;
                }
                case '4':
                {
                    /* 94 */
                    country = "LKA";
                    break;
                }
                case '5':
                {
                    /* 95 */
                    country = "MMR";
                    break;
                }
                case '6':
                {
                    /* 96 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 960 */
                            country = "MDV";
                            break;
                        }
                        case '1':
                        {
                            /* 961 */
                            country = "LBN";
                            break;
                        }
                        case '2':
                        {
                            /* 962 */
                            country = "JOR";
                            break;
                        }
                        case '3':
                        {
                            /* 963 */
                            country = "SYR";
                            break;
                        }
                        case '4':
                        {
                            /* 964 */
                            country = "IRQ";
                            break;
                        }
                        case '5':
                        {
                            /* 965 */
                            country = "KWT";
                            break;
                        }
                        case '6':
                        {
                            /* 966 */
                            country = "SAU";
                            break;
                        }
                        case '7':
                        {
                            /* 967 */
                            country = "YEM";
                            break;
                        }
                        case '8':
                        {
                            /* 968 */
                            country = "OMN";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    /* 97 */
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            /* 970 */
                            country = "PSE";
                            break;
                        }
                        case '1':
                        {
                            /* 971 */
                            country = "ARE";
                            break;
                        }
                        case '2':
                        {
                            /* 972 */
                            country = "ISR";
                            break;
                        }
                        case '3':
                        {
                            /* 973 */
                            country = "BHR";
                            break;
                        }
                        case '4':
                        {
                            /* 974 */
                            country = "QAT";
                            break;
                        }
                        case '5':
                        {
                            /* 975 */
                            country = "BTN";
                            break;
                        }
                        case '6':
                        {
                            /* 976 */
                            country = "MNG";
                            break;
                        }
                        case '7':
                        {
                            /* 977 */
                            country = "NPL";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    /* 98 */
                    country = "IRN";
                    break;
                }
                case '9':
                {
                    /* 99 */
                    switch(msisdn[2])
                    {
                        case '2':
                        {
                            /* 992 */
                            country = "TJK";
                            break;
                        }
                        case '3':
                        {
                            /* 993 */
                            country = "TKM";
                            break;
                        }
                        case '4':
                        {
                            /* 994 */
                            country = "AZE";
                            break;
                        }
                        case '5':
                        {
                            /* 995 */
                            country = "GEO";
                            break;
                        }
                        case '6':
                        {
                            /* 996 */
                            country = "KGZ";
                            break;
                        }
                        case '8':
                        {
                            /* 998 */
                            country = "UZB";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    return country;
}
