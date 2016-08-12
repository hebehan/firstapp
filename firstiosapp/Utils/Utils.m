//
// Created by Hebe on 16/7/31.
// Copyright (c) 2016 Hebe. All rights reserved.
//

#import "Utils.h"

@interface Utils()

@end
@implementation Utils

+(CGSize) getStringCGSize:(NSString *)string fontsize:(CGFloat)size width:(CGFloat)width height:(CGFloat)height mode:(NSLineBreakMode)mode {

        return [string sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(width==0,height) lineBreakMode:mode];
}
@end