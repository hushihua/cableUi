//
//  NSData+Extension.h
//  Common
//
//  Created by 汪锐 on 2019/4/26.
//  Copyright © 2019年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Extension)

//判断是不是gif
+ (BOOL)isGifWithImageData: (NSData *)data;
//数据的类型
+ (NSString *)contentTypeWithImageData: (NSData *)data;

@end

NS_ASSUME_NONNULL_END
