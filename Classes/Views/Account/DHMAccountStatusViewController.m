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

#import "DHMAccountStatusViewController.h"
#import "DHMController.h"
#import "DHMApi.h"
#import "DHMAccountStatusDataItem.h"

@interface DHMAccountStatusViewController ()
{
    NSNumberFormatter* formatDollars;
    NSNumberFormatter* formatValues;
}
@end

@implementation DHMAccountStatusViewController

/**
 Override default initialization so local formatters can be instantiated.
 @param aDecoder decoder to use
 @return new object
 */
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        // Custom initialization
        formatDollars = [NSNumberFormatter new];
        [formatDollars setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatDollars setCurrencyCode:@"USD"];
        [formatDollars setMinimumSignificantDigits:[@2 unsignedIntegerValue]];
        [formatDollars setMaximumSignificantDigits:[@2 unsignedIntegerValue]];
        
        formatValues = [NSNumberFormatter new];
        [formatValues setNumberStyle:NSNumberFormatterNoStyle];
    }
    return self;
}

#pragma mark Command Message and Properties

-(DHMBaseCommand*) command
{
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_ACCT_GET_STATUS];
    
    return _mCommand;
}

- (void)executeCommand
{
    if(self.command != nil)
    {
        //RKObjectManager* objectManager = [RKObjectManager sharedManager];
        DHMApi* api = [DHMApi sharedInstance];
        
        RKResponseDescriptor* response = [DHMAccountStatusDataItem responseDescriptorForREST];
        NSURLRequest* req = [api buildRequestWithCommand:self.command];
        RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
        
        [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            id queryResult = [mappingResult firstObject];
            DHMAccountStatusDataItem* first = ((DHMAccountStatusDataItem*)queryResult);
            
            if([DHMBaseData isSuccess:first])
            {
                // Success, so get the "actual" data embedded within the first result
                NSArray* apiDataArray = ((DHMAccountStatusDataItem*)queryResult).data;
                
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
    
    // Setup title
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
    static NSString *CellIdentifier = @"statusUsageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if([self.commandResultArray count] > 0)
    {
        // Configure the cell by getting the section (category) and item (array index within category)
        DHMAccountStatusDataItem* item = [self.commandResultArray objectAtIndex:indexPath.row];
        
        NSArray* data = [self formatDataItem:item];
        
        [cell.textLabel setText:data[0]];
        [cell.detailTextLabel setText:data[1]];
    }
    return cell;
}

/**
 Formats a status data item according to some heuristics.
 @param item data to be formatted
 @return array with two strings - first is the key, second is the value
 */
-(NSArray*) formatDataItem:(DHMAccountStatusDataItem*)item
{
    NSParameterAssert(item != nil);
    NSString* updatedKey = nil;
    NSString* updatedValue = nil;
    
    // Handle key then value based upon that key
    if([item.key isEqualToString:@"balance"])
    {
        updatedKey = NSLocalizedString(@"Balance", @"Balance of money remaining on an account");
        updatedValue = [formatDollars stringFromNumber:[formatValues numberFromString:item.value]];
        return @[updatedKey, updatedValue];
    }
    if([item.key isEqualToString:@"delinquent"])
    {
        updatedKey = NSLocalizedString(@"Delinquent", @"Balance of delinquent/late money owed on an account");
        updatedValue = [formatDollars stringFromNumber:[formatValues numberFromString:item.value]];
        return @[updatedKey, updatedValue];
    }
    if([item.key isEqualToString:@"delinquent_date"])
    {
        updatedKey = NSLocalizedString(@"Delinquent Date", @"Delinquent date");
        // TODO : Dates should be handled by RestKit
        return @[updatedKey, item.value];
    }
    if([item.key isEqualToString:@"due"])
    {
        updatedKey = NSLocalizedString(@"Amount Due", @"Amount of money due or owed on an account");
        updatedValue = [formatDollars stringFromNumber:[formatValues numberFromString:item.value]];
        return @[updatedKey, updatedValue];
    }
    if([item.key isEqualToString:@"lastrebill_date"])
    {
        updatedKey = NSLocalizedString(@"Last Rebill Date", @"Last date the account was re-billed");
        // TODO : Dates should be handled by RestKit
        return @[updatedKey, item.value];
    }
    if([item.key isEqualToString:@"nextrebill_date"])
    {
        updatedKey = NSLocalizedString(@"Next Rebill Date", @"Next date the account will be re-billed");
        // TODO : Dates should be handled by RestKit
        return @[updatedKey, item.value];
    }
    if([item.key isEqualToString:@"past_due"])
    {
        updatedKey = NSLocalizedString(@"Amount Past Due", @"Amount of money that is past due on the account");
        updatedValue = [formatDollars stringFromNumber:[formatValues numberFromString:item.value]];
        return @[updatedKey, updatedValue];
    }
    if([item.key isEqualToString:@"pastdue_date"])
    {
        updatedKey = NSLocalizedString(@"Past Due Date", @"Date when money is overdue");
        // TODO : Dates should be handled by RestKit
        return @[updatedKey, item.value];
    }
    if([item.key isEqualToString:@"today"])
    {
        updatedKey = NSLocalizedString(@"Today (@ Dreamhost)", @"Current day/today at Dreamhost");
        // TODO : Dates should be handled by RestKit
        return @[updatedKey, item.value];
    }
    
    // Fallback and return the same values
    return @[item.key, item.value];
}

@end
