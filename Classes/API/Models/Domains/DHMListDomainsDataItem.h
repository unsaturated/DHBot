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
 * Data for a single domain item.
 */
@interface DHMListDomainsDataItem : DHMBaseData

/**
 * Account number as a numeric value.
 * Stored as "account_id"
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 * Full domain name, which could be a sub-domain.
 * Stored as "domain"
 */
@property (nonatomic, copy) NSString* domain;

/**
 * Home domain or machine which hosts the domain.
 * Stored as "home"
 */
@property (nonatomic, copy) NSString* home;

/**
 * http or https.
 * Stored as "type"
 */
@property (nonatomic, copy) NSString* type;

/** 
 * The IP address if unique. This can be null (empty).
 * Stored as "unique_ip"
 */
@property (nonatomic, copy) NSString* uniqueIP;

/**
 * Full, redirect, parked, mirror, cloaked, or google.
 * Stored as "hosting_type"
 */
@property (nonatomic, copy) NSString* hostingType;

/**
 * User of the domain. This can be null (empty).
 * Stored as "user"
 */
@property (nonatomic, copy) NSString* user;

/**
 * Path of the domain. This can be null (empty).
 * Stored as "path"
 */
@property (nonatomic, copy) NSString* path;

/**
 * Full URL address of the domain.
 * Stored as "outside_url"
 */
@property (nonatomic, copy) NSString* outsideURL;

/**
 * Specifies how or whether www is added to domain address.
 * Values: both_work, add_www, or remove_www
 * Stored as "www_or_not"
 */
@property (nonatomic, copy) NSString* wwwSubdomain;

/**
 * The type of PHP security.
 * Values:  pcgi4, pcgi5, or mod_php
 * Stored as "php"
 */
@property (nonatomic, copy) NSString* php;

/**
 * Whether enhanced security is selected (BOOL).
 * Stored as "security"
 */
@property (nonatomic, copy) NSNumber* security;

/**
 * Whether Fast CGI is selected (BOOL).
 * Stored as "fastcgi"
 */
@property (nonatomic, copy) NSNumber* fastCGI;

/**
 * Whether PHP xcache is selected (BOOL).
 * Stored as "xcache"
 */
@property (nonatomic, copy) NSNumber* xcache;

/**
 * Whether fcgid is selected for PHP. This is only available
 * for Dreamhost PS. (BOOL)
 * Stored as "php_fcgid"
 */
@property (nonatomic, copy) NSNumber* fcgid;

/**
 * Whether Passenger (mod_rails and mod_rack) is used with Apache. (BOOL)
 * Stored as "passenger"
 */
@property (nonatomic, copy) NSNumber* passenger;

@end
