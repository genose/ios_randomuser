//
//  NSObject+NSObject_isKindOf.m
//  2801_app_ios
//
//  Created by xenon on 22/02/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import "NSObject+NSObject_isKindOf.h"

@implementation NSObject (NSObject_isKindOf)
-(BOOL)isKindOfString:(Class)aClass{
    return [aClass respondsToSelector:@selector(length)] && [aClass respondsToSelector:@selector(characterAtIndex:)]  ;
}
-(BOOL)isKindOfDictionnary:(Class)aClass{
    return [aClass respondsToSelector:@selector(objectForKey:)] && [aClass isKindOfClass:[NSDictionary class]]  ;
}
-(BOOL)isKindOfArray:(Class)aClass{
    return [aClass respondsToSelector:@selector(objectAtIndex:)] && [aClass isKindOfClass:[NSArray class]]  ;
}

@end
