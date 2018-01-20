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

#import "DHMAddMySqlUserCommand.h"

@implementation DHMAddMySqlUserCommand

+(NSString*) command { return DHM_SQL_ADD_USER; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add DB User", @"Add DB User - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a MySQL user", @"Adds a MySQL database user");
        mRunningText = NSLocalizedString(@"Adding user...", @"In-progress text for adding a database user");
        mEnabled = NO;
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
 * db: the database to which the user should be added.
 * user: the username for the new user.
 * password: the password for the new user.
 * select: Y or N (optional, default is Y).
 * insert: Y or N (optional, default is Y).
 * update: Y or N (optional, default is Y).
 * delete: Y or N (optional, default is Y).
 * create: Y or N (optional, default is Y).
 * drop:   Y or N (optional, default is Y).
 * index:  Y or N (optional, default is Y).
 * alter:  Y or N (optional, default is Y).
 * hostnames: a newline separated list of hosts, in which % is a wildcard, 
 *            from which the user is allowed to access the databases
 *            (optional, default is %.dreamhost.com).
 */
-(NSArray*) acceptableParameters { return @[
                                            @"db",
                                            @"user",
                                            @"password",
                                            @"select",
                                            @"insert",
                                            @"update",
                                            @"delete",
                                            @"create",
                                            @"drop",
                                            @"index",
                                            @"alter",
                                            @"hostnames"]; }

-(BOOL) requiresGuid { return YES; }

@end
