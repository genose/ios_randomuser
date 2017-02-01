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


#define URL_Database_distant_init @"https://randomuser.me/api/?results=50&format=xml"
#define URL_Database_local @"appstorage.xml"

#endif /* prefix_h */
