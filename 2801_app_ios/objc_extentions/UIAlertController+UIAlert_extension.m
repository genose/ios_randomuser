    //
    //  UIAlertController+UIAlert_extension.m
    //  2801_app_ios
    //
    //  Created by xenon on 02/02/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //
#import <objc/runtime.h>
#import "UIAlertController+UIAlert_extension.h"

@implementation UIAlertController (UIAlert_extension)

@end



@implementation UIAlertController (Private)

@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow {
    objc_setAssociatedObject(self, @selector(alertWindow), alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

@end

@implementation UIAlertController (Window)

- (void)show {
    [self show:YES];
}

- (void)show:(BOOL)animated {
    @try {
        
        self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.alertWindow.rootViewController = [[UIViewController alloc] init];
        
        id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
            // Applications that does not load with UIMainStoryboardFile might not have a window property:
        if ([delegate respondsToSelector:@selector(window)]) {
                // we inherit the main window's tintColor
            self.alertWindow.tintColor = delegate.window.tintColor;
        }
        
            // window level is above the top window (this makes the alert, if it's a sheet, show over the keyboard)
        UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
        self.alertWindow.windowLevel = topWindow.windowLevel + 1;
        
        [self.alertWindow makeKeyAndVisible];
        if( nil != self.alertWindow.rootViewController
           && [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
                // try to Present Error in a Window
            NSLog(@"Trying to show Error informations ");
            [self.alertWindow.rootViewController presentViewController:self animated:animated completion:nil];
        }else{
            NSLog(@" ****** ERROR : Can t present Error Window ");
        }
    }
    @catch (NSException *exception) {
        NSLog(@" ****** ERROR : Some Error Can t be presented in Error Window \n **************** %@ \n ***********", exception);
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
        // precaution to insure window gets destroyed
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}

@end