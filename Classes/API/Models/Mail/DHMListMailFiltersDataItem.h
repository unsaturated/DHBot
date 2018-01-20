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
 Data that represents a mail filter item.
 */
@interface DHMListMailFiltersDataItem : DHMBaseData

/**
 Gets the account ID.
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 Gets the e-mail address that is filtered.
 */
@property (nonatomic, copy) NSString* address;

/**
 Gets the rank of the filter, where lower numbers run first.
 */
@property (nonatomic, copy) NSNumber* rank;

/**
 Gets the search string that is filtered.
 */
@property (nonatomic, copy) NSString* filter;

/**
 Gets filtering field (subject, from, to, cc, body, reply-to, headers).
 */
@property (nonatomic, copy) NSString* filterOn;

/**
 Gets filtering action (ove,forward,delete,add_subject,forward_shell, and, or).
 */
@property (nonatomic, copy) NSString* action;

/**
 Gets the parameter for the action (note: optional if action is delete, and, or).
 */
@property (nonatomic, copy) NSString* actionValue;

/**
 Gets whether filter search does or does not contain.
 */
@property (nonatomic, copy) NSNumber* contains;

/**
 Gets stop action (yes or no). Note: must be yes if action is delete.
 */
@property (nonatomic, copy) NSNumber* stop;

@end
