//
//  DetailController.h
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "objc_protocols/UIViewDetail_protocol.h"

@interface DetailController : UIViewController   <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIViewDetail_protocol>
@property (strong, nonatomic) id AppDelegate;
@property (nonatomic, strong) UITableViewController *DetailRecords_tableView;
@property (nonatomic, strong) NSMutableDictionary *DetailRecords;
@property (nonatomic, strong) NSDictionary *cellIdentifiers;

@property (nonatomic, assign) id<UIViewDetail_protocol> delegate;

@property (strong, nonatomic) IBOutlet UITableView *tabelView;

- (IBAction)returnToChoices ;
- (IBAction)validateChanges ;

- (IBAction)addDetail:(id)detailRef ;

@end

