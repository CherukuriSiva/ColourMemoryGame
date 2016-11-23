//
//  LCCommon.m
//  LeChal
//
//  Created by Muthiah Kasi on 2/18/15.
//  Copyright (c) 2015 DucereTechnologies. All rights reserved.
//

#import "Common.h"
#import <UIKit/UIKit.h>

@implementation Common

/*****************************************************************
 // Purpose		: get Application Documents Directory path
 // Parameters	: nil
 // Return type	: NSString
 // Comments	: get Application Documents Directory path
 *****************************************************************/
+ (NSString *) getAppDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
