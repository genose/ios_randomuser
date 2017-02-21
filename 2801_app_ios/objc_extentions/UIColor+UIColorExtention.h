//
//  UIColor+UIColorExtention.h
//  2801_app_ios
//
//  Created by xenon on 20/02/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorExtention)
+ (UIColor *) colorWithHexString: (NSString *) hexString ;
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
@end
