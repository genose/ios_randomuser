//
//  NSArray_NSDictionnary_extention.h
//  Project 2306
//
//  Created by Cotillard on 13/11/05.
//  Copyright 2005 Genose.org. All rights reserved.
//

 
@interface NSMutableArray (remove_norelease)
-(id) removeObject_norelease:(id)object;
-(id) removeAllObjects_norelease;
+(id)addObject: (id)newObject;
-(id)appendObject: (id)newObject;
-(BOOL)isInArray :(id) anObject;
-(id) pushFiFo;
@end


@interface NSArray (IndexForClass)
-(id) indexOfObjectWithClass:(id) classObj;
-(NSMutableArray *)replaceObjectAtIndex:(int)index inArray:(NSArray *)array withObject:(id)object ;
@end

@interface NSArray (NSArray_extention)
-(NSArray*) allKeysInner;
-(id)objectForKey:(NSString*)index;
-(id)objectAtIndexSubscript:(int)index;
- (id)objectAtIndexedSubscript:(int)idx;
- (void)setObject:(id)obj atIndexedSubscript:(int)idx;

-(NSArray*) allKeys;
-(NSString*) implodeKeys;


@end

@interface NSDictionary (NSDictionnary_extention)

-(void) addObject:(id) objectInsert  forKey:(id) itemSignID;
-(void) addObject:(id) objectInsert;
-(void) addObjectWithCurrentTimestamp:(id) objectInsert;

-(NSString*)description :(NSRange)range;
 


@end
