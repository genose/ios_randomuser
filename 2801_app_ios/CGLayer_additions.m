//
//  CGLayer_additions.m
//  2801_app_ios
//
//  Created by xenon on 07/02/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>
#import "prefix.h"
@implementation CALayer (Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end