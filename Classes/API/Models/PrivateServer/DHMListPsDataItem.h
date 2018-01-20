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
 Data that represents a Private Server data item.
 TODO : There are numerous properties with unknown values.
 */
@interface DHMListPsDataItem : DHMBaseData

/**
 Gets the account identifier.
 */
@property (nonatomic, copy) NSString* accountId;

/**
 Gets the private server's name.
 */
@property (nonatomic, copy) NSString* name;

/**
 Gets the user-assigned description.
 */
@property (nonatomic, copy) NSString* description;

/**
 Gets the status of the server.
 */
@property (nonatomic, copy) NSString* status;

/**
 Gets the type of server (web or MySQL
 */
@property (nonatomic, copy) NSString* type;

/**
 Gets the allocated memory in megabytes.
 */
@property (nonatomic, copy) NSNumber* memoryMb;

/**
 Gets the start-up date of the server.
 */
@property (nonatomic, copy) NSString* startDate;

/**
 Gets the IP address of the server.
 */
@property (nonatomic, copy) NSString* ip;

@end
