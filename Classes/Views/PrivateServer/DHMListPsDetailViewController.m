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

#import "DHMListPsDetailViewController.h"
#import "DHMController.h"
#import "DHMApi.h"
#import "DHMRebootPsDataItem.h"

@interface DHMListPsDetailViewController ()

@property (nonatomic, weak) DHMListPsDataItem* data;

@end

@implementation DHMListPsDetailViewController

-(DHMBaseCommand*) command
{
    // TODO : _mCommand should be overwritten based upon the button selected
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_PS_REBOOT];
    
    return _mCommand;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AFNetworkReachabilityStatus start = [RKObjectManager sharedManager].HTTPClient.networkReachabilityStatus;
    [self updateUIforNetworkStatus:start];
    
    // Previous check is for immediate update - the following block is for *changes* to that status
    [[RKObjectManager sharedManager].HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         [self updateUIforNetworkStatus:status];
     }];
    
    // Normally would call executeCommand but this is a "detail" controller with (potentially) more than one menu button
    
    [self updateUI];
}

-(void)setServer:(DHMListPsDataItem *)server
{
    NSAssert(server, @"DHMListPsDataItem cannot be nil");
    
    if(server)
        self.data = server;
}

-(void) updateUI
{
    if(self.data)
    {
        self.nameLabel.text = self.data.name;
        self.statusLabel.text = self.data.status;
        self.typeLabel.text = self.data.type;
        NSNumber* bytes = [NSNumber numberWithDouble:(self.data.memoryMb.doubleValue * 1000.0 * 1000.0)];
        self.memoryLabel.text = [DHMController convertBytesToReadableValue:bytes];
        self.startDateLabel.text = self.data.startDate;
        self.ipLabel.text = self.data.ip;
        
        // Enable or disable the "Reboot" button based upon current API key capabilities
        DHMController* ctl = [DHMController sharedInstance];
        DHMApiKeyModel *key = [ctl keyModelWithKeyString:[DHMApi sharedInstance].selectedKey];
        self.rebootButton.enabled = [key hasCommand:DHM_PS_REBOOT];
    }
}

#pragma mark - Table Protocols

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row > 0);
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return (action == @selector(copy:));
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	if (action == @selector(copy:))
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
		[UIPasteboard generalPasteboard].string = cell.detailTextLabel.text;
	}
}

#pragma mark Command Message and Properties

- (IBAction)rebootButtonPressed:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Reboot Server", @"Modal dialog title for rebooting server")
                                                                   message:NSLocalizedString(@"Send the command to reboot the server?", @"Reboot question")
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* rebootAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Reboot", "Reboot Confirmation")
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * action) {
                                                            [self executeCommand];
                                                        }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel the action")
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
    
    [alert addAction:rebootAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) executeCommand
{    
    if(self.command != nil)
    {
        //RKObjectManager* objectManager = [RKObjectManager sharedManager];
        DHMApi* api = [DHMApi sharedInstance];
        
        RKResponseDescriptor* response = [DHMRebootPsDataItem responseDescriptorForREST];
        
        // Set the parameter or return fast on failure - possible the viewcontroller is not in sync with API library
        if([self.command.acceptableParameters containsObject:@"ps"])
        {
            [self.command setParameterKey:@"ps" withValue:self.data.name];
        }
        else
        {
            [self updateUIforCommandError];
            return;
        }
        
        NSURLRequest* req = [api buildRequestWithCommand:self.command];
        
        
        RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
        
        [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            id queryResult = [mappingResult firstObject];
            DHMRebootPsDataItem* first = ((DHMRebootPsDataItem*)queryResult);
            
            if([DHMBaseData isSuccess:first])
            {
                [self updateUIforCommandSuccess];
            }
            else
            {
                [self updateUIforCommandError];
            }
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            [[DHMController sharedInstance] reportError:error withOp:operation];
        }];
        
        [self updateUIforCommandRunning];
        [op start];
    }
}


#pragma mark UI Updates For Validation

-(void) updateUIforCommandRunning
{
    [DHMController statusShow:_mCommand.runningText forCommand:_mCommand.command icon:kReportRunningStatus];
    self.rebootButton.enabled = NO;
}

-(void) updateUIforCommandSuccess
{
    [DHMController statusShow:NSLocalizedString(@"Server scheduled for reboot", @"Server is scheduled for reboot") forCommand:_mCommand.command icon:kReportGoodStatus];
    [DHMController statusDismissForAction:_mCommand.command];
    [[DHMController sharedInstance] addToHistory:[DHMApi sharedInstance].selectedKey command:_mCommand.command];
    self.rebootButton.enabled = YES;
}

-(void) updateUIforCommandError
{
    // TODO : Display something with context; sub-classes should override.
    [DHMController statusShow:NSLocalizedString(@"Command failed", @"Pop-up message that the command failed") forCommand:_mCommand.command icon:kReportBadStatus];
    self.rebootButton.enabled = YES;
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
        self.rebootButton.enabled = YES;
    }
}

-(void) updateUIforNetworkProblem
{
    [[DHMController sharedInstance] reportNetworkError];
    self.rebootButton.enabled = NO;
}


@end
