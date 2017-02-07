    //
    //  FirstViewController.m
    //  2801_app_ios
    //
    //  Created by xenon on 28/01/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //

#import "DetailController.h"
#import "SecondViewController.h"

#import "prefix.h"

@implementation DetailController

@synthesize DetailRecords_tableView;
@synthesize DetailRecords;
@synthesize tabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Do any additional setup after loading the view, typically from a nib.
}


    // When the view appears, update the title and table contents.
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
        // control la generation des TableViewCell prototypes et leurs valuers en Database
    self.cellIdentifiers = [NSArray arrayWithObjects:
                            [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellLastName",@"name", @"last" ,nil],@"DetailCellLastName" ,nil],
                            [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellFirstName",@"name", @"first" ,nil],@"DetailCellFirstName" ,nil],
                            
                             [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellPhone",@"-", @"phone" ,nil],@"DetailCellPhone" ,nil],
                            [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailSection",@"-", @"-" ,nil],@"DetailSection" ,nil],
                            
                            [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellMail",@"-", @"email" ,nil],@"DetailCellMail" ,nil],
                            
                             [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailSection",@"-", @"-" ,nil],@"DetailSection" ,nil],
                           @"ignore",@"noproperty",
                            @"ignore",@"noproperty",
                            [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellButton",@"-", @"-", [NSArray arrayWithObjects:@"add",@"delete", nil] ,nil], @"DetailCellButton" ,nil]
                            ,nil];
    self.DetailRecords = [NSMutableDictionary dictionary];
    _AppDelegate = [[UIApplication sharedApplication] delegate];
        // mutable COPY
    self.DetailRecords = [NSMutableDictionary dictionaryWithDictionary: [self.delegate getDetails]];
    
 
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 21; // :: pour charger plus de ligne que prevu par le storyboard
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"DetailCell";
    
    
    int nbCellBase = [self tableView:table numberOfRowsInSection:0];
    UITableViewCell *cell = nil;
    id allkeysFound = [self.cellIdentifiers allKeysInner];
    
    id identifiersDef = (indexPath.row < [allkeysFound count]) ? [self.cellIdentifiers objectForKey :
                                                                                 [ allkeysFound objectAtIndex: indexPath.row] ] :  @"" ;
    id identifiersDefValue =nil;
    
    if([ identifiersDef  respondsToSelector:@selector(objectAtIndex: )]  ){
        
        cell = (UITableViewCell *)[table dequeueReusableCellWithIdentifier: [identifiersDef objectAtIndex: 0]];
        if(cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
        
        if([identifiersDef objectAtIndex: 1] != nil && [[identifiersDef objectAtIndex: 1] length]>2)
            identifiersDefValue = [self.DetailRecords objectForKey: [identifiersDef objectAtIndex: 1]];
        else if ([identifiersDef objectAtIndex: 1] != nil && [[identifiersDef objectAtIndex: 1] length]<=2)
            identifiersDefValue = self.DetailRecords ;
        /* *********************************** */
            // Recherche de la valeur texte
        id textValue = [identifiersDefValue  objectForKey: [identifiersDef objectAtIndex: 2] ];
        if( [ textValue   isKindOfClass:[NSDictionary class]]){
                // Recheche de la premiere occurence
            [textValue objectForKey:[[textValue allKeys] objectAtIndex:0]];
        }
            // assignation de la valeur text trouve
        ((UITextField*)[cell viewWithTag:10]).text = textValue;
            // :: nope :: [((UITextField*)[cell viewWithTag:10]) setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        /* *********************************** */
            // reste a faire l ajout de telephone et de email supplmentaire
            // make acessory view
        /* UIView *accessoryButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        accessoryButtonView.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.8]; */
        /*            if([identifiersDef count]>3)
         cell.accessoryView = accessoryButtonView;*/
        
    }else if(identifiersDef != nil && [ identifiersDef length]>1){
            // ::     UITableViewCell *cell = (UITableViewCell *)[table dequeueReusableCellWithIdentifier:kCellIdentifier];
            // TODO :: Custom cell, add, mail, phone
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:1.0 alpha:0.8];
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:0.8];
    }
    /* ****************************
     
     Creer un Bouton arrondi en programmation
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


#pragma ###############¥# Delegate Swipe Handle
/**************************** */
/**************************** */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    return ([[self.DetailRecords allKeys]count]>0)? @"Coordonnées": @"Ajouter";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        // TODO : suppression par Swippe
}


/* ******************************* */
    // **** Escape pas de modifications
/* ******************************* */
- (IBAction)returnToChoices {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ******** Enristrement des Modifications
/* ******************************* */
    // **** Sauvegarde des modifications
/* ******************************* */
- (IBAction)validateChanges {
    @try
    {
    NSMutableDictionary *validatedChanges = self.DetailRecords;
    
        /*  **********
         **********
         la Structure ressemble a cela en programmation 
         ******************
         [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"--",@"title", nil], @"name",
                                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"none",@"thumbnail", nil], @"picture",
                                             
                                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"none",@"domicile", nil], @"email",
                                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"none",@"domicile", nil], @"phone"
                                             , nil];
         **********************
         ************************ */
    
    id DetailContactView = nil;
    id DetailContactViewCells = nil;
    
    for (id sub in [[self view]subviews]) {
        if([sub  isKindOfClass:[UITableView class]]){
            DetailContactView = sub;
            break;
        }
    }
    /* ********************** */
    if(DetailContactView) {
        
        
        /* ******************************** */
            // Structure Descriptor
        /* ******************************** */
        DetailContactViewCells = [[NSArray arrayWithObjects:[DetailContactView visibleCells],nil] objectAtIndex:0];
        for (id sub in DetailContactViewCells ) {
            if([sub  isKindOfClass:[UITableViewCell class]] &&  [sub viewWithTag:10] ){
                
                id identifiersDef =[self.cellIdentifiers objectForKey: ((UITableViewCell*)sub).reuseIdentifier  ];
                
                if(identifiersDef != nil){
                    id subKeyMaster = [identifiersDef objectAtIndex: 1];
                    id subKey = [identifiersDef objectAtIndex: 2];
                    id storedValue = ((UITextView*)[sub viewWithTag:10]).text;
                    if([ subKeyMaster isKindOfClass:[NSString class]] && [subKeyMaster length]>2) {
                            // deux niveaux .... encapsulation des donnees
                        if([validatedChanges objectForKey:subKeyMaster]){
                                // get mutable copy
                            NSMutableDictionary *existingStoredValue = [NSMutableDictionary dictionaryWithDictionary:[validatedChanges objectForKey:subKeyMaster]];
                            [existingStoredValue setObject: [storedValue copy] forKey: [NSString stringWithFormat:@"%@",subKey]];
                            storedValue =existingStoredValue;
                        }else{
                            storedValue = [NSDictionary dictionaryWithObjectsAndKeys: storedValue, subKey, nil];
                        }
                    }else{
                            // format plat
                        subKeyMaster = subKey;
                    }
                        // :: NSLog(@" Got walkin .... %@ ::  %@ :: %@ :: %@",((UITableViewCell*)sub).reuseIdentifier,  ((UITextView*)[sub viewWithTag:10]).text, subKey, subKeyMaster );
                    if (subKeyMaster != nil){
                        [ validatedChanges setValue: [storedValue copy] forKey: [NSString stringWithFormat:@"%@",subKeyMaster]];
                    }
                    
                    
                }
                
            }
            
        }
        
    }
        // appel du appdelegate pour stockage des modifications
    id viewDelegate = self.delegate;
    long index =  ((SecondViewController*)viewDelegate).selectedRow;
    /* ********
        if( [validatedChanges somethingdifferent:  self.DetailRecords] ){
        [_AppDelegate AppDelegateDatabaseCommitObjectAtIndex:index  :validatedChanges];
    }else if(index <0){
            // :: Alert
    } 
     ******** */
    [_AppDelegate AppDelegateDatabaseCommitObjectAtIndex:index  :validatedChanges];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"*******  Saved ...");
        [viewDelegate reloadData];
    }];
    
    }
    @catch (NSException *exception) {
        NSString *exMessage = [NSString stringWithFormat:@" ************ Error while commit changes \n ********* %@ \n *********", exception];
        NSLog(@"%@",exMessage);
            // ::
        [NSException raise:NSInvalidArgumentException format:@"%@", exMessage];
    }
}
#pragma mark ******** Micelleanous
/* ***************************** */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
@end

