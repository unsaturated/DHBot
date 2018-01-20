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

#import "DHMAccessibleCommandsTableViewController.h"
#import "DHMApi.h"
#import "DHMCommandTableCell.h"
#import "DHMController.h"

@interface DHMAccessibleCommandsTableViewController ()

@property (nonatomic, strong) NSDictionary* commandDictionary;

@end

@implementation DHMAccessibleCommandsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Subscribe to changes in point status
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCellsWithNewPointAvailability) name:PTS_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCellsWithNewPointAvailability) name:PTS_REMOVED_NOTIFICATION object:nil];
    //[self updateCellsWithNewPointAvailability];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Unsubscribe from changes to point status
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_REMOVED_NOTIFICATION object:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[DHMCommandTableCell class] forCellReuseIdentifier:@"CommandCell"];
}

-(void) setApiKey:(DHMApiKeyModel *)key
{
    // Keep reference to the model in the property
    self.apiKeyModel = key;
    
    // Set the title so user can remember which API key they're using
    self.title = key.description;
    
    // Parse the API model into the pieces that matter for this viewcontroller
    
    // Get the dictionary of commands
    self.commandDictionary = [[DHMApi sharedInstance] dictionaryForCommandStrings:key.allowableCommands filterInteractive:YES];
}

/**
 Update cells based upon the currently available points.
 */
-(void) updateCellsWithNewPointAvailability
{
    [self.tableView reloadData];
    
//    //if(self.isViewLoaded)
//    //{
//        NSMutableArray* arrayOfRowsToUpdate = [NSMutableArray array];
//        NSUInteger pts = [DHMController sharedInstance].pointsAvailable;
//        
//        for (int section = 0; section < [self tableView].numberOfSections; section++)
//        {
//            for (int row = 0; row < [[self tableView] numberOfRowsInSection:section]; row++)
//            {
//                NSIndexPath *cellPath = [NSIndexPath indexPathForRow:row inSection:section];
//                UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:cellPath];
//                if([cell isKindOfClass:[DHMCommandTableCell class]])
//                {
//                    DHMCommandTableCell* cmdCell = (DHMCommandTableCell*)cell;
//                    NSIndexPath* path = [[self tableView] indexPathForCell:cmdCell];
//                    
//                    //if([cmdCell updateWithNewAvailablePoints:[DHMController sharedInstance].pointsAvailable])
//                    //{
//                    //    NSIndexPath* path = [[self tableView] indexPathForCell:cmdCell];
//                    //    [arrayOfRowsToUpdate addObject:path];
//                    //}
//                    // Get currently available points because notifications only handle *changes*, not initial possibilities
//                    
//                    
//                    if(cmdCell.command.pointCost <= pts)
//                    {
//                        // Points cost is less than equal to available points - Enable :-)
//                        [arrayOfRowsToUpdate addObject:path];
//                    }
//                    else if(cmdCell.command.pointCost > pts)
//                    {
//                        // Point cost is greater than the available points - Disable :-(
//                        [arrayOfRowsToUpdate addObject:path];
//                    }
//                }
//            }
//        }
//        [[self tableView] reloadRowsAtIndexPaths:arrayOfRowsToUpdate withRowAnimation:UITableViewRowAnimationNone];
//    //}
}

@synthesize apiKeyModel;

@synthesize commandDictionary;

-(DHMBaseCommand*) commandAtIndexPath:(NSIndexPath*)path
{
    NSString* keyName = [self.commandDictionary.allKeys objectAtIndex:path.section];
    NSArray* aryAtKey = [self.commandDictionary objectForKey:keyName];
    DHMBaseCommand* cmd = [aryAtKey objectAtIndex:path.item];
    
    return cmd;
}

#pragma mark - Table view data source

/**
 * Returns the number of API categories applicable to the command.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.commandDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* keyName = [self.commandDictionary.allKeys objectAtIndex:section];
    NSArray* aryAtKey = [self.commandDictionary objectForKey:keyName];
    return aryAtKey.count;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.commandDictionary.allKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommandCell";
    DHMCommandTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell by getting the section (category) and item (array index within category)
    DHMBaseCommand* cmd = [self commandAtIndexPath:indexPath];
    
    [cell setupCellWithCommand:cmd];
    
    return cell;
}

#pragma mark - Table view delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the command name associated with the NSIndexPath
    NSString* cmdName = [self commandAtIndexPath:indexPath].command;
    
    id cellSender = [tableView cellForRowAtIndexPath:indexPath];
    
    [[DHMController sharedInstance] segueFromApiCommand:cmdName toViewController:self withSender:cellSender];
}

@end
