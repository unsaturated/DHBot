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
#import "DHMListPsDataItem.h"
#import "DHMBaseCommand.h"

/**
 Displays details on a specific private server.
 */
@interface DHMListPsDetailViewController : UITableViewController
{
@protected
    DHMBaseCommand* _mCommand;
}

/**
 Sets the server details.
 @param server server data
 */
-(void) setServer:(DHMListPsDataItem*)server;

#pragma mark - UI Bindings

@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* statusLabel;
@property (weak, nonatomic) IBOutlet UILabel* typeLabel;
@property (weak, nonatomic) IBOutlet UILabel* memoryLabel;
@property (weak, nonatomic) IBOutlet UILabel* startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* ipLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rebootButton;

#pragma mark - Single Command View

/**
 Command associated with current viewcontroller.
 */
@property (nonatomic, strong) DHMBaseCommand* command;

/**
 Array of resulting data objects.
 */
@property (nonatomic, strong) NSMutableArray* commandResultArray;

/**
 Executes the command assigned to the view-controller. If the command
 requires input it should be provided before executing. Some commands may be
 executed on viewDidLoad, other times after input is provided.
 */
-(void) executeCommand;

/**
 Update UI controls when the command is running.
 */
-(void) updateUIforCommandRunning;

/**
 Update UI controls when command succeeds.
 */
-(void) updateUIforCommandSuccess;

/**
 Update UI controls when command errors for whatever reason.
 */
-(void) updateUIforCommandError;

/**
 Update UI for changes to the network status.
 */
-(void) updateUIforNetworkStatus:(AFNetworkReachabilityStatus)status;

/**
 Update UI for network problems.
 */
-(void) updateUIforNetworkProblem;


@end
