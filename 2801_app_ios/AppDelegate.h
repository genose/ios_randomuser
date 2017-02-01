//
//  AppDelegate.h
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classes/DatabaseDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DatabaseDelegate *DatabaseRecordsDelegate ;

-(id)AppDelegateDatabaseObjectAtIndex:(long)index;
-(long)AppDelegateCountRecord;
@end

