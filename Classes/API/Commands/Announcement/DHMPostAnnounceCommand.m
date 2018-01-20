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

#import "DHMPostAnnounceCommand.h"

@implementation DHMPostAnnounceCommand

+(NSString*) command { return DHM_LISTSRV_POST_MSG; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Post Announcement", @"Post Announcement - the command name itself");
        mCommandDesc = NSLocalizedString(@"Post to an announcement list", @"Posts/sends an e-mail to an announcement list");
        mRunningText = NSLocalizedString(@"Posting announcement...", @"In-progress text for posting/sending an e-mail announcement");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 4;
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
 * subject  : the subject of the message (optional)
 * message  : the text of the message to send
 * name     : the name for the list to use, like: "list name" <list@domain.com>
 * stamp    : the time to send the message, like 2009-05-28 19:40:00 (optional)
 * charset  : the character set in which the message is encoded (optional)
 * type     : the format of the message, either text or html (optional)
 * duplicate_ok: whether to allow duplicate messages to be sent, like 1 or 0 (optional)
 */
-(NSArray*) acceptableParameters { return @[
                                            @"listname",
                                            @"domain",
                                            @"subject",
                                            @"message",
                                            @"name",
                                            @"stamp",
                                            @"charset",
                                            @"type",
                                            @"duplicate_ok"]; }

-(BOOL) requiresGuid { return YES; }

@end
