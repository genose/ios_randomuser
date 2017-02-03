    //
    //  main.m
    //  2801_app_ios
    //
    //  Created by xenon on 28/01/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "objc_extentions/UIAlertController+UIAlert_extension.h"

int main(int argc, char * argv[]) {
    
    @try{
        @autoreleasepool {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    @catch (NSException *exception) {
        
            // gestion global des exceptions
            // affiche une Alerte
        NSString *exMessage = [NSString stringWithFormat:@"********************* MAin APP Error \n ******************\nError at Line %d  :: FAIL to something in app  \n *************** \n%@\n****************", __LINE__,    exception];
        
        NSLog(@"%@",exMessage);
        
        
        UIAlertController *exAlert =
        [UIAlertController alertControllerWithTitle:@"Sorry"
                                            message:exMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Oups !!" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  
                                                                      //home button press programmatically
                                                                  UIApplication *app = [UIApplication sharedApplication];
                                                                  [app performSelector:@selector(suspend)];
                                                                  
                                                                      //wait 2 seconds while app is going background
                                                                  [NSThread sleepForTimeInterval:2.0];
                                                                  
                                                                      //exit app when app is in background
                                                                  exit(0);
                                                              }];
        
        [exAlert addAction:defaultAction];
        
        [exAlert show];
        
    }
    @finally {
        
    }
}
