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

#import "DHMApiCommands.h"

/**
 * Command category organizes the category information.
 */
@interface DHMCommandCategory : NSObject

/**
 * Converts a category enumeration string to the enumerated value.
 * @param name type defined enumeration name, e.g. kAPICategory
 * @return enumeration value (0 - N)
 */
+(CommandCategory) categoryFromEnumName:(NSString*)name;

/**
 * Creates a category object.
 * @param cat category enumeration value
 * @param name readable name
 */
+(id) category:(CommandCategory)cat categoryName:(NSString*)name;

/** 
 * Initializes the object.
 */
-(id) initWithCat:(CommandCategory)cat andName:(NSString*)name;

/**
 * Gets the readable name.
 */
@property (nonatomic, copy) NSString* name;

/**
 * Gets the category enumeration.
 */
@property (nonatomic, readonly) CommandCategory cat;

@end
