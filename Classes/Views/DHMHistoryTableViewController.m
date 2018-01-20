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

#import "DHMHistoryTableViewController.h"
#import "DHMController.h"
#import "DHMCommandHistoryModel.h"
#import "DHMApi.h"

@interface DHMHistoryTableViewController ()

/**
 Clear button for removing all history.
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;

@end

@implementation DHMHistoryTableViewController

- (void)viewDidLoad {
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [super viewDidLoad];
    
    self.partialDisplayApiKeys = [DHMController sharedInstance].partialDisplayApiKeys;
    
    if(self.isViewLoaded)
        [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    // Subscribe to command (history) events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCommandToHistory:) name:HISTORY_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearHistory:) name:HISTORY_CLEAR_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUIForSettingsChange) name:NSUserDefaultsDidChangeNotification object:nil];
    
    if(self.isViewLoaded)
        [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated
{
    // Unsubscribe command history events
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HISTORY_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HISTORY_CLEAR_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];;
    
    [super viewWillDisappear:animated];
}

-(void) addCommandToHistory:(NSNotification*)notification
{
    [self.tableView insertRowsAtIndexPaths:@[@0] withRowAnimation:UITableViewRowAnimationTop];
}

-(void) clearHistory:(NSNotification*)notification
{
    [self.tableView reloadData];
}

-(void) updateUIForSettingsChange
{
    self.partialDisplayApiKeys = [DHMController sharedInstance].partialDisplayApiKeys;
    [self.tableView reloadData];
}

- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Clear History", @"Modal dialog title for clearing command history")
                                                                      message:NSLocalizedString(@"Entire command history will be cleared.", @"Clear history desc")
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* clearAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", "OK Confirmation")
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [[DHMController sharedInstance] clearHistory:nil];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel the action")
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
    
    [alert addAction:clearAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DHMController sharedInstance].userCommandHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"commandHistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell properties...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    // Accessibility
    [cell setAccessibilityLabel:cell.textLabel.text];
    [cell setAccessibilityHint:[NSString stringWithFormat:NSLocalizedString(@"Uses the key %@.", @"Specifies which API key is used for accessibility"), cell.detailTextLabel.text]];
    
    return cell;
}

#pragma mark Helpers

-(NSString*) titleForRow:(NSUInteger)row
{
    DHMCommandHistoryModel* api = [[DHMController sharedInstance].userCommandHistory objectAtIndex:row];
    return api.commandName;
}

-(NSString*) subtitleForRow:(NSUInteger)row
{
    DHMCommandHistoryModel* history = [[DHMController sharedInstance].userCommandHistory objectAtIndex:row];

    NSString* apiToDisplay = history.apiKey;
    
    if([DHMController sharedInstance].partialDisplayApiKeys)
    {
        NSString* apiSubstring = [[NSString stringWithString:history.apiKey]
                                  substringWithRange:NSMakeRange(0, PARTIAL_API_CHARS_TO_DISP)];
        
        apiToDisplay = [[NSString stringWithString:apiSubstring]
                        stringByPaddingToLength:DHM_API_KEY_LENGTH
                        withString:PARTIAL_API_CHAR
                        startingAtIndex:0];
    }
    
    NSString* dateToDisplay = [[DHMController sharedInstance].dateFormatter stringFromDate:history.date];
    
    return [NSString stringWithFormat:@"%@ on %@", apiToDisplay, dateToDisplay];
}

@end
