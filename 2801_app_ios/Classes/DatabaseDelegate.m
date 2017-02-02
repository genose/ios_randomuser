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
        /* ********************* */
        /* ********************* */
            // DEBUG DEBUG Purpose
            // DEBUG DEBUG Purpose
            // DEBUG DEBUG Purpose
            // DEBUG DEBUG Purpose
        NSString *storePathBase = [NSString stringWithFormat:@"/Volumes/ramfstmp"];
            // COCOA :: kek choz comme :: stringbyappendingcompenent
        NSString *storePath = [NSString stringWithFormat:@"%@/%@",storePathBase,URL_Database_local];
            // :: utiliser ceci en reel :: NSString *storePath = [applicationDocumentsDir stringByAppendingPathComponent: URL_Database_local];
        
        /* ********************* */
        /* ********************* */
        /* ********************* */
        
        NSMutableString *databaseContent = [[NSMutableString alloc] initWithString:@"Some XML should later There"] ;
        
#if defined( __USE_BDD_HTTP_XML__) && __USE_BDD_HTTP_XML__
        
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:storePath  error:nil];
        
        NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        long long fileSize = [fileSizeNumber longLongValue];
        
            // test la presence du fichier Database local
            // effectuer l'initialisation du fichier database Vide lors de la premiere utilisation
        if( ![[NSFileManager defaultManager] fileExistsAtPath:storePath]){
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
        DatabaseRecords = [NSMutableDictionary dictionaryWithXMLString:databaseContent];
        workingTable = [NSArray arrayWithObject: DatabaseRecords];
            //  NSLog(@"dictionary: %@", DatabaseRecords);
        return self;
        }
        @catch (NSException *exceptionApp) {
            NSLog(@"## FATAL ERROR ## NSApp FATAL NSEXCEPTION");
            NSLog(@" * * * Local Exception Catched  * * * %@",exceptionApp);
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
    NSLog(@" settable %@",DatabaseRecordsTable);
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
    id nodeElementKey=nil;
    @try {
        while( (nodeElement= [nodeEnumrator nextObject])){
            nodeElementKey= [keyEnumrator nextObject];
            if(nodeElement!=nil ){
                
                [xmlDocContent appendString: [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey] ] ;
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
    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"<%@>",startElementName]];
    
        // enumeration des elements
    NSEnumerator *nodeEnumrator = [dictionary objectEnumerator];
    NSEnumerator *keyEnumrator = [dictionary keyEnumerator];
        // Node actuel, elmeent en cours
    id nodeElement=nil;
    id nodeElementKey=nil;
    @try {
        while( (nodeElement= [nodeEnumrator nextObject])){
            
            nodeElementKey= [keyEnumrator nextObject];
            
            NSLog(@"%@ :: Enumerate :: %@ :: %@", NSStringFromSelector(_cmd), nodeElementKey, nodeElement);
            
            if(nodeElement!=nil )
                if([ nodeElement isKindOfClass:[NSDictionary class]]){
                    [xmlParentNodeContent appendString: [self ConvertDictionarytoXML_nodeElement:nodeElement nodeName:nodeElementKey] ] ;
                }else if([ nodeElement isKindOfClass:[NSArray class]]){
                        // so idecide here to use fastEnumeration
                    
                }else if([ nodeElement isKindOfClass:[NSString class]]){
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"<%@>%@</%@>", nodeElementKey, nodeElement, nodeElementKey]];
                }else if([nodeElement length]) {
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"<%@>%@</%@>", nodeElementKey, nodeElement, nodeElementKey]];
                }else{
                    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"<%@/>", nodeElementKey]];
                }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"********************* \n ******************\nError at Line %d :: %@:%@ :: FAIL to Enumerate :: %@ :: %@ \n *************** \n%@\n****************", __LINE__, NSStringFromClass([self class]), NSStringFromSelector(_cmd), nodeElementKey, nodeElement, exception);
    }
    @finally {
        
    }
        // fermeture node parent
    [xmlParentNodeContent appendString:[NSString stringWithFormat:@"</%@>",startElementName]];
    return xmlParentNodeContent;
}
-(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary withStartElement:(NSString*)startele
{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    NSArray *arr = [dictionary allKeys];
    [xml appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    [xml appendString:[NSString stringWithFormat:@"<%@>",startele]];
    for(int i=0;i<[arr count];i++)
        {
        id nodeValue = [dictionary objectForKey:[arr objectAtIndex:i]];
        if([nodeValue isKindOfClass:[NSArray class]] )
            {
            if([nodeValue count]>0){
                for(int j=0;j<[nodeValue count];j++)
                    {
                    id value = [nodeValue objectAtIndex:j];
                    if([ value isKindOfClass:[NSDictionary class]])
                        {
                        [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
                        [xml appendString:[NSString stringWithFormat:@"%@",[value objectForKey:@"text"]]];
                        [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
                        }
                    
                    }
            }
            }
        else if([nodeValue isKindOfClass:[NSDictionary class]])
            {
            [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
            if([[nodeValue objectForKey:@"Id"] isKindOfClass:[NSString class]])
                [xml appendString:[NSString stringWithFormat:@"%@",[nodeValue objectForKey:@"Id"]]];
            else
                [xml appendString:[NSString stringWithFormat:@"%@",[[nodeValue objectForKey:@"Id"] objectForKey:@"text"]]];
            [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
            }
        
        else
            {
            if([nodeValue length]>0){
                [xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
                [xml appendString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:[arr objectAtIndex:i]]]];
                [xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
            }
            }
        }
    
    [xml appendString:[NSString stringWithFormat:@"</%@>",startele]];
    NSString *finalxml=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
        //  NSLog(@"%@",xml);
    return finalxml;
}

@end
