//
//  JJTestImage.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/12.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJTestImage.h"

@implementation JJTestImage


+ (UIImage *)drawText1:(NSString *)text1 text2:(NSString *)text2 forImage:(UIImage *)image{
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor redColor]};
   
    // 画文字 让文字处于居中模式
    [text1 drawAtPoint:CGPointMake(3,2) withAttributes:attributes];
    [text2 drawAtPoint:CGPointMake(9,2) withAttributes:attributes];

    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)drawText1:(NSString *)text1 text2:(NSString *)text2{
    
    UIImage *image = [UIImage imageNamed:@"messagelist_number_icon"];
    
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    UIFont *boldFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
    NSDictionary *attributes = @{NSFontAttributeName:boldFont, NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#413956"]};
    
    NSString *str1 = @"0";
    if (text1.length > 0) {
        str1 = [text1 substringToIndex:1];
    }
    NSString *str2 = @"0";
    if (text2.length > 0) {
        str2 = [text2 substringToIndex:1];
    }
    
    // 画文字 让文字处于居中模式
    [str1 drawAtPoint:CGPointMake(3,2.5) withAttributes:attributes];
    [str2 drawAtPoint:CGPointMake(9,2.5) withAttributes:attributes];
    
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}



//在图片上绘制文字
+ (UIImage *)drawText:(NSString *)text forImage:(UIImage *)image{
    
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor redColor]};
   
    // 画文字 让文字处于居中模式
    [text drawAtPoint:CGPointMake(3,2) withAttributes:attributes];
    
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize{

    //画布大小
    CGSize size = CGSizeMake(18,18);

    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);//opaque:NO  scale:0.0
    
    [self drawAtPoint:CGPointMake(0.0,0.0)];
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中

    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor whiteColor]}context:nil].size;

    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);

    //绘制文字
    [title drawInRect:rect withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[ UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];

    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}





@end
