//
//  NSString+HJPredicate.h
//
//  Created by huangjian on 16/5/20.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HJPredicate)
//有效的电话号码
- (BOOL) isValidMobileNumber;

//有效的真实姓名
- (BOOL) isValidRealName;
//是否只有中文
- (BOOL) isOnlyChinese;

//有效的银行卡号
- (BOOL) isValidBankCardNumber;

//有效的邮箱
- (BOOL) isValidEmail;

//检测有效身份证
//15位
- (BOOL) isValidIdentifyFifteen;

//18位
- (BOOL) isValidIdentifyEighteen;

//有效的验证码(根据自家的验证码位数进行修改)
- (BOOL) isValidVerifyCode;
@end
