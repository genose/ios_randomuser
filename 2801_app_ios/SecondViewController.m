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

@synthesize selectedRow;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _AppDelegate = [[UIApplication sharedApplication] delegate];
    [_AppDelegate DatabaseRecordsDelegate];
    
        // demonstration d'une sorte de ptoxy
        // count du nombre delements stokés
    [ self.listeTitle setTitle:[NSString stringWithFormat:@"Clients (%ld)",[_AppDelegate AppDelegateCountRecord]] ];
        // creation de la vue Detail
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
/**************************** */
/**************************** */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DetailCell";
    
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
    
        // remplissage des colonnes
        // Rajout d une information de comptage
    cell.textLabel.text = [NSString stringWithFormat:@"%ld : %@", 1 + (long) indexPath.row, textValue ];
    cell.imageView.image = [UIImage imageWithData:imageContent ];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    cell.backgroundColor = (indexPath.row%2 == 0) ? [UIColor colorWithWhite:0.1 alpha:0.1] : [UIColor colorWithWhite:1.0 alpha:0.8] ;
    
    
    return cell;
}

/**************************** */
    // une fois la tablecell selectionne, on affiche le detail corresppondant avec la valeur de la base de donnees
/**************************** */
- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
      
    self.selectedRow = (int) indexPath.row;
        // copy ???
    [self presentViewController: (DetailController*)self.detailController animated:YES completion:^{
        
        NSLog(@"Done Modal %@",[self presentedViewController]);
        
    } ];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    id DatabaseValue =[_AppDelegate AppDelegateDatabaseObjectAtIndex:self.selectedRow] ;
    [((DetailController*)segue.destinationViewController) setDetails:  DatabaseValue];
    
}
@end
