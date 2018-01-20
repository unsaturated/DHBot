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
#import "DHMListUserDataItem.h"

/**
 * Provides a static list of details on a specific user.
 */
@interface DHMUserDetailViewController : UITableViewController

/**
 * Sets the user details to use for display.
 * @param user data for user
 */
-(void) setUser:(DHMListUserDataItem*) user;

#pragma UI Bindings

@property (weak, nonatomic) IBOutlet UILabel *accountIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shellLabel;
@property (weak, nonatomic) IBOutlet UILabel *diskLabel;

@end
