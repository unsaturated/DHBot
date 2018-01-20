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
 Stores data returned by the DHMListApiCapabilitiesCommand.
 */
@interface DHMApiCommandData : DHMBaseData

/**
 Gets arguments required for command.
 */
@property (nonatomic, copy) NSArray* args;

/**
 Gets API name of command as specified by Dreamhost.
 */
@property (nonatomic, copy) NSString* cmd;

/**
 Gets optional arguments required for command.
 */
@property (nonatomic, copy) NSArray* optargs;

/**
 Gets the order of arguments.
 */
@property (nonatomic, copy) NSArray* order;

@end
