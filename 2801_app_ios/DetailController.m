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
    self.cellIdentifiers = [NSArray arrayWithObjects:@"",
                            [NSArray arrayWithObjects:@"DetailCellFirstName",@"name", @"first" ,nil],
                            [NSArray arrayWithObjects:@"DetailCellLastName",@"name", @"last" ,nil],
                            [NSArray arrayWithObjects:@"DetailCellMail",@"", @"email" ,nil],
                            [NSArray arrayWithObjects:@"DetailCellPhone",@"", @"phone" ,nil],
                            [NSArray arrayWithObjects:@"DetailCellButton",@"", @"" ,nil]
                            ,nil];
    
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"DetailCell";
    
    
    int nbCellBase = [self tableView:table numberOfRowsInSection:0];
    UITableViewCell *cell = (UITableViewCell *)[table dequeueReusableCellWithIdentifier:kCellIdentifier];
 
        
        id identifiersDef =[self.cellIdentifiers objectAtIndex: indexPath.row];
        id identifiersDefValue =nil;
 
        if([ identifiersDef  respondsToSelector:@selector(objectAtIndex: )]){
       
            cell = (UITableViewCell *)[table dequeueReusableCellWithIdentifier: [identifiersDef objectAtIndex: 0]];
            if(cell == nil)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //cell.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
            
            
            if([identifiersDef objectAtIndex: 1] != nil)
                identifiersDefValue = [self.DetailRecords objectForKey: [identifiersDef objectAtIndex: 1]];

            ((UITextField*)[cell viewWithTag:10]).text = [identifiersDefValue  objectForKey: [identifiersDef objectAtIndex: 2] ];
                // NSLog(@" DetailRecords controller cell %@ :: %@", [cell viewWithTag:10] ,  [identifiersDefValue  objectForKey: [identifiersDef objectAtIndex: 2] ]);
        }else{
        }
        /*
         CGRect vieewRect = [[cell contentView] frame ]; // C++ 11 permet de le faire
         
         
         NSLog(@" cell.contentView %@", NSStringFromCGRect(vieewRect) );
         
         NSLog(@" DetailRecords controller %@", self );
         NSLog(@"DetailRecords : %@", self.DetailRecords);
         
         UIView *persona = [[UIView alloc] initWithFrame: vieewRect];
         persona.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:0.8];
         UIView *buttonView = [[UIView alloc]initWithFrame:vieewRect];
         
         UIButton *cancel =[[UIButton alloc]initWithFrame:
         CGRectMake(0, 0, 80, 30) ];
         [cancel setTitle:@"Retour" forState:UIControlStateNormal];
         
         UIButton *valider =[[UIButton alloc]initWithFrame:
         CGRectMake(90, 0, 80, 30) ];
         [valider setTitle:@"Valider" forState:UIControlStateNormal];
         
         [cancel setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.6 alpha:1.0]];
         [valider setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
         
         valider.layer.cornerRadius = 10.0;
         cancel.layer.cornerRadius = 10.0;
         
         [buttonView addSubview: cancel ];
         [buttonView addSubview: valider ];
         //[cell addSubview: buttonView];
         */
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    return @"Coordonnées";
}


- (IBAction)returnToChoices {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)validateChanges {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setDetails:(id)selectedDetails
{
    NSLog(@" DetailRecords controller %@", self );
    NSLog(@"setDetails :: %@",selectedDetails);
    DetailRecords = [NSDictionary dictionaryWithDictionary: selectedDetails];
}

/* ***************************** */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
