//
//  NSObject+NSObject_isKindOf.h
//  2801_app_ios
//
//  Created by xenon on 22/02/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_isKindOf)
-(BOOL)isKindOfString:(Class)aClass;
-(BOOL)isKindOfDictionnary:(Class)aClass;
-(BOOL)isKindOfArray:(Class)aClass;
@end
