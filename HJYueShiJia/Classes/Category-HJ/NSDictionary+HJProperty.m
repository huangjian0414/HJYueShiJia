//
//  NSDictionary+HJProperty.m
//
//  Created by huangjian on 16/4/21.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import "NSDictionary+HJProperty.h"

@implementation NSDictionary (HJProperty)
- (void)property
{
    
    // 属性跟字典的key一一对应
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典中所有key取出来
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // key:属性名
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) NSInteger %@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSArray *%@;",key];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSDictionary *%@;",key];
        }
        
        
        
        [codes appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",codes);
    
}

@end
