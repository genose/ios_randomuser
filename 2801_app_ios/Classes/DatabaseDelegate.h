//
//  DatabaseDelegate.h
//  2801_app_ios
//
//  Created by Cotillard on 30/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#ifndef DatabaseDelegate_h
#define DatabaseDelegate_h


#endif /* DatabaseDelegate_h */
@interface DatabaseDelegate : NSObject
@property (strong, nonatomic) NSMutableDictionary *DatabaseRecords ;
@property (strong, nonatomic) NSMutableString *DatabaseRecordsTable;
@property (strong, nonatomic) NSArray *allKeysIndex;
-(NSString*)DatabaseObjectAtIndex:(long)index;
-(void)setMasterTableIndex: (NSString*)tableName;
-(long)countRecord;
@end
@interface DatabaseDelegate (XMLBackend)
-(NSString*)commitToXML;
-(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary withStartElement:(NSString*)startele;
@end
