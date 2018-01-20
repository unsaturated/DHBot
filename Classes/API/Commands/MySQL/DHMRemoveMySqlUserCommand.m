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

#import "DHMRemoveMySqlUserCommand.h"

@implementation DHMRemoveMySqlUserCommand

+(NSString*) command { return DHM_SQL_REMOVE_USER; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove DB User", @"Remove DB User - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a MySQL user", @"Removes a MySQL database user");
        mRunningText = NSLocalizedString(@"Removing user...", @"In-progress text for removing a database user");
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
 * db:     the database from which the user should be removed.
 * user:   the username for the new user.
 * select: Y or N.
 * insert: Y or N.
 * update: Y or N.
 * delete: Y or N.
 * create: Y or N.
 * drop:   Y or N.
 * index:  Y or N.
 * alter:  Y or N.
 */
-(NSArray*) acceptableParameters { return @[
                                            @"db",
                                            @"user",
                                            @"select",
                                            @"insert",
                                            @"update",
                                            @"delete",
                                            @"create",
                                            @"drop",
                                            @"index",
                                            @"alter"]; }

-(BOOL) requiresGuid { return YES; }

@end
