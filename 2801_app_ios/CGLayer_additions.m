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
#import "UIColor+UIColorExtention.h"


@implementation CALayer (Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

- (void)setRoundedViewWithUIColor:(id)info
{

    if(([info respondsToSelector:@selector(length)] && [info respondsToSelector:@selector(characterAtIndex:)]  )){
        if([NSJSONSerialization isValidJSONObject:info]){

            info =         [NSJSONSerialization JSONDictionnaryFromString:info];
            [self setValuesForKeysWithDictionary:info];
        }else{
            [NSException raise:NSInvalidArgumentException format:@" Error :: Not a Valid JSON expr %@ \n:: Class : %@:%@ :: self : %@ ", info, NSStringFromClass([self class]), NSStringFromSelector(_cmd), self];
        }
    }else {
        [NSException raise:NSInvalidArgumentException format:@" Error :: Class : %@:%@ :: self : %@ ",NSStringFromClass([self class]),NSStringFromSelector(_cmd), self];
    }
        //     self.borderColor = color.CGColor;
        //    self.borderWidth = 2;
        //    self.cornerRadius = CGRectGetHeight([self frame]) / 2;
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
    self.backgroundColor = (((UIColor*)[UIColor colorWithHexString:@"007AFF"]).CGColor);
}
@end