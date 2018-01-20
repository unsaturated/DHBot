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

#import "DHMKeyListTableViewController.h"
#import "DHMController.h"
#import "DHMApiKeyModel.h"
#import "DHMApi.h"

@interface DHMKeyListTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *emptyPrompt;

@end

@implementation DHMKeyListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setKeys:(NSMutableArray *)keys
{
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    _keys = keys;
    if(self.isViewLoaded)
        [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    DHMController* ctl = [DHMController sharedInstance];
    [self updateUIForKeyCount:[ctl.userApiKeys count]];
    [self setKeys:[DHMController sharedInstance].userApiKeys];
    
    self.partialDisplayApiKeys = [DHMController sharedInstance].partialDisplayApiKeys;
    
    if(self.isViewLoaded)
        [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIForSettingsChange) name:NSUserDefaultsDidChangeNotification
     object:nil];
    
    self.partialDisplayApiKeys = [DHMController sharedInstance].partialDisplayApiKeys;
    
    if(self.isViewLoaded)
        [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];;
    [super viewWillDisappear:animated];
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender
{
    // Create the "add" view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    id obj = [storyboard instantiateViewControllerWithIdentifier:@"AddApiKey"];
    
    // Let the vc know we want a callback - it has to be *this* specific because using the
    // presentingViewController property delegates us to the NavViewController, which does no good
    if([obj conformsToProtocol:@protocol(NewApiKeyGenerator)])
    {
        id<NewApiKeyGenerator> gen = obj;
        gen.apiKeyReceiver = self;
    }
    
    // Just double check to ensure it's actually a UIViewController
    if([obj isKindOfClass:[UIViewController class]])
    {
        UIViewController* viewController = (UIViewController*)obj;
        
        viewController.modalInPopover = YES;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keys count];
}


// Reuses previously created cells to improve efficiency.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"apiKeyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell properties...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    // Accessibility
    [cell setAccessibilityLabel:cell.textLabel.text];
    [cell setAccessibilityHint:[NSString stringWithFormat:NSLocalizedString(@"Uses the key %@.", @"Specifies which API key is used for accessibility"), cell.detailTextLabel.text]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DHMController *ctl = [DHMController sharedInstance];
        
        // Remove the object from the Controller
        [ctl.userApiKeys removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Update stored data
        [DHMApiKeyModel saveApiKeysLocally:[DHMController sharedInstance].userApiKeys];
        
        // Update the friendly notification to add a key        
        [self updateUIForKeyCount:[ctl.userApiKeys count]];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSInteger from = fromIndexPath.row;
    NSInteger to = toIndexPath.row;
    
    DHMController* ctl = [DHMController sharedInstance];
    [ctl.userApiKeys exchangeObjectAtIndex:to withObjectAtIndex:from];
    
    _keys = ctl.userApiKeys;
    
    // Update stored data since sort order changed
    [DHMApiKeyModel saveApiKeysLocally:[DHMController sharedInstance].userApiKeys];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return ([self.keys count] > 1);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}

#pragma mark Helpers

-(NSString*) titleForRow:(NSUInteger)row
{
    DHMApiKeyModel* api = [_keys objectAtIndex:row];
    return api.description;
}

-(NSString*) subtitleForRow:(NSUInteger)row
{
    DHMApiKeyModel* api = [_keys objectAtIndex:row];
    if(self.partialDisplayApiKeys)
    {
        NSString* apiSubstring = [[NSString stringWithString:api.apiKey]
                                  substringWithRange:NSMakeRange(0, PARTIAL_API_CHARS_TO_DISP)];
        
        return [[NSString stringWithString:apiSubstring]
                stringByPaddingToLength:DHM_API_KEY_LENGTH
                withString:PARTIAL_API_CHAR
                startingAtIndex:0];
    }
    else
    {
        return api.apiKey;
    }
}

-(void) updateUIForKeyCount:(UInt16)count
{
    if(count == 0)
    {
        // Clear the scroll since the emptyPrompt is displayed
        self.emptyPrompt.hidden = NO;
        [self.tableView setScrollEnabled:NO];
        self.editing = NO;
        self.navigationItem.leftBarButtonItem = nil;
        //self.navigationItem.hidesBackButton = YES;
    }
    else
    {
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.hidesBackButton = NO;
        self.emptyPrompt.hidden = YES;
        [self.tableView setScrollEnabled:YES];
    }
    
    if(self.isEditing)
    {
        // Editing but there's nothing left so remove the left button
        if(count == 0)
        {
            self.editing = NO;
            self.navigationItem.leftBarButtonItem = nil;
            //self.navigationItem.hidesBackButton = YES;
        }
    }/*
    else
    {
        // Not editing but the left button isn't assigned yet
        if(self.navigationItem.leftBarButtonItem == nil)
        {
            self.navigationItem.leftBarButtonItem = self.editButtonItem;
            self.navigationItem.hidesBackButton = NO;
        }
    }*/
}

#pragma mark Notification Handler for NSUserDefaults

-(void) updateUIForSettingsChange
{
    self.partialDisplayApiKeys = [DHMController sharedInstance].partialDisplayApiKeys;
    [self.tableView reloadData];
}

#pragma mark Segue Preparation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Update the selected API key
    NSIndexPath* ip = [self.tableView indexPathForCell:sender];
    DHMApi* api = [DHMApi sharedInstance];
    DHMApiKeyModel* apiKeyObj = [self.keys objectAtIndex:ip.row];
    api.selectedKey = apiKeyObj.apiKey;
    
    if([segue.identifier isEqualToString:@"segueFromKeyToCommands"])
    {
        if([segue.destinationViewController respondsToSelector:@selector(setApiKey:)])
        {
            [segue.destinationViewController performSelector:@selector(setApiKey:) withObject:[self.keys objectAtIndex:ip.row]];
        }
    }
}

#pragma mark NewApiKeyProtocol

-(void) setupForNewApiKey
{
    DHMController *ctl = [DHMController sharedInstance];
    [self updateUIForKeyCount:[ctl.userApiKeys count]];
    [self setKeys:[DHMController sharedInstance].userApiKeys];
}

@end
