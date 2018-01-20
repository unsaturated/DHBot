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
#import "DHMBaseCommand.h"

/**
 Custom UITableCell for displaying the list of supported API commands.
 */
@interface DHMCommandTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *pointsTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteTextLabel;
@property (nonatomic, weak) DHMBaseCommand* command;

/**
 Setup the cell to execute with points or give unsupported reason. This is the typical
 use case for most commands.
 @param cmd Command to execute
 */
-(void) setupCellWithCommand:(DHMBaseCommand*)cmd;

/**
 Setup the cell to with the specified disclosure indicator. Some use cases for this:
  - when the command should be displayed but not executed,
  - when the command should be displayed and executed (disclosure)
  - when more information is available (information), etc
 @param cmd Command to use
 @param indicator Accessory indicator to display
 */
-(void) setupCellWithCommand:(DHMBaseCommand*)cmd accessory:(UITableViewCellAccessoryType)indicator;

/**
 Updates the cell according to available points, changing the UI if there are in/sufficient points to execute the command.
 To update properly, one of the setupCellWithCommand messages must first be sent.
 @param pointsAvailable points available for executing commands
 @return YES if point change caused the cell to update
 */
-(void) updateWithNewAvailablePoints:(NSUInteger)pointsAvailable;

@end
