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

#import "DHMBaseCommand.h"

#define DH_QUERY_FORMAT @"json"

#define DHM_API_KEY_LENGTH 16

@interface DHMApi : NSObject

/**
 Gets the instance of the Dreamhost API singleton.
 */
+(DHMApi*) sharedInstance;

/**
 Performs initialization after the API object itself is created.
 */
-(void) initializeApi;

/**
 Performs shutdown/cleanup operations when the API object is no longer needed.
 */
-(void) shutdownApi;

/**
 Gets the pending API request count as determined by RestKit.
 */
@property (nonatomic, readonly) NSUInteger pendingApiRequestCount;

/**
 Cancels all ongoing API requests.
 */
-(void) cancelApiRequests;

/**
 Gets the enumeration value from a category name.
 @param name readable name of the category
 @return enumerated value
 */
-(CommandCategory) valueFromCategoryName:(NSString*)name;

/**
 Gets the readable name of a category from its enumerated value.
 @param cat enumeration value of category
 @return readable name
 */
-(NSString*) categoryNameFromValue:(CommandCategory)cat;

/**
 Gets the command object from the API command string.
 @param name API name of command
 @return command object or nil
 */
-(DHMBaseCommand*) commandFromCommandName:(NSString*)name;

/**
 Provides meta data about every command. The array contains dictionaries
 which have a "cmd", "cat", "name", "description", and other keys.
 */
@property (nonatomic, readonly) NSArray* commandMetadataArray;

/**
 Gets the list of all DHMCommandCategory objects.
 */
@property (nonatomic, copy) NSArray* allCommandCategories;

/**
 Gets the list of all commands regardless of key capabilities.
 */
@property (nonatomic, readonly) NSArray* allCommands;

/**
 Gets the list of commands available for the selected key.
 */
@property (nonatomic, readonly) NSArray* commandsForSelectedKey;

/**
 Gets or sets the selected API key currently in use. (Several could be
 stored in the application.)
 */
@property (nonatomic, retain) NSString* selectedKey;

/**
 Builds a command query string using the selectedKey. All parameters (values) are added when present.
 @param cmd command to use for query
 @return Complete command string
 */
-(NSString*) buildQueryWithCommand:(DHMBaseCommand*)cmd;

/**
 Builds a command request using the selectedKey. All parameters (values) are added when present.
 @param cmd command to use for query
 @return Request via URL
 */
-(NSURLRequest*) buildRequestWithCommand:(DHMBaseCommand*)cmd;

/**
 Builds a command query string with a specific API key.  All parameters (values) are added when present.
 @param cmd command to use for query
 @param key key to use
 @return Complete command string
 */
-(NSString*) buildQueryWithCommand:(DHMBaseCommand *)cmd usingKey:(NSString*)key;

/**
 Builds a command request with a specific API key. All parameters (values) are added when present.
 @param cmd command to use for query
 @param key key to use
 @return Request via URL
 */
-(NSURLRequest*) buildRequestWithCommand:(DHMBaseCommand *)cmd usingKey:(NSString*)key;

/**
 Searches all supported commands in the API and returns a dictionary (key) containing
 category names and an array (value) of each command within that category.
 @param commands list of command strings to lookup
 */
-(NSDictionary*) dictionaryForCommandStrings:(NSArray*)commands;

/**
 Searches all supported commands in the API and returns a dictionary (key) containing
 category names and an array (value) of each command within that category.
 @param commands list of command strings to lookup
 @param removeInteractive whether to filter out commands that require user interaction
 */
-(NSDictionary*) dictionaryForCommandStrings:(NSArray *)commands filterInteractive:(BOOL)removeInteractive;

@end
