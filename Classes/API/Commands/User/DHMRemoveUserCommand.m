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

#import "DHMRemoveUserCommand.h"

@implementation DHMRemoveUserCommand

+(NSString*) command { return DHM_USER_REMOVE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove User", @"Remove User - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a user", @"Removes a user from the account");
        mRunningText = NSLocalizedString(@"Removing user...", @"In-progress text for removing a user");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 3;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * username   : the user to remove, like testuser42.
 *              Optionally use username@home to specify a home, like testuser42@riga
 * type       : (Optional) the type of user, like ftp, shell, etc
 * remove_all : (Optional) set to 1 to remove all instances of this user (if user has multiple types or is on multiple homes)
 */
-(NSArray*) acceptableParameters { return @[@"username", @"type", @"remove_all"]; }

-(BOOL) requiresGuid { return YES; }

@end
