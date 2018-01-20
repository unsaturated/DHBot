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

#import "DHMAvailableApiCommandsViewController.h"
#import "DHMApi.h"
#import "DHMController.h"
#import "DHMCommandTableCell.h"

@interface DHMAvailableApiCommandsViewController ()

@property (nonatomic, strong) NSDictionary* commandDictionary;

@end

@implementation DHMAvailableApiCommandsViewController

@synthesize commandDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the currently selected API key and its allowable commands
    DHMApi* api = [DHMApi sharedInstance];
    DHMApiKeyModel* model = [[DHMController sharedInstance] keyModelWithKeyString:api.selectedKey];
    
    // Get the dictionary of commands
    self.commandDictionary = [[DHMApi sharedInstance] dictionaryForCommandStrings:model.allowableCommands];
    
    [self.tableView registerClass:[DHMCommandTableCell class] forCellReuseIdentifier:@"apiCell"];
    
}

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
    static NSString *CellIdentifier = @"apiCell";
    DHMCommandTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell by getting the section (category) and item (array index within category)
    DHMBaseCommand* cmd = [self commandAtIndexPath:indexPath];
    
    [cell setupCellWithCommand:cmd accessory:UITableViewCellAccessoryNone];
    
    return cell;
}

@end
