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

#import "DHMRemoveMySqlHostnameCommand.h"

@implementation DHMRemoveMySqlHostnameCommand

+(NSString*) command { return DHM_SQL_REMOVE_HOST; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove DB Hostname", @"Remove DB Hostname - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a MySQL hostname", @"Removes a MySQL database host name");
        mRunningText = NSLocalizedString(@"Removing hostname...", @"In-progress text for removing the hostname");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 2;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * hostname  : the full hostname you want to serve as a MySQL hostname
 */
-(NSArray*) acceptableParameters { return @[@"hostname"]; }

-(BOOL) requiresGuid { return YES; }

@end
