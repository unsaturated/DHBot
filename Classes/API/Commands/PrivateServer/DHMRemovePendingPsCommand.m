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

#import "DHMRemovePendingPsCommand.h"

@implementation DHMRemovePendingPsCommand

+(NSString*) command { return DHM_PS_REMOVE_PENDING; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove Pending Additions", @"Remove Pending Additions - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes pending server additions", @"Lists all pending private server additions");
        mRunningText = NSLocalizedString(@"Removing pending servers...", @"In-progress text for removing pending server additions");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 2;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

@end
