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

#import "DHMRemoveAnnounceSubscriberCommand.h"

@implementation DHMRemoveAnnounceSubscriberCommand

+(NSString*) command { return DHM_LISTSRV_REMOVE_PERSON; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove Subscriber", @"Remove Subscriber - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes an announcement subscriber from a list", @"Removes an e-mail subscriber from an announcement list");
        mRunningText = NSLocalizedString(@"Removing subscriber...", @"In-progress text for removing the e-mail subscriber");
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
 * listname : the name of the announcement list, like announcements
 * domain   : the domain of the announcement list, like mydomain.com
 * email    : the email address to unsubscribe, like test@test.com
 */
-(NSArray*) acceptableParameters { return @[
                                            @"listname",
                                            @"domain",
                                            @"email"]; }

-(BOOL) requiresGuid { return YES; }


@end
