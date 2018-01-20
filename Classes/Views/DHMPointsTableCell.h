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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PointsCellState)
{
    PointsCellStateCanBuy,
    PointsCellStateIsBuying,
    PointsCellStateCannotBuy,
    PointsCellStateError
};

/**
 Custom UITableViewCell for offering a point purchase. It displays a brief
 title, the price, and has a 'Buy' button.
 */
@interface DHMPointsTableCell : UITableViewCell

/**
 Gets or sets the current state of the purchase, animating activity views, etc. Cells are 
 typically waiting to be selected, selected and buying, waiting for other cells to be bought (cannot buy),
 or in error. This should evolve over time so the capabilities are abstracted away from other classes.
 */
@property (nonatomic, readwrite, setter = setCellState:) PointsCellState cellState;

/**
 Property linked to the text description of the product.
 For example, "5,000 Points → $0.99"
 */
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

/**
 Property linked to the button to purchase the product.
 For example, "Buy"
 */
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

/**
 Property linked to activity indicator used to indicate a product is being purchased.
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *buyIndicator;

/**
 Object that handles purchases associated with this cell.
 */
@property (weak, nonatomic) id buyObject;

/**
 Selector for the object handling purchases.
 */
@property (assign, nonatomic) SEL buyObjectSelector;

/**
 App Store IAP associated with this cell.
 */
@property (weak, nonatomic) SKProduct* storeProduct;

/**
 Setup the cell with the provided product from StoreKit.
 @param product used to fill in cell details
 */
-(void) setupCellWithProduct:(SKProduct*)product;

/**
 Setup the cell with the provided product from StoreKit.
 @param product used to fill in cell details
 @param obj object used to handle purchasing
 @param handler message handler called when "buy" button is pressed
 */
-(void) setupCellWithProduct:(SKProduct*)product buyObject:(id)obj buyHandler:(SEL)handler;

/**
 Test setup for cells with dummy data.
 @param dict key/value collection with "title" (NSString) and "price" (NSNumber)
 @param obj object used to handle purchasing
 @param handler message handler called when "buy" button is pressed
 */
-(void) setupCellWithTest:(NSDictionary*)dict buyObject:(id)obj buyHandler:(SEL)handler;

@end
