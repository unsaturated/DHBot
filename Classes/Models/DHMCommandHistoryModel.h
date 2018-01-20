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

#define DHM_HISTMODEL_STORE_NAME @"DhmHistoryStore.dat"
#define DHM_HISTMODEL_API_KEY    @"KeyForApi"
#define DHM_HISTMODEL_CMD_KEY    @"KeyForCommand"
#define DHM_HISTMODEL_DATE_KEY   @"KeyForDate"

/**
 Used to store the minimum amount of information that represents
 an individual command that was executed.
 */
@interface DHMCommandHistoryModel : NSObject <NSCoding,NSCopying>

/**
 * Creates a new entry with a key, name, date.
 * @param key API key
 * @param cmd Command identifier
 * @param date Date command was executed
 */
+(id) entryWithKey:(NSString*)key command:(NSString*)cmd date:(NSDate*)date;

/**
 * Saves all API history from the provided array.
 * @param apiHistory Array of DHMCommandHistoryModel objects
 */
+(void) saveApiHistoryLocally:(NSArray*)apiHistory;

/**
 * Retuns an array of API command objects loaded from local file system.
 * @return Array of DHMCommandHistoryModel objects
 */
+(NSArray*) loadApiHistoryLocally;

#pragma mark Serialized Data

/**
 The API key itself.
 */
@property (nonatomic, copy) NSString* apiKey;

/**
 API command sent to Dreamhost.
 */
@property (nonatomic, copy) NSString* command;

/**
 Date / time when the command was executed.
 */
@property (nonatomic, copy) NSDate* date;

#pragma mark Non-Serialized Data

/**
 Human readable command name. This should not be serialized and 
 is retrieved at runtime.
 */
@property (nonatomic, copy) NSString* commandName;

@end
