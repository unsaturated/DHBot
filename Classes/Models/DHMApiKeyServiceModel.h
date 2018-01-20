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

#define DHM_SERVICEMODEL_STORE_NAME @"DhmTokenStore.dat"
#define DHM_SERVICEMODEL_API_KEY    @"KeyForApi"
#define DHM_SERVICEMODEL_TOKEN_KEY  @"KeyForToken"
#define DHM_SERVICEMODEL_NAME_KEY   @"KeyForName"

/**
 * Provides a data model and archival support (via NSCoding) to
 * simple key/description objects. This is to store the user's API
 * key and a long-running service token.
 */

@interface DHMApiKeyServiceModel : NSObject <NSCoding,NSCopying>

/**
 * Creates a new entry with a key, token, and command name.
 * @param key API key
 * @param name command name associated with service token
 * @param token service token returned for procedure
 */
+(id) entryWithKey:(NSString*)key commandName:(NSString*)name token:(NSString*)token;

/**
 * Saves all API tokens from the provided array.
 * @param tokens Array of DHMApiKeyServiceModel objects
 */
+(void) saveTokensLocally:(NSArray*)tokens;

/**
 * Retuns an array of API service tokens loaded from local file system.
 * @return Array of DHMApiKeyServiceModel objects
 */
+(NSArray*) loadTokensLocally;

/**
 * The API key responsible for the token.
 */
@property (nonatomic, copy) NSString* apiKey;

/**
 * Command name associated with service.
 */
@property (nonatomic, copy) NSString* commandName;

/**
 * Service token.
 */
@property (nonatomic, copy) NSString* token;

@end
