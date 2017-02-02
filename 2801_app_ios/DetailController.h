//
//  DetailController.h
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailController : UIViewController   <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableViewController *DetailRecords_tableView;
@property (nonatomic, strong) NSDictionary *DetailRecords;

- (IBAction)returnToChoices ;
- (IBAction)validateChanges ;
- (void) setDetails:(id)selectedDetails;
@end

