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

#import "DHMListRegistrationsDetailViewController.h"

@interface DHMListRegistrationsDetailViewController ()

@property (nonatomic, weak) DHMListRegistrationsDataItem* data;

@end

@implementation DHMListRegistrationsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUI];
}

-(void)setRegistration:(DHMListRegistrationsDataItem *)registration
{
    NSAssert(registration, @"DHMListRegistrationsDataItem cannot be nil");
    
    if(registration)
    {
        self.data = registration;
    }
}

-(void) updateUI
{
    if(self.data)
    {
        self.accountIdLabel.text = self.data.accountId.stringValue;
        self.domainLabel.text = self.data.domain.absoluteString;
        self.expiresDateLabel.text = [NSString stringWithFormat:@"%@", self.data.expiresDate];
        self.createdDateLabel.text = [NSString stringWithFormat:@"%@", self.data.createdDate];
        self.modifiedDateLabel.text = [NSString stringWithFormat:@"%@", self.data.modifiedDate];
        self.autorenewLabel.text = self.data.autorenew.stringValue;
        self.lockedLabel.text = self.data.locked.stringValue;
        self.expiredLabel.text = self.data.expired.stringValue;
        
        self.nameServer1Label.text = self.data.nameServer1;
        self.nameServer2Label.text = self.data.nameServer2;
        self.nameServer3Label.text = self.data.nameServer3;
        self.nameServer4Label.text = self.data.nameServer4;
        
        self.registrantLabel.text = self.data.registrant;
        self.registrantOrganizationLabel.text = self.data.registrantOrganization;
        self.registrantStreet1Label.text = self.data.registrantStreet1;
        self.registrantStreet2Label.text = self.data.registrantStreet2;
        self.registrantCityLabel.text = self.data.registrantCity;
        self.registrantStateLabel.text = self.data.registrantState;
        self.registrantZipLabel.text = self.data.registrantZip;
        self.registrantCountryLabel.text = self.data.registrantCountry;
        self.registrantPhoneLabel.text = self.data.registrantPhone;
        self.registrantFaxLabel.text = self.data.registrantFax;
        self.registrantEmailLabel.text = self.data.registrantEmail;
        
        self.technicalLabel.text = self.data.technical;
        self.technicalOrganizationLabel.text = self.data.technicalOrganization;
        self.technicalStreet1Label.text = self.data.technicalStreet1;
        self.technicalStreet2Label.text = self.data.technicalStreet2;
        self.technicalCityLabel.text = self.data.technicalCity;
        self.technicalStateLabel.text = self.data.technicalState;
        self.technicalZipLabel.text = self.data.technicalZip;
        self.technicalCountryLabel.text = self.data.technicalCountry;
        self.technicalPhoneLabel.text = self.data.technicalPhone;
        self.technicalFaxLabel.text = self.data.technicalFax;
        self.technicalEmailLabel.text = self.data.technicalEmail;
        
        self.billingLabel.text = self.data.billing;
        self.billingOrganizationLabel.text = self.data.billingOrganization;
        self.billingStreet1Label.text = self.data.billingStreet1;
        self.billingStreet2Label.text = self.data.billingStreet2;
        self.billingCityLabel.text = self.data.billingCity;
        self.billingStateLabel.text = self.data.billingState;
        self.billingZipLabel.text = self.data.billingZip;
        self.billingCountryLabel.text = self.data.billingCountry;
        self.billingPhoneLabel.text = self.data.billingPhone;
        self.billingFaxLabel.text = self.data.billingFax;
        self.billingEmailLabel.text = self.data.billingEmail;
        
        self.adminLabel.text = self.data.admin;
        self.adminOrganizationLabel.text = self.data.adminOrganization;
        self.adminStreet1Label.text = self.data.adminStreet1;
        self.adminStreet2Label.text = self.data.adminStreet2;
        self.adminCityLabel.text = self.data.adminCity;
        self.adminStateLabel.text = self.data.adminState;
        self.adminZipLabel.text = self.data.adminZip;
        self.adminCountryLabel.text = self.data.adminCountry;
        self.adminPhoneLabel.text = self.data.adminPhone;
        self.adminFaxLabel.text = self.data.adminFax;
        self.adminEmailLabel.text = self.data.adminEmail;
    }
}


#pragma mark - Table view data source

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
