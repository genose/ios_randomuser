    //
    //  NSArray_extention.m
    //  Project 2306
    //
    //  Created by Cotillard on 13/11/05.
    //  Copyright 2005 Genose.org. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "NSArray_NSDictionnary_extention.h"


id staticcopyArray = nil;
@implementation NSMutableArray (remove_norelease)

@end
@implementation NSArray (IndexForClass)


-(NSArray *)replaceObjectAtIndex:(int)index inArray:(NSArray *)array withObject:(id)object {
    NSMutableArray *mutableArray = [array mutableCopy];
        // mutableArray[index] = object;
    [mutableArray replaceObjectAtIndex:index withObject:object];
    return [NSArray arrayWithArray:mutableArray];
}

@end
@implementation NSArray (NSArray_extention)
-(NSArray*) allKeysInner
{
    NSMutableArray *foundElement = [NSMutableArray array];
    id _element = nil;
    NSArray *walkArray = [NSArray arrayWithArray: self];
    
    NSEnumerator  *walkElement = [ walkArray objectEnumerator];
    
    while( ( _element = [walkElement  nextObject] ) ) {
        if ([_element isKindOfClass:[NSArray class]]){
            if(   [_element count]>1 && [ (id)[_element objectAtIndex:1] isKindOfClass: [NSString class] ]){
                [foundElement addObject: [_element objectAtIndex:1]];
                
            }
        }else if ([_element isKindOfClass:[NSString class]]){
            if(   [_element length]>1  ){
                [foundElement addObject: _element];
                
            }
        }
        
    }
    return foundElement;
}
-(NSArray*) allKeys
{
        //  kfunc_wtf_implemented_do_debuggerBreak ;;
    NSMutableArray *returndict = [[NSMutableArray alloc]init];
        //NSEnumerator *itemKEY                           =[[NSEnumerator alloc]init];
        // NSEnumerator *sub_itemKEY                       =[[NSEnumerator alloc]init];
    id objarray = self;
    
        // :: NSLog(@">>>>> :::: %@ <<<<<<<< ", objarray);
    
    
    NSEnumerator  *keysElement = [ objarray objectEnumerator];
        //  NSEnumerator  *keysElementKeys = [ objarray keyEnumerator];
        // id  sub_keysElement ;
    id dict_element_key;
    id sub_dict_element_key;
    long idx = 0;
    if(keysElement != nil){
        while( ( dict_element_key = [keysElement  nextObject] ) )
            {
            
                //  sub_dict_element_key = [keysElementKeys  nextObject];
                //NSLog(@"++++ show dict keys ::  :::: %@",sub_dict_element_key);
                //    NSLog(@"++++ show dict ::  :::: %ld :: %@ :: %@", idx, dict_element_key, [ dict_element_key class]);
            if([dict_element_key isKindOfClass: NSClassFromString(@"NSDictionary") ])
                {
                
                
                [returndict addObject:[NSNumber numberWithLong:idx] ];
                }else{
                        // ::  kfunc_wtf_implemented_do_debuggerBreak ;;
                    NSLog(@" >>> do nothing  for :: %@ :: %@", dict_element_key,[dict_element_key class]);
                }
            idx++;
            }
    }else{
        [returndict removeAllObjects];
    }
 
    return [NSArray arrayWithArray:returndict];}
-(NSDictionary*)dictionnaryWithArray_lastIsKey
{
    /* **************************
     todo format :: index 1 is used as Key
     [NSArray arrayWithObjects: @"ignore",@"noproperty",
     [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DetailCellLastName",@"name", @"last" ,nil],@"DetailCellLastName" ,nil], nil ];
     ************************** */
    
    NSMutableDictionary *dictAllower = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionary]];
    id element = nil;
    
    if([element isKindOfClass:[NSArray class]]){
        ;;
    }
    return [NSDictionary dictionaryWithDictionary:dictAllower];
}
-(NSString*) implodeKeys
{
    return [[self allKeys] componentsJoinedByString:@","];
}
-(id)objectForKey:(NSString*)index
{
    id foundElement = nil;
    id _element = nil;
    NSArray *walkArray = [NSArray arrayWithArray: self];
    
    NSEnumerator  *walkElement = [ walkArray objectEnumerator];
    
    while( ( _element = [walkElement  nextObject] ) ) {
        if ([_element isKindOfClass:[NSArray class]]){
            if(   [_element count]>1 && [ (id)[_element objectAtIndex:1] isKindOfClass: [NSString class] ]){
                if([ [_element objectAtIndex:1] isEqualToString: index]){
                    foundElement = [_element objectAtIndex:0];
                break;
                }
            }
        }
        
    }
    return foundElement;
}
-(id)objectAtIndexSubscript:(int)index
{
        // ::   kfunc_notyetfully_implemented;;
    return nil;
}
/*- (id)objectAtIndexedSubscript:(int)idx
 {
 NSLog(@" ### call subscript :: %@ :: %d :: %@ :: %@", NSStringFromSelector(_cmd),idx , [self class] ,self);
 return [self objectAtIndex:idx];
 }*/
/*- (id)objectAtIndexedSubscript:(NSString*)idx
 {
 NSLog(@" ### call subscript :: %@ :: %@ :: %@ :: %@", NSStringFromSelector(_cmd),idx , [self class] ,self);
 return [self objectAtIndex:idx];
 }*/
- (void)setObject:(id)obj atIndexedSubscript:(int)idx
{
    
        // :: kfunc_notyetfully_implemented;;
}



@end
@implementation NSDictionary (NSDictionnary_extention)

-(void) addObject:(id) objectInsert  forKey:(id) itemSignID  {
    
    [self setValue:objectInsert forKey:itemSignID];
        // ::    kfunc_notyetfully_implemented ;;
}
-(void) addObject:(id) objectInsert  {
    
    
        // :: kfunc_notyetfully_implemented ;;
}



-(id)objectAtIndexSubscript:(int)index
{
        // ::  kfunc_notyetfully_implemented;;
    return nil;
}
- (id)objectAtIndexedSubscript:(int)idx{
        // :: kfunc_notyetfully_implemented;;
    return nil;
}
- (void)setObject:(id)obj atIndexedSubscript:(int)idx{
    
        // :: kfunc_notyetfully_implemented;;
}


-(NSString*)description :(NSRange)range
{
    
    unsigned long countRange = [self count];
    NSArray *allKeysFound = [self allKeys];
    NSMutableArray * rangeOutObjects = [[NSMutableArray alloc] init];
    NSMutableString * desc = @"--";
    
    int rangeOut    = MIN(MIN(countRange, range.length), range.length);
    int rangeIn     =  MAX(0,MIN(countRange, range.location));
    
    rangeIn        = MIN(countRange - rangeOut, rangeIn);
    
    if(rangeIn >= countRange){
        ;
    }
    int idx         = 0;
        // :: NSLog(@" range :: %d :: %d : %d", rangeIn, rangeOut, countRange);
    NS_DURING
    if(countRange>0 && rangeOut<=countRange)
        while (idx<(rangeOut-1)) {
            
            [rangeOutObjects addObject:[NSString stringWithFormat:@" %@ : %@ ",[allKeysFound objectAtIndex:rangeIn+idx], [self objectForKey:[allKeysFound objectAtIndex:rangeIn+idx]]]];
            desc = [desc stringByAppendingString:[NSString stringWithFormat:@"\n %@ : %@ ",[allKeysFound objectAtIndex:rangeIn+idx], [self objectForKey:[allKeysFound objectAtIndex:rangeIn+idx]]]
                    ];
            idx++;
        }
        //  NSArray *foundObjectRange = [self objectsForKeys:allKeysFound notFoundMarker:NSNotFound];
        //  NSLog(@" range :: %d :: %d : %d :objectdesc: %@", rangeIn, rangeOut, countRange, [rangeOutObjects description]);
        //    kfunc_notyetfully_implemented ;;
    NS_HANDLER
    
        //:: kfunc_exception_localexception_occur ;;
    
    NS_ENDHANDLER
    
        // [rangeOutObjects description];
        // ::  NSLog(@" log desc :: %@",desc);
    return desc;
}
@end
