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

#import "DHMUserDetailViewController.h"

@interface DHMUserDetailViewController ()

@property (nonatomic, weak) DHMListUserDataItem* data;

@end

@implementation DHMUserDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUI];
}

-(void) setUser:(DHMListUserDataItem *)data
{
    NSAssert(data, @"DHMListuserDataItem cannot be nil");
    
    if(data)
        self.data = data;
}

-(void) updateUI
{
    if(self.data)
    {
        self.accountIdLabel.text = [self.data.accountID stringValue];
        self.tagLabel.text = self.data.gecos;
        self.usernameLabel.text = self.data.user;
        self.typeLabel.text = self.data.type;
        self.shellLabel.text = self.data.shell;
        self.diskLabel.text = [self.data diskUsedMBWithQuota:YES];
    }
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
		[UIPasteboard generalPasteboard].string = cell.detailTextLabel.text;
	}
}

@end
