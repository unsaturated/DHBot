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

/**
 * Base data returned by the DreamHost API.
 */
@interface DHMBaseData : NSObject

/**
 * Checks if the data has a success result.
 */
+(BOOL) isSuccess:(DHMBaseData*)data;

/**
 * Gets the mapping object for this class.
 */
+(RKObjectMapping*) objectMappingForREST;

/**
 * Gets the response descriptor for this class.
 */
+(RKResponseDescriptor*) responseDescriptorForREST;

#pragma mark Standard Properties of DH API
@property (nonatomic, copy) NSString* result;
@property (nonatomic, copy) NSString* reason;
@property (nonatomic, copy) NSArray*  data;

@end
