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

#import "DHMListApiKeysViewController.h"
#import "DHMApi.h"
#import "DHMController.h"
#import "DHMApiListKeysDataItem.h"

@interface DHMListApiKeysViewController ()

@end

@implementation DHMListApiKeysViewController

#pragma mark Command Message and Properties

-(DHMBaseCommand*) command
{
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_API_LIST_KEYS];
    
    return _mCommand;
}

-(void)executeCommand
{
    if(self.command != nil)
    {
        //RKObjectManager* objectManager = [RKObjectManager sharedManager];
        DHMApi* api = [DHMApi sharedInstance];
        
        RKResponseDescriptor* response = [DHMApiListKeysDataItem responseDescriptorForREST];
        NSURLRequest* req = [api buildRequestWithCommand:self.command];
        RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
        
        [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            id queryResult = [mappingResult firstObject];
            DHMApiListKeysDataItem* first = ((DHMApiListKeysDataItem*)queryResult);
            
            if([DHMBaseData isSuccess:first])
            {
                // Success, so get the "actual" data embedded within the first result
                NSArray* apiDataArray = ((DHMApiListKeysDataItem*)queryResult).data;
                
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
    static NSString *CellIdentifier = @"listKeyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if([self.commandResultArray count] > 0)
    {
        // Configure the cell by getting the section (category) and item (array index within category)
        DHMApiListKeysDataItem* item = [self.commandResultArray objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:item.key];
        [cell.detailTextLabel setText:item.comment];
    }
    return cell;
}

#pragma mark Context Menu - Cut, Copy, Paste

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
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
		[UIPasteboard generalPasteboard].string = cell.textLabel.text;
	}
}

@end
