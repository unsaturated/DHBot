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

#define DHM_KEYMODEL_STORE_NAME @"DhmKeyStore.dat"
#define DHM_KEYMODEL_API_KEY    @"KeyForApi"
#define DHM_KEYMODEL_DESC_KEY   @"KeyForDescription"
#define DHM_KEYMODEL_CMDS_KEY   @"KeyForAllowableCommands"

/**
 * Provides a data model and archival support (via NSCoding) to 
 * simple key/description objects. This is to store the user's API 
 * key, a brief description, and a list of allowable commands. Before
 * the data is stored locally, it is first validated as a 
 */
@interface DHMApiKeyModel : NSObject <NSCoding,NSCopying>

/**
 * Creates a new entry with a key and description.
 * @param key API key
 * @param desc description of key
 * @param cmds commands allowabled with key - should be strings
 */
+(id) entryWithKey:(NSString*)key description:(NSString*)desc commands:(NSArray*)cmds;

/**
 * Saves all API keys from the provided array.
 * @param apiKeys Array of DHMApiKeyModel objects
 */
+(void) saveApiKeysLocally:(NSArray*)apiKeys;

/**
 * Retuns an array of API key objects loaded from local file system.
 * @return Array of DHMApiKeyModel objects
 */
+(NSArray*) loadApiKeysLocally;

/**
 * The API key itself.
 */
@property (nonatomic, copy) NSString* apiKey;

/**
 * A brief description of the key to differentiate them.
 */
@property (nonatomic, copy) NSString* description;

/**
 * An array of the allowable commands for this key.
 */
@property (nonatomic, copy) NSArray* allowableCommands;

/**
 Gets whether model stores a command matching the provided name.
 @param name command name to match.
 @return YES if command found
 */
-(BOOL) hasCommand:(NSString*)name;

@end
