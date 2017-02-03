    //
    //  DatabaseDelegate.m
    //  2801_app_ios
    //
    //  Created by Cotillard on 30/01/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //
    // An abstract substitution NSdictionnary/NSArray Dabatase Driver

#import <Foundation/Foundation.h>
#import "prefix.h"
#import "DatabaseDelegate.h"

@implementation DatabaseDelegate

@synthesize DatabaseRecords;
@synthesize DatabaseRecordsTable;
@synthesize allKeysIndex;
NSArray *workingTable =nil;

#pragma mark -------------------
#pragma mark ---- INIT des elements de la base de donnees
#pragma mark -------------------

-(id) init
{
    
    self = [super init];
    if(self != nil){
        
        @try
            // also referenced NS_DURING
        {
        allKeysIndex = [NSArray array];
        
            // construct path within our documents directory
        NSString *applicationDocumentsDir =
        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        /* ********************* */
        
        NSString *storePathBase = [NSString stringWithFormat:URL_Database_local_prefix];
            // COCOA :: kek choz comme :: stringbyappendingcompenent
        NSString *storePath = [NSString stringWithFormat:@"%@/%@",storePathBase,@"commitXML.xml"];
            // :: utiliser les valeurs dans Prefix.h
        
        /* ********************* */
        
        NSMutableString *databaseContent = [[NSMutableString alloc] initWithString:@"Some XML should later There"] ;
        
#if defined( __USE_BDD_HTTP_XML__) && __USE_BDD_HTTP_XML__
        
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:storePath  error:nil];
        
        NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        long long fileSize = [fileSizeNumber longLongValue];
        
            // test la presence du fichier Database local
            // effectuer l'initialisation du fichier database Vide lors de la premiere utilisation
        if( ![[NSFileManager defaultManager] fileExistsAtPath:storePathBase]){
            [NSException raise:NSInvalidArgumentException format:@"%@ Dossier introuvable for accessing Database to : %@",[self class],storePath];
        }
        if( ![[NSFileManager defaultManager] fileExistsAtPath:storePath] || fileSize < 100 )  {
            NSLog(@" Fetching Default DATABASE (%lld):: %@", fileSize, URL_Database_distant_init);
            NSURL *URL_init = [[NSURL alloc] initWithString: URL_Database_distant_init] ;
            NSData *data = [NSData dataWithContentsOfURL:URL_init];  // Load XML data from web
            
                // :: NSLog(@" dataFound :: %@",URL_init);
                // should implement better Nsdata encoding detector ...
            [databaseContent setString:[NSString stringWithCString:[data bytes] encoding:[data EncodingType] ]];
                // :: NSLog(@" dataString :: %@",databaseXMLStringContent);
                // write to file atomically (using temp file)
            if([data writeToFile:storePath atomically:TRUE]) {
                NSLog(@"Saved Database to %@ ", storePath);
            }else{
                [NSException raise:NSInvalidArgumentException format:@"%@ can not Save Basic Database to : %@",[self class],storePath];
            }
            
        }else{
            NSLog(@"Load Previously Saved Database from %@ ", storePath);
            NSString *databaseFetchedContent = [[NSString alloc] initWithContentsOfFile:storePath encoding:NSUTF8StringEncoding error:NULL];
            
            if(databaseFetchedContent == nil || ![databaseFetchedContent length]){
                [NSException raise:NSInvalidArgumentException format:@"%@ can not open or read :%@",[self class],URL_Database_local];
            }else{
                [databaseContent setString:databaseFetchedContent];
            }
        }
#else
#error  "No other DATA source was Implemented"
#endif
        if(databaseContent ==nil || ![databaseContent length] ){
            
            NSLog(@"Raising exception caus XML is nil : %@", databaseContent);
            [NSException raise:NSInvalidArgumentException format:@"%@ can not open or read :%@",[self class],storePath];
        }
        
            // NSLog(@"string: %@", databaseXMLStringContent);
        DatabaseRecords = (NSMutableDictionary*) [NSMutableDictionary dictionaryWithXMLString:databaseContent];
        workingTable = [NSArray arrayWithObject: DatabaseRecords];
        
        return self;
        }
        @catch (NSException *exceptionApp) {
            NSLog(@"## FATAL ERROR ## Datasource FATAL NSEXCEPTION");
            NSLog(@" * * * Local Exception Catched  * * * %@",exceptionApp);
            [NSException raise:NSInvalidArgumentException format:@"%@", exceptionApp];
            return nil;
        }
        @finally {
            NSLog(@" Initialisation complete");
        }
        
    }
    
    return nil;
}

#pragma mark -------------------
#pragma mark ---- Choix de la table ou element maitre de la base de donnees
#pragma mark -------------------

-(void)setMasterTableIndex: (NSString*)tableName
{
    if(DatabaseRecordsTable == nil) DatabaseRecordsTable = [NSMutableString stringWithString:@"--"];
    
    [DatabaseRecordsTable setString:[NSString stringWithString: tableName]];
    workingTable =  [DatabaseRecords objectForKey:DatabaseRecordsTable];
    allKeysIndex = [workingTable allKeys];
}

#pragma mark -------------------
#pragma mark ---- Acces aux elements de la base de donnees
#pragma mark -------------------

/* ********************************* */
/* ********* Recherche un element dans la Database par son index******** */
/* ********************************* */
-(id)DatabaseObjectAtIndex:(long)index
{
    NSArray *fetchedRecord =  [workingTable objectAtIndex:[[allKeysIndex objectAtIndex: index] longValue]];
        //  NSLog(@"fetchedRecord ... %ld :: %@",index, fetchedRecord);
    return fetchedRecord;
}

-(NSString*)DatabaseObjectAtIndex:(long)index column:(NSString*)IndexColumnKey
{
    return (NSString*) [(NSDictionary*)[self DatabaseObjectAtIndex:index] objectForKey:IndexColumnKey];
}

#pragma mark -------------------
#pragma mark ---- Accesseur Tranversal, Mutable, Countable aux elements
#pragma mark -------------------

    // peu etre faire une Categowwyyy Obj-c pour l implementation de : Traversable, Countable, Nsdictionnary Mutable
-(long)countRecord // count elements
{
    return [workingTable count];
}
@end
@implementation DatabaseDelegate (XMLBackend)
-(NSString*)commitToXML
{
    return [self ConvertDictionarytoXML: DatabaseRecords];
}
-(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary
{
    NSMutableString *xmlDocContent =[NSMutableString stringWithString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
        // i should not use FastEnmueration or block enumeration for this exemple
    NSEnumerator *nodeEnumrator = [dictionary objectEnumerator];
    NSEnumerator *keyEnumrator = [dictionary keyEnumerator];
        // Node actuel, elmeent en cours
    id nodeElement=nil;
    NSString* nodeElementKey=nil;
    @try {
        while( (nodeElement= [nodeEnumrator nextObject])){
            nodeElementKey= [NSString stringWithFormat:@"%@",[keyEnumrator nextObject] ];
            
            
            if(nodeElement!=nil
               && [nodeElementKey length]>2
               && [nodeElementKey isKindOfClass:[NSString class]]
               && ![[NSString stringWithFormat:@"%@",[nodeElementKey substringToIndex:2]] isEqualToString:@"__"]
               ){
                    //                NSLog(@"***************** dictionary %@ :: %@ ", nodeElementKey, nodeElement);
                    //     [xmlDocContent appendString:   [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey] ];
                    //
                [xmlDocContent appendString:  [NSString stringWithFormat:@"\n\t<%@>%@\n</%@>", nodeElementKey,   [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey], nodeElementKey] ] ;
            }
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"********************* \n ******************\nError at Line %d :: %@:%@ :: FAIL to Enumerate :: %@ :: %@ \n *************** \n%@\n****************", __LINE__, NSStringFromClass([self class]), NSStringFromSelector(_cmd), nodeElementKey, nodeElement, exception);
    }
    @finally {
        
    }
    
    return     xmlDocContent;
}
-(NSString*)ConvertDictionarytoXML_nodeElement:(NSDictionary*)dictionary nodeName:(NSString*)startElementName
{
    
    NSMutableString *xmlParentNodeContent =[NSMutableString stringWithString:@""];
        //   if([startElementName length])  [xmlParentNodeContent appendString:[NSString stringWithFormat:@"\n<%@>\t\t",startElementName]];    else startElementName = @"";
        // enumeration des elements
    NSEnumerator *nodeEnumrator = nil;
    NSEnumerator *keyEnumrator = nil;
        // Node actuel, elmeent en cours
    id nodeElement=nil;
    id nodeElementKey=startElementName;
    @try {
            //        NSLog(@"dictionary %@ ::  %@ :", startElementName, dictionary);
        if([dictionary respondsToSelector:@selector(objectEnumerator)])
            nodeEnumrator = [dictionary objectEnumerator];
        if([dictionary respondsToSelector:@selector(keyEnumerator)])
            keyEnumrator = [dictionary keyEnumerator];
        
        while( (nodeElement= [nodeEnumrator nextObject])){
            if(keyEnumrator)
                nodeElementKey= [keyEnumrator nextObject];
            
                // NSLog(@"%@ :: Enumerate :: %@ :: %@", NSStringFromSelector(_cmd), nodeElementKey, nodeElement);
            
            if(nodeElement!=nil )
                if([ nodeElement isKindOfClass:[NSDictionary class]]){
                        // if([nodeElementKey isEqualToString: startElementName]) nodeElementKey = nil;
                        // NSLog(@"dictionary %@ ::  %@ : %@ ", startElementName, nodeElementKey,  dictionary);
                        // [xmlParentNodeContent appendString: [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey] ] ;
                    
                    [xmlParentNodeContent appendString:  [NSString stringWithFormat:@"\n\t<%@>%@\n</%@>", nodeElementKey,   [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey], nodeElementKey] ] ;
                }else if([ nodeElement isKindOfClass:[NSArray class]]){
                        // so idecide here to use fastEnumeration
                    
                }else if([ nodeElement isKindOfClass:[NSString class]]){
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"\n\t\t\t<%@>%@</%@>", nodeElementKey, nodeElement, nodeElementKey]];
                }else if([nodeElement length]) {
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"\n\t\t\t\t\t<%@>%@</%@>", nodeElementKey, nodeElement, nodeElementKey]];
                }else{
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"\n\t\t\t<%@/>", nodeElementKey]];
                }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"********************* \n ******************\nError at Line %d :: %@:%@ :: FAIL to Enumerate :: %@ :: %@ \n *************** \n%@\n****************", __LINE__, NSStringFromClass([self class]), NSStringFromSelector(_cmd), nodeElementKey, nodeElement, exception);
    }
    @finally {
        
    }
        // fermeture node parent
        //   if([startElementName length]) [xmlParentNodeContent appendString:[NSString stringWithFormat:@"\n\t\t</%@>",startElementName]];
    return xmlParentNodeContent;
}
@end
