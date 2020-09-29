//
//  JJApplePayManager.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SKProduct;

@protocol JJApplePayManagerDelegate<NSObject>

@optional
//获取商品信息
- (void)jj_payReceiveProduct:(SKProduct *)product;

//购买成功回调
- (void)jj_paySuccessfulPurchaseOfId:(NSString *)productId andReceipt:(NSData *)transactionReceipt transactionId:(NSString *)transactionId;

//购买失败回调
- (void)jj_payFailedPurchaseWithError:(NSString *)errorDescripiton;


@end


@interface JJApplePayManager : NSObject
<SKProductsRequestDelegate,
SKPaymentTransactionObserver
>

@property (nonatomic, weak) id<JJApplePayManagerDelegate> delegate;



+ (instancetype)shared;




/// 请求商品ID
/// @param productId 商品ID
/// @param preExchargeKey 交易关键字
- (BOOL)requestProductWithId:(NSString *)productId withPreExchargeKey:(NSString *)preExchargeKey;



/// 购买商品.
/// @param skProduct 商品
/// @return NO:商品不存在
- (BOOL)purchaseProduct:(SKProduct *)skProduct;


@end

NS_ASSUME_NONNULL_END
