//
//  FirstViewController.m
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import "DetailController.h"

 
@implementation DetailController
@synthesize DetailRecords_tableView;
@synthesize DetailRecords;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}


    // When the view appears, update the title and table contents.
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
        // [[self view] setBackgroundColor:[UIColor colorWithHue:0.2 saturation:0.6 brightness:0.4 alpha:0.8]];
    NSLog(@"subviews %@ :: %@",[[self view]class], [[self view]subviews]);
        //    self.view = [[UITableView alloc]init];
        //     self.view = [self.view viewWithTag:20];
    NSLog(@"damnviews %@",[self.view viewWithTag:20]);
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"DetailCell";
    UITableViewCell *cell = (UITableViewCell *)[table dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
        
        CGRect vieewRect = [[cell contentView] frame ]; // C++ 11 permet de le faire
        
        NSLog(@" cell.contentView %@", NSStringFromCGRect(vieewRect) );
        
        NSLog(@"DetailRecords : %@", DetailRecords);
        
        UIView *persona = [[UIView alloc] initWithFrame: vieewRect];
        persona.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:0.8];
        
            // cell.contentView = persona;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Song details:", @"Song details label");
}


- (IBAction)returnToChoices {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)validateChanges {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setDetails:(id)selectedDetails
{
    DetailRecords = selectedDetails;
}

/* ***************************** */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
