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

#pragma mark ******** Chargement
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _AppDelegate = [[UIApplication sharedApplication] delegate];
    [_AppDelegate DatabaseRecordsDelegate];
            // ***************************
            // creation de la vue Detail
            // ***************************
    _detailController = [[DetailController alloc] init];
    [self tableViewTitle];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ******** Titre View
-(void)tableViewTitle
{
        // count du nombre delements stokés
    [ self.listeTitle setTitle:[NSString stringWithFormat:@"Clients (%ld)",[_AppDelegate AppDelegateCountRecord]] ];
}
- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    return self.listeTitle.title;
}
#pragma mark ******** Gestion des tableviewcell
/**************************** */
/**************************** */
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
        // ***************************
        // extraction en base de donnees
        // ici demonstration par le delegate
        // un SINGLETON (static et global) aurait fait la meme chose
        // ***************************
    id DatabaseValue =[_AppDelegate AppDelegateDatabaseObjectAtIndex:indexPath.row] ;
        // assemblage text pour la cellule
    NSString *textValue = [NSString stringWithFormat:@"%@, %@" ,
                           //:: [[DatabaseValue objectForKey: @"name" ] objectForKey: @"title" ],
                           [[DatabaseValue objectForKey: @"name" ] objectForKey: @"first" ],
                           [[DatabaseValue objectForKey: @"name" ] objectForKey: @"last" ] ];
        // ***************************
        //decoration avec la photo du profil
        // simplement SANS CACHE Local .... Directement via HTTP
        // ***************************
    NSData *imageContent = [NSData dataWithContentsOfURL: [NSURL URLWithString:[[DatabaseValue objectForKey: @"picture" ] objectForKey: @"thumbnail" ] ] ];
        // :: cell.imageView.image = [UIImage imageWithData:imageContent ];
    
        // ***************************
        // remplissage des colonnes
        // Rajout d une information de comptage
        // ***************************
    cell.textLabel.text = textValue; //:: [NSString stringWithFormat:@"%ld : %@", 1 + (long) indexPath.row, textValue ];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    cell.backgroundColor = (indexPath.row%2 == 0) ? [UIColor colorWithWhite:1.0 alpha:0.1] : [UIColor colorWithWhite:1.0 alpha:0.8] ;
    
    
    return cell;
}


#pragma ###############¥# Delegate Swipe Handle
/**************************** */
/**************************** */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/**************************** */
/**************************** */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [_AppDelegate AppDelegateDatabaseDeleteObjectAtIndex:indexPath.row];
                // effacement dans le tabel view
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects: indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                /// rechargement des donnees
            [self tableViewTitle];
            [tableView reloadData];
            
        } else {
            NSLog(@"Unhandled editing style! %d", editingStyle);
        }
    }
    @catch (NSException *exception) {
        NSString *exMessage = [NSString stringWithFormat:@" ************ Error while deleting Row %d \n ********* %@ \n *********", indexPath.row, exception];
        NSLog(@"%@",exMessage);
            // :: [NSException raise:NSInvalidArgumentException format:@"%@", exMessage];
    }
    
}

#pragma ###############¥# Delegate selection Cell
/**************************** */
    // une fois la tablecell selectionne, on affiche le detail corresppondant avec la valeur de la base de donnees
/**************************** */
- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(table != nil && indexPath !=nil)
        self.selectedRow = (int) indexPath.row;
    else
        self.selectedRow = (-1);
        // presentation d une copy ???
        // donc Template d instance, genre C++
        // donc
    [self presentViewController: (DetailController*)self.detailController animated:YES completion:^{
        
        NSLog(@"Done Modal %@",[self presentedViewController]);
        
    } ];
    
}
#pragma mark ******** Ajout
- (void)addEntity:(id)sender
{
    self.selectedRow = (-1);
    return;
}
-(void)reloadData
{
    [self.tabelView reloadData];
    [self tableViewTitle];
}
#pragma ###############¥# Delegate Detail view prepare
/**************************** */
/**************************** */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(![segue.identifier isEqualToString:@"DetailView"]){ [self addEntity:sender]; }
    ((DetailController*)[segue destinationViewController]).delegate = self;
}

#pragma ###############¥# Delegate Detail view Args Handler
    // Protocol defined
-(id)getDetails
{
    
    return (self.selectedRow == (-1) )?[NSDictionary dictionary]: [_AppDelegate AppDelegateDatabaseObjectAtIndex:self.selectedRow];
}
@end
