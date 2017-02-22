    //
    //  NSJSONSerialization+NSJSONSerialization_extention.m
    //  2801_app_ios
    //
    //  Created by xenon on 22/02/2017.
    //  Copyright © 2017 genose.org. All rights reserved.
    //

#import "NSJSONSerialization+NSJSONSerialization_extention.h"
#import "NSObject+NSObject_isKindOf.h"

@implementation NSJSONSerialization (NSJSONSerialization_extention)
+(NSDictionary*) JSONDictionnaryFromString:(NSString*)JSOWhatEval
{
    if([JSOWhatEval isKindOfString:nil]){
        if([NSJSONSerialization isValidJSONObject:JSOWhatEval]){
            NSData *jsonData = [NSData dataWithData:[JSOWhatEval dataUsingEncoding:NSUTF8StringEncoding]];
            NSError *catchedError = [NSError new];
            NSJSONSerialization *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&catchedError];
            return [jsonObject dictionnary];
        }else{
             [NSException raise:NSInvalidArgumentException format:@" Error :: Not a Valid JSON::EVAL::String expr %@ \n:: Class : %@:%@ :: self : %@ ", JSOWhatEval, NSStringFromClass([self class]), NSStringFromSelector(_cmd), self];
        }

    }else{
         [NSException raise:NSInvalidArgumentException format:@" Error :: Not a Valid JSON::ARG::String expr %@ \n:: Class : %@:%@ :: self : %@ ", JSOWhatEval, NSStringFromClass([self class]), NSStringFromSelector(_cmd), self];
    }
    return [NSDictionary new];
}
+(NSDictionary*) JSONDictionnaryFromPTR:(id)JSOWhatEval
{
    if(JSOWhatEval == nil) return  [NSDictionary new];

    if(([JSOWhatEval respondsToSelector:@selector(length)] && [JSOWhatEval respondsToSelector:@selector(characterAtIndex:)]  )){
        return [NSJSONSerialization JSONDictionnaryFromString:JSOWhatEval];
    }else{

    }
    return  [NSDictionary new];
}
-(NSDictionary*) dictionnary
{
    NSLog(@"Json  object :: %@ ",[self description]);
    return [NSDictionary new];
}
@end
