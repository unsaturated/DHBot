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
 Base view-controller class for a single command that returns a single result.
 Command returning a collection should use DHMSingleCommandTableViewController.
 @see DHMSingleCommandTableViewController
 */
@interface DHMSingleCommandViewController : UIViewController
{
    @protected
    DHMBaseCommand* _mCommand;
}

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
