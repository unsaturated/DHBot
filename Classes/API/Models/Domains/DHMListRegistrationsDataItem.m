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

#import "DHMListRegistrationsDataItem.h"
#import "DHMErrorData.h"

@implementation DHMListRegistrationsDataItem

+(RKObjectMapping*) objectMappingForREST
{
    // All object mappings should include an error mapping
    RKObjectMapping *errorMapping = [DHMErrorData objectMappingForREST];
    
    // Top level mapping for a valid item
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DHMListRegistrationsDataItem class]];
    
    // The data property within the valid item
    RKObjectMapping *dataMapping = [RKObjectMapping mappingForClass:[DHMListRegistrationsDataItem class]];
    
    // From service        : Property on class
    // @IncomingIdentifier : @LocalIdentifier
    [dataMapping addAttributeMappingsFromDictionary:@{
                                                      @"account_id": @"accountId",
                                                      @"domain": @"domain",
                                                      @"expires": @"expiresDate",
                                                      @"created": @"createdDate",
                                                      @"modified": @"modifiedDate",
                                                      @"autorenew": @"autorenew",
                                                      @"locked": @"locked",
                                                      @"expired": @"expired",
                                                      @"ns1": @"nameServer1",
                                                      @"ns2": @"nameServer2",
                                                      @"ns3": @"nameServer3",
                                                      @"ns4": @"nameServer4",
                                                      @"registrant": @"registrant",
                                                      @"registrant_org": @"registrantOrganization",
                                                      @"registrant_street1": @"registrantStreet1",
                                                      @"registrant_street2": @"registrantStreet2",
                                                      @"registrant_city": @"registrantCity",
                                                      @"registrant_state": @"registrantState",
                                                      @"registrant_zip": @"registrantZip",
                                                      @"registrant_country": @"registrantCountry",
                                                      @"registrant_phone": @"registrantPhone",
                                                      @"registrant_fax": @"registrantFax",
                                                      @"registrant_email": @"registrantEmail",
                                                      @"tech": @"technical",
                                                      @"tech_org": @"technicalOrganization",
                                                      @"tech_street1": @"technicalStreet1",
                                                      @"tech_street2": @"technicalStreet2",
                                                      @"tech_city": @"technicalCity",
                                                      @"tech_state": @"technicalState",
                                                      @"tech_zip": @"technicalZip",
                                                      @"tech_country": @"technicalCountry",
                                                      @"tech_phone": @"technicalPhone",
                                                      @"tech_fax": @"technicalFax",
                                                      @"tech_email": @"technicalEmail",
                                                      @"billing": @"billing",
                                                      @"billing_org": @"billingOrganization",
                                                      @"billing_street1": @"billingStreet1",
                                                      @"billing_street2": @"billingStreet2",
                                                      @"billing_city": @"billingCity",
                                                      @"billing_state": @"billingState",
                                                      @"billing_zip": @"billingZip",
                                                      @"billing_country": @"billingCountry",
                                                      @"billing_phone": @"billingPhone",
                                                      @"billing_fax": @"billingFax",
                                                      @"billing_email": @"billingEmail",
                                                      @"admin": @"admin",
                                                      @"admin_org": @"adminOrganization",
                                                      @"admin_street1": @"adminStreet1",
                                                      @"admin_street2": @"adminStreet2",
                                                      @"admin_city": @"adminCity",
                                                      @"admin_state": @"adminState",
                                                      @"admin_zip": @"adminZip",
                                                      @"admin_country": @"adminCountry",
                                                      @"admin_phone": @"adminPhone",
                                                      @"admin_fax": @"adminFax",
                                                      @"admin_email": @"adminEmail",
                                                      }];
    
    [mapping addAttributeMappingsFromArray:@[@"result", @"reason"]];
    
    // Add the data mapping explicitly to the "data" path
    [mapping addRelationshipMappingWithSourceKeyPath:@"data" mapping:dataMapping];
    
    // Create a dynamic mapping so mapping accommodates error conditions
    RKDynamicMapping *dynMapping = [RKDynamicMapping new];
    [dynMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"result" expectedValue:@"success" objectMapping:mapping]];
    [dynMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"result" expectedValue:@"error" objectMapping:errorMapping]];
    
    return (RKObjectMapping*)dynMapping;
}

+(RKResponseDescriptor*) responseDescriptorForREST
{
    RKObjectMapping *mapping = [DHMListRegistrationsDataItem objectMappingForREST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

#pragma mark - Properties
@synthesize accountId;
@synthesize domain;
@synthesize expiresDate;
@synthesize createdDate;
@synthesize modifiedDate;
@synthesize autorenew;
@synthesize locked;
@synthesize expired;

#pragma mark - Name Servers
@synthesize nameServer1;
@synthesize nameServer2;
@synthesize nameServer3;
@synthesize nameServer4;

#pragma mark - Registrant Contact
@synthesize registrant;
@synthesize registrantOrganization;
@synthesize registrantStreet1;
@synthesize registrantStreet2;
@synthesize registrantCity;
@synthesize registrantState;
@synthesize registrantZip;
@synthesize registrantCountry;
@synthesize registrantPhone;
@synthesize registrantFax;
@synthesize registrantEmail;

#pragma mark - Technical Contact
@synthesize technical;
@synthesize technicalOrganization;
@synthesize technicalStreet1;
@synthesize technicalStreet2;
@synthesize technicalCity;
@synthesize technicalState;
@synthesize technicalZip;
@synthesize technicalCountry;
@synthesize technicalPhone;
@synthesize technicalFax;
@synthesize technicalEmail;

#pragma mark - Billing Contact
@synthesize billing;
@synthesize billingOrganization;
@synthesize billingStreet1;
@synthesize billingStreet2;
@synthesize billingCity;
@synthesize billingState;
@synthesize billingZip;
@synthesize billingCountry;
@synthesize billingPhone;
@synthesize billingFax;
@synthesize billingEmail;

#pragma mark - Admin Contact
@synthesize admin;
@synthesize adminOrganization;
@synthesize adminStreet1;
@synthesize adminStreet2;
@synthesize adminCity;
@synthesize adminState;
@synthesize adminZip;
@synthesize adminCountry;
@synthesize adminPhone;
@synthesize adminFax;
@synthesize adminEmail;

@end
