//
//  NSString+Extra.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extra)

/// 是否是空字符串
+ (BOOL)isNil:(NSString *)string;

///有效的电话号码
- (BOOL)isValidMobileNumber;

///有效的姓名
- (BOOL)isValidRealName;

///是否只有中文
- (BOOL)isOnlyChinese;

/// 有效的验证码
/// @param length 验证码长度
- (BOOL)isValidVerifyCode:(NSInteger)length;

/// 有效的银行卡号
- (BOOL)isValidBankCardNumber;

/// 有效的邮箱
- (BOOL)isValidEmail;

/// 有效的字母数字密码
- (BOOL)isValidAlphaNumberPassword;

/// 检测有效身份证
- (BOOL)isValidIdCardNumber;

///判断是否只是数字
- (BOOL)isOnlyNumber;




#pragma mark - 修剪字符串

/// 字典转JSON字符串
/// @param dic 传入的字典参数dic
+ (NSString *)dictionaryTransToJSONStringWith:(NSDictionary *)dic;


/// 手机号码中间使用**展示
/// @param phoneNum 手机号码
/// @return 131****889
+ (NSString *)transSecrectMiddleWithPhoneNumber:(NSString*)phoneNum;



/// 银行卡号中间使用**显示,前后各三位是数字
/// @param cardNum 银行卡号
/// @return 123**********656
+ (NSString *)transSecrectMiddleWithBankCardNumber:(NSString*)cardNum;


/// 数字添加千位符
/// @param number 数字
/// @return 1234,1213
+ (NSString *)countNumberAddThousandIdentity:(NSString *)number;


/// 转换为number
- (NSNumber *)toNumber;


#pragma mark - size


/// 计算文字高度
/// @param font 字体大小
/// @param maxWidth 最宽宽度
/// @return 文字高度
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)maxWidth;



/// 计算文字宽度
/// @param font 字体大小
/// @param maxHeight 最高高度
- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)maxHeight;


/// 返回
/// @param font 字体大小
/// @param size size
/// @param lineBreakMode lineBreakMode
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


/// 单行的时候计算宽度
/// @param font 字体大小
- (CGFloat)widthForFont:(UIFont *)font;

/// 删除小数点后面多余的0
- (NSString *)removePointLastZero;

/// 去掉前后空格
- (NSString *)trimmedSpaceString;


@end

NS_ASSUME_NONNULL_END
