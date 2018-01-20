/**
 * DH Bot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *  
 * DH Bot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with DH Bot. If not, see 
 * https://github.com/unsaturated/DHBot/blob/master/LICENSE.
 */

#import "DHMStoreHelper.h"

@interface DHMStoreHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

@implementation DHMStoreHelper
{
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
    NSArray* _products;
}

+ (DHMStoreHelper *)sharedInstance
{
    static dispatch_once_t once;
    static DHMStoreHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      IAP_KEY_TIER1_PTS,
                                      IAP_KEY_TIER2_PTS,
                                      IAP_KEY_TIER3_PTS,
                                      IAP_KEY_TIER4_PTS,
                                      IAP_KEY_TIER5_PTS,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers
{
    if ((self = [super init]))
    {
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)buyProduct:(SKProduct *)product
{
    if(product == nil)
        return;
    
    NSLog(@"StoreKit: Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    _completionHandler = [completionHandler copy];
    
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

-(NSArray*) productList
{
    return _products;
}

-(SKProduct *)productObjectFromList:(NSString *)usingKey
{
    SKProduct* result = nil;
    
    if(_products == nil)
        return result;
    
    for(SKProduct* p in self.productList)
    {
        if([p.productIdentifier isEqualToString:usingKey])
        {
            result = p;
            break;
        }
    }
    
    return result;
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"StoreKit: Loaded list of products...");
    _productsRequest = nil;
    NSArray * skProducts = response.products;

    for(SKProduct * skProduct in skProducts)
	{
        NSLog(@"StoreKit: Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }

    // Sort results by price
    _products = [[skProducts sortedArrayUsingComparator:^(id obj1, id obj2)
     {
         SKProduct* prod1 = (SKProduct*)obj1;
         SKProduct* prod2 = (SKProduct*)obj2;
         if (prod1.price.floatValue > prod2.price.floatValue)
         {
             return (NSComparisonResult)NSOrderedDescending;
         }
         
         if (prod1.price.floatValue < prod2.price.floatValue)
         {
             return (NSComparisonResult)NSOrderedAscending;
         }
         return (NSComparisonResult)NSOrderedSame;
     }] copy];
    
    _completionHandler(YES, _products);
    _completionHandler = nil;
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"StoreKit: Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions)
	{
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [[NSNotificationCenter defaultCenter] postNotificationName:IAP_PURCHASE_INPROG_NOTIFICATION object:nil userInfo:nil];
                break;
            case SKPaymentTransactionStateFailed:
                [[NSNotificationCenter defaultCenter] postNotificationName:IAP_PURCHASE_FAILED_NOTIFICATION object:nil userInfo:nil];
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [[NSNotificationCenter defaultCenter] postNotificationName:IAP_PURCHASE_INPROG_NOTIFICATION object:nil userInfo:nil];
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    };
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
}

#pragma mark - SKPaymentTransactionObserver Helpers

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"StoreKit: completeTransaction...");
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"StoreKit: restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"StoreKit: failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"StoreKit: Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier
{
    if([_productIdentifiers containsObject:productIdentifier])
    {
        SKProduct* product = nil;
        
        for(SKProduct * productIter in _products)
        {
            // Find the matching product so its title, description can be used
            if([productIter.productIdentifier isEqualToString:productIdentifier])
            {
                product = productIter;
                break;
            }
        }
        
        // If found a product match
        if(product)
        {
            // Use the title and extract point information
            NSString *pointsString = [product.localizedTitle stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber* number = [f numberFromString:pointsString];
            NSUInteger points = number.unsignedIntegerValue;
            
            // Update the local point count
            [[DHMController sharedInstance] addPoints:points];
            [[DHMController sharedInstance] saveAppSettings];
            [[NSNotificationCenter defaultCenter] postNotificationName:IAP_PURCHASE_SUCCESS_NOTIFICATION object:productIdentifier userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:PTS_ADDED_NOTIFICATION object:nil];
        }
    }
}

@end
