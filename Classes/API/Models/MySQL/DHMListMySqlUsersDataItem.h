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
 Data that represents a database user.
 */
@interface DHMListMySqlUsersDataItem : DHMBaseData

/**
 Gets the account ID.
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 Gets the database user is associated with.
 */
@property (nonatomic, copy) NSString* database;

/**
 Gets the home for the user.
 */
@property (nonatomic, copy) NSString* home;

/**
 Gets the username.
 */
@property (nonatomic, copy) NSString* username;

/**
 Gets the host user is on.
 */
@property (nonatomic, copy) NSString* host;

/**
 Gets if the user can SELECT.
 */
@property (nonatomic, copy) NSNumber* canSelect;

/**
 Gets if the user can INSERT.
 */
@property (nonatomic, copy) NSNumber* canInsert;

/**
 Gets if the user can UPDATE.
 */
@property (nonatomic, copy) NSNumber* canUpdate;

/**
 Gets if the user can DELETE.
 */
@property (nonatomic, copy) NSNumber* canDelete;

/**
 Gets if the user can CREATE.
 */
@property (nonatomic, copy) NSNumber* canCreate;

/**
 Gets if the user can DROP.
 */
@property (nonatomic, copy) NSNumber* canDrop;

/**
 Gets if the user can INDEX.
 */
@property (nonatomic, copy) NSNumber* canIndex;

/**
 Gets if the user can ALTER.
 */
@property (nonatomic, copy) NSNumber* canAlter;

@end
