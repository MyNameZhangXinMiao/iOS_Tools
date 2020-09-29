//
//  JJApplePayManager.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJApplePayManager.h"


@interface JJApplePayManager ()

//商品
@property (nonatomic,strong) SKProduct *iapProduct;
// 商品id
@property (nonatomic,strong) NSString *appProductId;
// 购买关键字
@property (nonatomic,strong) NSString *preExchargeKey;


@end
@implementation JJApplePayManager

static id _instance;
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}
/// 请求商品ID
/// @param productId 商品ID
/// @param preExchargeKey 交易关键字
- (BOOL)requestProductWithId:(NSString *)productId withPreExchargeKey:(NSString *)preExchargeKey{
   
    if (productId.length > 0) {
        NSLog(@"请求商品: %@", productId);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:productId]];
        productRequest.delegate = self;
        [productRequest start];
        self.appProductId = productId;
        self.preExchargeKey = preExchargeKey;
    
        return YES;
    } else {
        NSLog(@"商品ID为空");
        return NO;
    }
    
}



/// 购买商品.
/// @param skProduct 商品
/// @return NO:商品不存在
- (BOOL)purchaseProduct:(SKProduct *)skProduct{
    
    if (skProduct != nil) {
        if ([SKPaymentQueue canMakePayments]) {
            SKPayment *payment = [SKPayment paymentWithProduct:skProduct];
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        } else {
            NSLog(@"失败，用户禁止应用内付费购买.");
            return NO;
        }
    }
    return NO;
}


#pragma mark - delagate
// 产品请求被发送到苹果应用商店。
// 产品清单的详细信息。
- (void)productsRequest:(nonnull SKProductsRequest *)request didReceiveResponse:(nonnull SKProductsResponse *)response {
    NSArray *iapProductArray = response.products;
    if (iapProductArray.count > 0) {
        self.iapProduct = [iapProductArray objectAtIndex:0];
        if ([self.delegate respondsToSelector:@selector(jj_payReceiveProduct:)]){
                [_delegate jj_payReceiveProduct:self.iapProduct];
        }
    }else {
        NSLog(@"无法获取产品信息，购买失败。");
    }
}

- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    /**
     21000:   App Store不能读取你提供的JSON对象
     
     21002:   receipt-data域的数据有问题
     
     21003:   receipt无法通过验证
     
     21004:   提供的shared secret不匹配你账号中的shared secret
     
     21005:    receipt服务器当前不可用
     
     21006:    receipt合法，但是订阅已过期。服务器接收到这个状态码时，receipt数据仍然会解码并一起发送
     21007:    receipt是Sandbox receipt，但却发送至生产系统的验证服务
     
     21008: receipt是生产receipt，但却发送至Sandbox环境的验证服务
     
     
     Purchased    购买成功
     Restored    恢复购买
     Failed    失败
     Deferred    等待确认，儿童模式需要询问家长同意
     */
    
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
            {
                NSLog(@"商品:%@被添加进购买列表",self.iapProduct.localizedTitle);
            }
                break;
                
            case SKPaymentTransactionStatePurchased://交易成功
            {
                [self completeTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed://交易失败
            {
                NSString *error_string = [self failedTransaction:transaction];
                NSLog(@"交易失败- %@",error_string);
            }
                break;
            case SKPaymentTransactionStateRestored://已购买过该商品
            {
               
                [self restoreTransaction:transaction];

            }
                break;
            case SKPaymentTransactionStateDeferred://交易延迟
            {
                NSLog(@"苹果支付 -- 管理类购买延迟！");
            }
                break;
            default:
            {
                NSLog(@"苹果支付 -- 未知错误");
            }
                break;
        }
    }
}


//完成交易
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    
}

//交易失败
- (NSString *)failedTransaction:(SKPaymentTransaction *)transaction{
    
    return @"";
}
// 对于已购商品，处理恢复购买的逻辑
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
@end
