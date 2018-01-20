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

#import "DHMListAnnounceSubscribersCommand.h"

@implementation DHMListAnnounceSubscribersCommand

+(NSString*) command { return DHM_LISTSRV_USER_LIST; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Subscribers", @"Subscribers - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists subscribers for announcements", @"Lists e-mail list subscribers who receive announcements");
        mRunningText = NSLocalizedString(@"Getting subscribers...", @"In-progress text for getting the e-mail subscribers");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 1;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

/**
 * Returns the valid parameters.
 *
 * listname : the name of the announcement list, like announcements
 * domain   : the domain of the announcement list, like mydomain.com
 */
-(NSArray*) acceptableParameters { return @[
                                            @"listname",
                                            @"domain"]; }

-(BOOL) requiresGuid { return YES; }

@end
