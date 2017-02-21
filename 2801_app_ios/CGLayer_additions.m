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
#import "prefixUIDesign.h"
@implementation CALayer (Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

- (void)setRoundedViewWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
    self.borderWidth = 2;
    self.cornerRadius = CGRectGetHeight([self frame]) / 2;
}

- (void)setRoundedButtonWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
    self.borderWidth = 2;
    self.cornerRadius = CGRectGetHeight([self frame]) / 2;
}
-(void)setButtonWithSubtitle
{

}
-(void)setStandardBackgroundColor
{
    self.backgroundColor = [UIColor colorWithHexString:@"007AFF"];
}
@end