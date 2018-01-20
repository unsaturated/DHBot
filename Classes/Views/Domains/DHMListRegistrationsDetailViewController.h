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

#import <UIKit/UIKit.h>
#import "DHMListRegistrationsDataItem.h"

@interface DHMListRegistrationsDetailViewController : UITableViewController

/**
 Sets the domain registration details to use for display.
 @param data for registration
 */
-(void) setRegistration:(DHMListRegistrationsDataItem*)registration;

#pragma mark - Registration Bindings
@property (weak, nonatomic) IBOutlet UILabel *accountIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *domainLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiresDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modifiedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *autorenewLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockedLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiredLabel;

#pragma mark - Name Server Bindings
@property (weak, nonatomic) IBOutlet UILabel *nameServer1Label;
@property (weak, nonatomic) IBOutlet UILabel *nameServer2Label;
@property (weak, nonatomic) IBOutlet UILabel *nameServer3Label;
@property (weak, nonatomic) IBOutlet UILabel *nameServer4Label;

#pragma mark - Registrant Contact Bindings
@property (weak, nonatomic) IBOutlet UILabel *registrantLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantStreet1Label;
@property (weak, nonatomic) IBOutlet UILabel *registrantStreet2Label;
@property (weak, nonatomic) IBOutlet UILabel *registrantCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantFaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrantEmailLabel;

#pragma mark - Technical Contact Bindings
@property (weak, nonatomic) IBOutlet UILabel *technicalLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalStreet1Label;
@property (weak, nonatomic) IBOutlet UILabel *technicalStreet2Label;
@property (weak, nonatomic) IBOutlet UILabel *technicalCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalFaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicalEmailLabel;

#pragma mark - Billing Contact Bindings
@property (weak, nonatomic) IBOutlet UILabel *billingLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingStreet1Label;
@property (weak, nonatomic) IBOutlet UILabel *billingStreet2Label;
@property (weak, nonatomic) IBOutlet UILabel *billingCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingFaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *billingEmailLabel;

#pragma mark - Admin Contact Bindings
@property (weak, nonatomic) IBOutlet UILabel *adminLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminStreet1Label;
@property (weak, nonatomic) IBOutlet UILabel *adminStreet2Label;
@property (weak, nonatomic) IBOutlet UILabel *adminCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminFaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminEmailLabel;

@end
