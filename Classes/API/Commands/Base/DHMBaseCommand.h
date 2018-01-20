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
#import "DHMCommand.h"
#import "DHMCommandCategory.h"

@interface DHMBaseCommand : NSObject <DHMCommand>
{
    @protected
    NSMutableDictionary* paramDictionary;
    NSString* mCommand;
    NSString* mCommandName;
    NSString* mCommandDesc;
    NSString* mCommandCategoryEnumName;
    BOOL mEnabled;
    BOOL mRequiresUserSelection;
    BOOL mHasParameters;
    NSString* mDisabledReason;
    NSString* mRunningText;
    CommandCategory mCommandCategory;
    NSURL* mCommandUrl;
    NSUInteger mPointCost;
}

/**
 Creates a new command using internal metadata. The metadata contains the
 description and other text.
 @cat command category object
 @return new command
 */
+(id) commandWithInternalDataAndCategory:(DHMCommandCategory*)cat;

@end
