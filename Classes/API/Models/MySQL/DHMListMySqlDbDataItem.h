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
 Data that represents a database item.
 */
@interface DHMListMySqlDbDataItem : DHMBaseData

/**
 Gets the account ID number.
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 Gets the name of the database.
 */
@property (nonatomic, copy) NSString* database;

/**
 Gets the description of the database.
 */
@property (nonatomic, copy) NSString* description;

/**
 Gets the location of the host.
 */
@property (nonatomic, copy) NSString* home;

/**
 Gets disk usage in megabytes.
 */
@property (nonatomic, copy) NSNumber* diskUsageMb;

@end
