//
//  NSString+Extra.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)



/// 是否是空字符串
+ (BOOL)isNil:(NSString *)string{
    if (!string){
        return YES;
    }
    if (string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if ([string isEqualToString:@""]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}

///有效的电话号码
- (BOOL)isValidMobileNumber{
    NSString* const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

///有效的姓名
- (BOOL)isValidRealName{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [predicate evaluateWithObject:self];
}

///是否只有中文
- (BOOL)isOnlyChinese{
    NSString * chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}

/// 有效的验证码
/// @param length 验证码长度
- (BOOL)isValidVerifyCode:(NSInteger)length{
    if (length > 0) {
        // @"^[0-9]{4}";
        NSString *pattern = [NSString stringWithFormat:@"^[0-9]{%ld}",(long)length];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        return [predicate evaluateWithObject:self];
    }
    return NO;
}

/// 有效的银行卡号
- (BOOL)isValidBankCardNumber{
    NSString* const BANKCARD = @"^(\\d{16}|\\d{19})$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}

/// 有效的邮箱
- (BOOL)isValidEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *email = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [email evaluateWithObject:self];
}

/// 有效的字母数字密码
- (BOOL)isValidAlphaNumberPassword{
    NSString *regex = @"^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [identityCardPredicate evaluateWithObject:self];
}

/// 检测有效身份证
- (BOOL)isValidIdCardNumber{
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:self];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [self.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

///判断是否只是数字
- (BOOL)isOnlyNumber{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}



#pragma mark - 修剪字符串

/// 字典转JSON字符串
/// @param dic 传入的字典参数dic
+ (NSString *)dictionaryTransToJSONStringWith:(NSDictionary *)dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        return nil;
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


/// 手机号码中间使用**展示
/// @param phoneNum 手机号码
/// @return 131****889
+ (NSString *)transSecrectMiddleWithPhoneNumber:(NSString*)phoneNum{
    if (phoneNum.length == 11) {
        NSMutableString *strNum = [NSMutableString stringWithString:phoneNum];
        NSRange range = NSMakeRange(3, 7);
        [strNum replaceCharactersInRange:range withString:@"*****"];
        return strNum;
    }
    return nil;
}



/// 银行卡号中间使用**显示,前后各三位是数字
/// @param cardNum 银行卡号
/// @return 123**********656
+ (NSString *)transSecrectMiddleWithBankCardNumber:(NSString *)cardNum{
    
    NSMutableString *strNum = [NSMutableString stringWithString:cardNum];
    NSRange range = NSMakeRange(4, 8);
    if (strNum.length > 12) {
        [strNum replaceCharactersInRange:range withString:@" **** **** "];
    }
    return strNum;
}


/// 数字添加千位符
/// @param number 数字
/// @return 1234,1213
+ (NSString *)countNumberAddThousandIdentity:(NSString *)number{
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,###";
    //如要增加小数点请自行修改为@"###,###,##"
    return [moneyFormatter stringFromNumber:[number toNumber]];
}



/// 转换为number
- (NSNumber *)toNumber{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number=[formatter numberFromString:self];
    return number;
}



#pragma mark - size



/// 计算文字高度
/// @param font 字体大小
/// @param maxWidth 最宽宽度
/// @return 文字高度
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)maxWidth{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}



/// 计算文字宽度
/// @param font 字体大小
/// @param maxHeight 最高高度
- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)maxHeight{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return  [self boundingRectWithSize:CGSizeMake(0, maxHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}



/// 删除小数点后面多余的0
- (NSString *)removePointLastZero{
    if (![self containsString:@"."]) {  //不是小数
        return self;
    }
    
    NSString *text = self;
    do {
        if ([[text substringWithRange:NSMakeRange(text.length - 1, 1)] isEqualToString:@"0"]) {
            text = [text substringWithRange:NSMakeRange(0, text.length-1)];
        }
    } while ([[text substringWithRange:NSMakeRange(text.length - 1, 1)] isEqualToString:@"0"]);
    
    if ([[text substringWithRange:NSMakeRange(text.length - 1, 1)] isEqualToString:@"."]) {
        text = [text substringWithRange:NSMakeRange(0, text.length - 1)];
    }
    
    return text;
}



/// 去掉前后空格
- (NSString *)trimmedSpaceString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

@end
