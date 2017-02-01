//
//  SecondViewController.m
//  2801_app_ios
//
//  Created by xenon on 28/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailController.h"
#import "AppDelegate.h"


@implementation SecondViewController
    // @synthesize detailController;
// @synthesize id _AppDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _AppDelegate = [[UIApplication sharedApplication] delegate];
    [_AppDelegate DatabaseRecordsDelegate];
    
    _detailController = [[DetailController alloc] init];
    
   /* UIBarButtonItem *doneItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(returnToChoices)];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_AppDelegate AppDelegateCountRecord];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
        // extraction en base de donnees
        // ici demonstration par le delegate
        // un SINGLETON (static et global) aurait fait la meme chose
    id DatabaseValue =[_AppDelegate AppDelegateDatabaseObjectAtIndex:indexPath.row] ;
        // assemblage text pour la cellule
    NSString *textValue = [NSString stringWithFormat:@"%@ %@, %@" ,
                            [[DatabaseValue objectForKey: @"name" ] objectForKey: @"title" ],
                            [[DatabaseValue objectForKey: @"name" ] objectForKey: @"first" ],
                            [[DatabaseValue objectForKey: @"name" ] objectForKey: @"last" ] ];
    
        //decoration avec la photo du profil
    NSData *imageContent = [NSData dataWithContentsOfURL: [NSURL URLWithString:[[DatabaseValue objectForKey: @"picture" ] objectForKey: @"thumbnail" ] ] ];
    
    NSLog(@"Image %ld :: %@ ;; %ld ", indexPath.row, [[DatabaseValue objectForKey: @"picture" ] objectForKey: @"thumbnail" ],[ imageContent length] );
        // remplissage des colonnes
        // Rajout d une information de comptage
    cell.textLabel.text = [NSString stringWithFormat:@"%ld : %@", 1 + (long) indexPath.row, textValue ];
    cell.imageView.image = [UIImage imageWithData:imageContent ];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
  
    cell.backgroundColor = (indexPath.row%2 == 0) ? [UIColor colorWithWhite:0.7 alpha:0.1] : [UIColor colorWithWhite:0.7 alpha:0.8] ;
    
    
    return cell;
}
- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        // self.detailController = (self.songs)[indexPath.row];
    NSLog(@"Tableview selection ... %ld",indexPath.row);
    [self.navigationController pushViewController:self.detailController animated:YES];
    
}
 

- (IBAction)returnToChoices {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
