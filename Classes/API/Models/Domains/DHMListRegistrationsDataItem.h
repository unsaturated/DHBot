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

#import "DHMBaseData.h"

/** 
 Data item for a single domain registration record.
 */
@interface DHMListRegistrationsDataItem : DHMBaseData

/**
 Account number as a numeric value.
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 Name of top-level domain name that's registered.
 */
@property (nonatomic, copy) NSURL* domain;

/**
 Expiration of registration.
 */
@property (nonatomic, copy) NSDate* expiresDate;

/**
 Registration creation date.
 */
@property (nonatomic, copy) NSDate* createdDate;

/**
 Modification date.
 */
@property (nonatomic, copy) NSDate* modifiedDate;

/**
 Whether the domain auto-renews.
 */
@property (nonatomic, copy) NSNumber* autorenew;

/**
 Whether the domain is locked.
 */
@property (nonatomic, copy) NSNumber* locked;

/**
 Whether the domain registration has expired.
 */
@property (nonatomic, copy) NSNumber* expired;

/**
 Name server 1.
 */
@property (nonatomic, copy) NSString* nameServer1;

/**
 Name server 2.
 */
@property (nonatomic, copy) NSString* nameServer2;

/**
 Name server 3.
 */
@property (nonatomic, copy) NSString* nameServer3;

/**
 Name server 4.
 */
@property (nonatomic, copy) NSString* nameServer4;

/**
 Registrant name.
 */
@property (nonatomic, copy) NSString* registrant;

/**
 Registrant organization.
 */
@property (nonatomic, copy) NSString* registrantOrganization;

/**
 Registrant street 1.
 */
@property (nonatomic, copy) NSString* registrantStreet1;

/**
 Registrant street 2.
 */
@property (nonatomic, copy) NSString* registrantStreet2;

/**
 Registrant city.
 */
@property (nonatomic, copy) NSString* registrantCity;

/**
 Registrant state.
 */
@property (nonatomic, copy) NSString* registrantState;

/**
 Registrant ZIP code.
 */
@property (nonatomic, copy) NSString* registrantZip;

/**
 Registrant country.
 */
@property (nonatomic, copy) NSString* registrantCountry;

/**
 Registrant phone number.
 */
@property (nonatomic, copy) NSString* registrantPhone;

/**
 Registrant fax number.
 */
@property (nonatomic, copy) NSString* registrantFax;

/**
 Registrant e-mail address.
 */
@property (nonatomic, copy) NSString* registrantEmail;

/**
 Technical name.
 */
@property (nonatomic, copy) NSString* technical;

/**
 Technical organization.
 */
@property (nonatomic, copy) NSString* technicalOrganization;

/**
 Technical street 1.
 */
@property (nonatomic, copy) NSString* technicalStreet1;

/**
 Technical street 2.
 */
@property (nonatomic, copy) NSString* technicalStreet2;

/**
 Technical city.
 */
@property (nonatomic, copy) NSString* technicalCity;

/**
 Technical state.
 */
@property (nonatomic, copy) NSString* technicalState;

/**
 Technical ZIP code.
 */
@property (nonatomic, copy) NSString* technicalZip;

/**
 Technical country.
 */
@property (nonatomic, copy) NSString* technicalCountry;

/**
 Technical phone number.
 */
@property (nonatomic, copy) NSString* technicalPhone;

/**
 Technical fax number.
 */
@property (nonatomic, copy) NSString* technicalFax;

/**
 Technical e-mail address.
 */
@property (nonatomic, copy) NSString* technicalEmail;

/**
 Billing name.
 */
@property (nonatomic, copy) NSString* billing;

/**
 Billing organization.
 */
@property (nonatomic, copy) NSString* billingOrganization;

/**
 Billing street 1.
 */
@property (nonatomic, copy) NSString* billingStreet1;

/**
 Billing street 2.
 */
@property (nonatomic, copy) NSString* billingStreet2;

/**
 Billing city.
 */
@property (nonatomic, copy) NSString* billingCity;

/**
 Billing state.
 */
@property (nonatomic, copy) NSString* billingState;

/**
 Billing ZIP code.
 */
@property (nonatomic, copy) NSString* billingZip;

/**
 Billing country.
 */
@property (nonatomic, copy) NSString* billingCountry;

/**
 Billing phone number.
 */
@property (nonatomic, copy) NSString* billingPhone;

/**
 Billing fax number.
 */
@property (nonatomic, copy) NSString* billingFax;

/**
 Billing e-mail address.
 */
@property (nonatomic, copy) NSString* billingEmail;

/**
 Administrative name.
 */
@property (nonatomic, copy) NSString* admin;

/**
 Administrative organization.
 */
@property (nonatomic, copy) NSString* adminOrganization;

/**
 Administrative street 1.
 */
@property (nonatomic, copy) NSString* adminStreet1;

/**
 Administrative street 2.
 */
@property (nonatomic, copy) NSString* adminStreet2;

/**
 Administrative city.
 */
@property (nonatomic, copy) NSString* adminCity;

/**
 Administrative state.
 */
@property (nonatomic, copy) NSString* adminState;

/**
 Administrative ZIP code.
 */
@property (nonatomic, copy) NSString* adminZip;

/**
 Administrative country.
 */
@property (nonatomic, copy) NSString* adminCountry;

/**
 Administrative phone number.
 */
@property (nonatomic, copy) NSString* adminPhone;

/**
 Administrative fax number.
 */
@property (nonatomic, copy) NSString* adminFax;

/**
 Administrative e-mail address.
 */
@property (nonatomic, copy) NSString* adminEmail;

@end
