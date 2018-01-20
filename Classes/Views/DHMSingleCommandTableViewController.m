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

#import "DHMSingleCommandTableViewController.h"
#import "DHMController.h"
#import "DHMApi.h"

@interface DHMSingleCommandTableViewController ()

@end

@implementation DHMSingleCommandTableViewController

#pragma mark Command Message and Properties

@synthesize command = _mCommand;

@synthesize commandResultArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

/**
 Sub-classes should override this method.
 */
-(void) executeCommand
{
}

/**
 Sub-classes should override this method.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [DHMController statusDismissForAction:_mCommand.command];
    [[DHMApi sharedInstance] cancelApiRequests];
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source

/**
 Sub-classes might need to override this method.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Get the result array size or just return zero
    return [self.commandResultArray count];
}

/**
 Sub-classes should override this method.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark UI Updates For Validation

-(void) updateUIforCommandRunning
{
    [DHMController statusShow:_mCommand.runningText forCommand:_mCommand.command icon:kReportRunningStatus];
}

-(void) updateUIforCommandSuccess
{
    [DHMController statusDismissForAction:_mCommand.command];
    [[DHMController sharedInstance] addToHistory:[DHMApi sharedInstance].selectedKey command:_mCommand.command];
    
    if(self.isViewLoaded)
    {
        if(self.commandResultArray)
            [self.tableView reloadData];
    }
}

-(void) updateUIforCommandError
{
    // TODO : Display something with context; sub-classes should override.
    [DHMController statusShow:NSLocalizedString(@"Command failed", @"Pop-up message that the command failed") forCommand:_mCommand.command icon:kReportBadStatus];
}

-(void) updateUIforNetworkStatus:(AFNetworkReachabilityStatus)status
{
    if ( (status == AFNetworkReachabilityStatusNotReachable) || (status == AFNetworkReachabilityStatusUnknown) )
    {
        [self updateUIforNetworkProblem];
    }
    else if( (status == AFNetworkReachabilityStatusReachableViaWiFi) || (status == AFNetworkReachabilityStatusReachableViaWWAN))
    {
        // TODO : This would pop-up when the v-c loaded; it needs to check current status first
        //[ZAActivityBar showSuccessWithStatus:@"Network is back - please refresh" duration:2.0];
    }
}

-(void) updateUIforNetworkProblem
{
    [[DHMController sharedInstance] reportNetworkError];
}

@end
