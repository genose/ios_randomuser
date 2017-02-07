//
//  DatabaseDelegate.h
//  2801_app_ios
//
//  Created by Cotillard on 30/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#ifndef DatabaseDelegate_h
#define DatabaseDelegate_h

static NSString *const DatabaseDelegateSourceTypeXML = @"xml";


#endif /* DatabaseDelegate_h */
@interface DatabaseDelegate : NSObject
@property (strong, nonatomic) NSMutableDictionary *DatabaseRecords ;
@property (strong, nonatomic) NSMutableString *DatabaseRecordsTable;
@property (strong, nonatomic) NSArray *allKeysIndex;

    // origin et destination, type de source de donnees
@property (strong, nonatomic) NSMutableString *sourceType;


-(void)DatabaseCommitObjectAtIndex:(long)index :(id)dataCommit;
-(void)DatabaseDeleteObjectAtIndex:(int)index;
-(NSString*)DatabaseObjectAtIndex:(long)index;
-(void)setMasterTableIndex: (NSString*)tableName;
-(long)countRecord;
@end
@interface DatabaseDelegate (XMLBackend)
-(void)commitToDiskWithXML;
-(NSString*)commitToXML;

-(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary;
-(NSString*)ConvertDictionarytoXML_nodeElement:(NSDictionary*)dictionary nodeName:(NSString*)startElementName;
@end
