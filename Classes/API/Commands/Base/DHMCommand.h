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

#import <Foundation/Foundation.h>
#import "DHMApiCommands.h"

@protocol DHMCommand <NSObject>

@required

/**
 Gets the command string.
 Note: this is also a unique identifier for the command.
 */
+(NSString*) command;

/**
 API command to send to Dreamhost.
 */
@property (nonatomic, copy) NSString* command;

/**
 Human readable command name.
 */
@property (nonatomic, copy) NSString* commandName;

/**
 Longer description of command (longer than title).
 */
@property (nonatomic, copy) NSString* commandDesc;

/**
 Human readable command category.
 */
@property (nonatomic, copy) NSString* commandCategory;

/**
 Command URL for more information.
 */
@property (nonatomic, copy) NSURL* commandURL;

/**
 Command enumeration value.
 */
@property (nonatomic, readonly) CommandCategory category;

/**
 Gets the point cost for running the command.
 */
@property (nonatomic, readonly) NSUInteger pointCost;

/**
 Whether command is enabled for use.
 */
@property (nonatomic, readonly) BOOL enabled;

/**
 Reason if the command is not enabled.
 */
@property (nonatomic, copy) NSString* disabledReason;

/**
 Gets text to display when command is executing. E.g. "Getting users..."
 */
@property (nonatomic, copy) NSString* runningText;

/**
 Gets whether the command can return a list (array) of multiple data instances.
 */
@property (nonatomic, readonly) BOOL returnsArray;

/**
 Gets whether the command can return errors.
 */
@property (nonatomic, readonly) BOOL returnsErrors;

/**
 Gets the array of acceptable command parameters or nil if none are required.
 */
@property (nonatomic, readonly) NSArray* acceptableParameters;

/**
 Gets whether the command has parameters (values) to be sent.
 */
@property (nonatomic, readonly) BOOL hasParameters;

/**
 Gets whether the command requires a unique identifier before submitting.
 Typically, commands that POST data should generate a GUID.
 */
@property (nonatomic, readonly) BOOL requiresGuid;

/**
 Gets whether the command requires some form of user input.
 */
@property (nonatomic, readonly) BOOL requiresUserSelection;

/**
 Builds the proper format for the command's query string using the current (selected)
 key, command, values, and format.
 */
-(NSString*) buildQueryString;

/**
 Builds a command's query string using the provided key.
 */
-(NSString*) buildQueryStringWithKey:(NSString*)key;

@optional

/**
 Sets a command parameter with a value. Check the acceptableParameters
 property first before calling this message.
 @param param parameter name to update
 @param value parameter value to update
 */
-(void) setParameterKey:(NSString *)key withValue:(NSString *)value;

/**
 Gets the parameter dictionary. Use hasParameters property to determine if
 using this is necessary.
 */
@property (nonatomic, readonly) NSDictionary* parameterDictionary;

@end
