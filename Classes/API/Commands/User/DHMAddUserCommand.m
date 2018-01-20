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

#import "DHMAddUserCommand.h"

@implementation DHMAddUserCommand

+(NSString*) command { return DHM_USER_ADD; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add User", @"Add User - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a user (ftp, sftp, shell)", @"Adds a user of various types (FTP, SFTP, and shell)");
        mRunningText = NSLocalizedString(@"Adding user...", @"In-progress text for adding a user");
        mEnabled = YES;
        mRequiresUserSelection = NO;
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
 * type       : the type of user; can be ftp, sftp, or shell
 * username   : the desired username for the new user
 * gecos      : the Full Name for this user, like John Smith (this field cannot be blank)
 * server     : the home for the user (the shared server or ps).  Required.
 * shell_type : the type of shell for the user (bash, tcsh, ksh, or zsh).  only required if the type is shell
 * password   : (optional) the password for the new user.  Will be randomly generated if not specified.
 * enhanced_security : (optional) set to 1 to enable Enhanced User Security (set to 0 or leave blank to disable)
 */
-(NSArray*) acceptableParameters { return @[@"type", @"username", @"gecos", @"server", @"shell_type", @"password", @"enhanced_security"]; }

-(BOOL) requiresGuid { return YES; }

@end
