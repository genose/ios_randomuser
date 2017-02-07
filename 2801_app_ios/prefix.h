//
//  prefix.h
//  2801_app_ios
//
//  Created by xenon on 29/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import "XMLDictionary.h"

#import "objc_extentions/NSData_NSDataExtentions.h"
#import "objc_extentions/NSArray_NSDictionnary_extention.h"

#ifndef prefix_h
#define prefix_h

    // choix lors de la compilation du DataSource et de son mecanisme
#define __USE_BDD_HTTP_XML__ true


#define URL_Database_distant_init @"https://randomuser.me/api/?results=5&format=xml"

  // :: #define URL_Database_local_prefix @"/Volumes/ramfstmp"

    // ::
#define URL_Database_local_prefix [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @""]

#define URL_Database_local @"appstorage.xml"

    // number formatting
#define REGEX_FOR_NUMBERS   @"^([+-]?)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
#define REGEX_FOR_INTEGERS  @"^([+-]?)(?:|0|[1-9]\\d*)?$"
#define IS_A_NUMBER(string) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_NUMBERS] evaluateWithObject:string]
#define IS_AN_INTEGER(string) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_INTEGERS] evaluateWithObject:string]


#endif /* prefix_h */
