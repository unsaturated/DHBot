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

#import "DHMAddAnnounceSubscriberCommand.h"

@implementation DHMAddAnnounceSubscriberCommand

+(NSString*) command { return DHM_LISTSRV_ADD_PERSON; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add Subscriber", @"Add Subscriber - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds an announcement subscriber to a list", @"Adds an e-mail subscriber to an announcement list");
        mRunningText = NSLocalizedString(@"Adding subscriber...", @"In-progress text for adding the e-mail subscriber");
        mEnabled = NO;
        mRequiresUserSelection = NO;
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
 * listname : the name of the announcement list, like announcements
 * domain   : the domain of the announcement list, like mydomain.com
 * email    : the email address to subscribe, like test@test.com
 * name     : the name of the person, like Josh Jones (optional)
 */
-(NSArray*) acceptableParameters { return @[
                                            @"listname",
                                            @"domain",
                                            @"email",
                                            @"name"]; }

-(BOOL) requiresGuid { return YES; }

@end
