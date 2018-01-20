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
 * List all available keys the account has created.
 * Note: You must have access to all api commands ("*") to use this command.
 */
@interface DHMApiListKeysDataItem : DHMBaseData

/**
 * API key.
 */
@property (nonatomic, copy) NSString* key;

/**
 * Creation date of key.
 */
@property (nonatomic, copy) NSDate* created;

/**
 * Comment on key.
 */
@property (nonatomic, copy) NSString* comment;

/**
 * Functions possible with key.
 */
@property (nonatomic, copy) NSString* functions;

@end
