//
//  NSData_NSDataExtentions.m
//  2801_app_ios
//
//  Created by Cotillard on 30/01/2017.
//  Copyright © 2017 genose.org. All rights reserved.
//

#import "NSData_NSDataExtentions.h"

@implementation NSData (NSDataExtentions)

-(NSUInteger)EncodingType
{
        // Really Really basic handling of Encoding basics ...
        // :: can use some var for Error Handling process :: NSUInteger encodingType =  NSASCIIStringEncoding;
    
    NSString *dataStr;
    dataStr = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (dataStr)
    {
        NSLog(@"Return utf-8!");
        return NSUTF8StringEncoding;
    }
    
     NSLog(@" Found ASCII !");
    return NSASCIIStringEncoding;
}

@end
