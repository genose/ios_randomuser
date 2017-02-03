//
//  UIAlertController+UIAlert_extension.h
//  2801_app_ios
//
//  Created by xenon on 02/02/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (UIAlert_extension)

@end



@interface UIAlertController (Window)

- (void)show;
- (void)show:(BOOL)animated;

@end

@interface UIAlertController (Private)

@property (nonatomic, strong) UIWindow *alertWindow;

@end
