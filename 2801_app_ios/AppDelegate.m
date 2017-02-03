    //
    //  AppDelegate.m
    //  2801_app_ios
    //
    //  Created by xenon on 28/01/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //

#import "prefix.h"


#import "AppDelegate.h"
#import "objc_extentions/UIAlertController+UIAlert_extension.h"

void uncatched (void){
    NSLog(@"NSSetUncaughtExceptionHandler");

}
@implementation AppDelegate

@synthesize DatabaseRecordsDelegate;

-(id)AppDelegateDatabaseObjectAtIndex:(long)index
{
    return [DatabaseRecordsDelegate DatabaseObjectAtIndex: index];
    
}
-(long)AppDelegateCountRecord
{
    return [DatabaseRecordsDelegate countRecord];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    @try {
        [[UIApplication sharedApplication]setDelegate:self];
        NSSetUncaughtExceptionHandler(&uncatched);
            // charge la base de donnees
            // initialise le donnes par default
        DatabaseRecordsDelegate = [[DatabaseDelegate alloc]init];
            //
        [DatabaseRecordsDelegate setMasterTableIndex:@"results"];
        
        
        NSData* commitedXML = [  [DatabaseRecordsDelegate commitToXML] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *storePathBase = [NSString stringWithFormat:URL_Database_local_prefix];
        NSString *storePath = [NSString stringWithFormat:@"%@/%@",storePathBase,@"commitXML.xml"];
        [commitedXML writeToFile:storePath  atomically:YES];
        
        
    }
    @catch (NSException *exception) {
        
            // gestion global des exceptions
            // affiche une Alerte
        NSString *exMessage = [NSString stringWithFormat:@"********************* \n ******************\nError at Line %d :: %@:%@ :: FAIL to something in app  \n *************** \n%@\n****************", __LINE__, NSStringFromClass([self class]), NSStringFromSelector(_cmd),  exception];

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
      
        return NO;
    }
    @finally {
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

@end
