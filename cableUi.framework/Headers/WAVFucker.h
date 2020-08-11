//
//  WAVFucker.h
//  Common
//
//  Created by adam on 2019/4/20.
//  Copyright © 2019 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAVFucker : NSObject

#pragma mark - 分析wav的声纹曲线,返回声纹数据
+ (nullable NSData*)decodeWAVInfo:(nonnull NSString*)path;

#pragma mark - 对生成的声纹数据进行采样 (因为没有足够的空间可以显示所有的声纹数据)
+ (nullable NSMutableArray*)encodeLineValue:(nonnull NSData*)data offset:(int)offset;

@end

