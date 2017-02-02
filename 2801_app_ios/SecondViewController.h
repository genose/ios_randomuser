 //
//  SecondViewController.h
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIViewController *detailController;
@property (strong, nonatomic) id AppDelegate;
@property (strong, nonatomic) IBOutlet UINavigationItem *listeTitle;

@end

