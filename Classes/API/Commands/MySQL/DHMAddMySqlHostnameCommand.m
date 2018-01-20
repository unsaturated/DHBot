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

#import "DHMAddMySqlHostnameCommand.h"

@implementation DHMAddMySqlHostnameCommand

+(NSString*) command { return DHM_SQL_ADD_HOST; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add DB Hostname", @"Add DB Hostname - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a MySQL hostname", @"Adds a MySQL database host name");
        mRunningText = NSLocalizedString(@"Adding hostname...", @"In-progress text for adding the hostname");
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
 * hostname  : the full hostname you want to serve as a mysql 
               hostname (unless the domain following the first . is hosted 
               with us, you will not be able to access phpMyAdmin from this hostname).\
 */
-(NSArray*) acceptableParameters { return @[@"hostname"]; }

-(BOOL) requiresGuid { return YES; }

@end
