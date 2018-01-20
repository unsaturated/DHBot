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

#import "DHMListJabberUsersViewController.h"
#import "DHMApi.h"
#import "DHMController.h"
#import "DHMListJabberUsersDataItem.h"

@interface DHMListJabberUsersViewController ()

@end

@implementation DHMListJabberUsersViewController

#pragma mark Command Message and Properties

-(DHMBaseCommand*) command
{
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_JAB_LIST_USERS_NOPASS];
    
    return _mCommand;
}

- (void)executeCommand
{    
    if(self.command != nil)
    {
        //RKObjectManager* objectManager = [RKObjectManager sharedManager];
        DHMApi* api = [DHMApi sharedInstance];
        
        RKResponseDescriptor* response = [DHMListJabberUsersDataItem responseDescriptorForREST];
        NSURLRequest* req = [api buildRequestWithCommand:self.command];
        RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
        
        [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            id queryResult = [mappingResult firstObject];
            DHMListJabberUsersDataItem* first = ((DHMListJabberUsersDataItem*)queryResult);
            
            if([DHMBaseData isSuccess:first])
            {
                // Success, so get the "actual" data embedded within the first result
                NSArray* apiDataArray = ((DHMListJabberUsersDataItem*)queryResult).data;
                
                // Assign to result array
                self.commandResultArray = [NSMutableArray arrayWithArray:apiDataArray];
                
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

#pragma mark Standard ViewController Messages

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the title so user can remember which command they're using
    self.title = self.command.commandName;
    
    AFNetworkReachabilityStatus start = [RKObjectManager sharedManager].HTTPClient.networkReachabilityStatus;
    [self updateUIforNetworkStatus:start];
    
    // Previous check is for immediate update - the following block is for *changes* to that status
    [[RKObjectManager sharedManager].HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         [self updateUIforNetworkStatus:status];
     }];
    
    [self executeCommand];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jabberNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if([self.commandResultArray count] > 0)
    {
        // Configure the cell by getting the section (category) and item (array index within category)
        DHMListJabberUsersDataItem* item = [self.commandResultArray objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:item.username];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ | %@", item.status, item.domain]];
    }
    return cell;
}

@end
