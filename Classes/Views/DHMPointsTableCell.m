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

#import "DHMPointsTableCell.h"
#import "DHMController.h"
#import "DHMStoreHelper.h"

@implementation DHMPointsTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
    }
    return self;
}

-(void)dealloc
{
    [self.buyButton removeTarget:self.buyObject action:self.buyObjectSelector forControlEvents:UIControlEventTouchUpInside];
    self.storeProduct = nil;
    self.buyObject = nil;
    self.buyObjectSelector = nil;
}

@synthesize buyObject;

@synthesize buyObjectSelector;

@synthesize storeProduct;

@synthesize cellState = _cellState;

- (void)setCellState:(PointsCellState)cellState
{
    // Change states only if they differ
    if(_cellState != cellState)
    {
        _cellState = cellState;
        switch (cellState)
        {
            case PointsCellStateIsBuying:
                // Buying, so start animation and disable button
                [self.buyButton setEnabled:NO];
                [self.buyIndicator startAnimating];
                break;
            case PointsCellStateCanBuy:
                // Can buy, so reset every control to enabled
                [self.buyButton setEnabled:YES];
                [self.textLabel setEnabled:YES];
                [self.buyIndicator stopAnimating];
                break;
            case PointsCellStateError:
            case PointsCellStateCannotBuy:
                // Disable and stop animating
                [self.buyIndicator stopAnimating];
                [self.buyButton setEnabled:NO];
                [self.textLabel setEnabled:NO];
                break;
            default:
                break;
        }
    }
}

@synthesize textLabel;

@synthesize buyButton;

-(void) setupCellWithProduct:(SKProduct *)product
{
    [self setupCellWithProduct:product buyObject:self buyHandler:@selector(buyButtonPressed:)];
}

-(void) setupCellWithProduct:(SKProduct *)product buyObject:(id)obj buyHandler:(SEL)handler;
{
    self.storeProduct = product;
    
    // Points are returns as strings (in the title), so we first need the numeric value
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* unformattedPoints = [f numberFromString:product.localizedTitle];
    
    NSNumber* unformattedPrice = product.price;
    
    // Update price with currency formatter
    NSString* formattedPrice = [[DHMController sharedInstance].currencyFormatter stringFromNumber:unformattedPrice];
    
    // Update points with points formatter
    NSString* formattedPoints = [[DHMController sharedInstance].pointsFormatter stringFromNumber:unformattedPoints];
    
    [self.textLabel setText:formattedPoints];
    [self.buyButton setTitle:formattedPrice forState:UIControlStateNormal];
    [self.buyButton sizeToFit];
    
    if(obj != nil)
    {
        if([obj respondsToSelector:handler])
        {
            [self.buyButton addTarget:obj action:handler forControlEvents:UIControlEventTouchUpInside];
            self.buyObject = obj;
            self.buyObjectSelector = handler;
        }
        else
        {
            // No valid selector means it shouldn't be tap-able
            [self.buyButton setEnabled:NO];
        }
    }
    
    self.cellState = PointsCellStateCanBuy;
    
    [self setAccessibilityLabel:[NSString stringWithFormat:NSLocalizedString(@"%@ for %@", @"Purchase points label for accessibility"), formattedPoints, formattedPrice]];
}

-(void)setupCellWithTest:(NSDictionary*)dict buyObject:(id)obj buyHandler:(SEL)handler;
{
    // String to store all formatted strings
    NSNumber* unformattedPoints = (NSNumber*)[dict valueForKey:@"points"];
    NSNumber* unformattedPrice = (NSNumber*)[dict valueForKey:@"price"];
    
    // Update price with currency formatter
    NSString* formattedPrice = [[DHMController sharedInstance].currencyFormatter stringFromNumber:unformattedPrice];
    
    // Update points with points formatter
    NSString* formattedPoints = [[DHMController sharedInstance].pointsFormatter stringFromNumber:unformattedPoints];
    
    [self.textLabel setText:formattedPoints];
    [self.buyButton setTitle:formattedPrice forState:UIControlStateNormal];
    [self.buyButton sizeToFit];
    
    if(obj != nil)
    {
        if([obj respondsToSelector:handler])
        {
            [self.buyButton addTarget:obj action:handler forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            // No valid selector means it shouldn't be tap-able
            [self.buyButton setEnabled:NO];
        }
    }
    
    self.cellState = PointsCellStateCanBuy;

    [self setAccessibilityLabel:[NSString stringWithFormat:NSLocalizedString(@"%@ for %@", @"Purchase points label for accessibility"), formattedPoints, formattedPrice]];
}

- (void)buyButtonPressed:(id)sender
{
    NSAssert(self.storeProduct != nil, @"Store object cannot be nil");
    
    self.cellState = PointsCellStateIsBuying;
    
    NSLog(@"Buying (but not really) %@...", self.storeProduct.productIdentifier);
    [[DHMStoreHelper sharedInstance] buyProduct:self.storeProduct];
}

@end
