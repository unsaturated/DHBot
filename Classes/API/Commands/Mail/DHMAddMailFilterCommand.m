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

#import "DHMAddMailFilterCommand.h"

@implementation DHMAddMailFilterCommand

+(NSString*) command { return DHM_MAIL_ADD_FILTER; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add Mail Filter", @"Add Mail Filter - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a mail filter", @"Adds an e-mail filter");
        mRunningText = NSLocalizedString(@"Adding filter...", @"In-progress text for adding an e-mail filter");
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
 * address   : the full email address to which you want to add the filter.
 * filter_on : subject, from, to, cc, body, reply-to, headers.
 * filter    : what to filter for (case sensitive).
 * action    : move,forward,delete,add_subject,forward_shell, and, or.
 * action_value : the parameter for the action (note: optional if action is delete, and, or).
 * contains  : yes or no (optional, default is yes).
 * stop : yes or no (optional, default is yes. note: must be yes if action is delete).
 * rank : the rank of the filter, indexes from 0, lower means executed first 
          (optional, default is the number of filters for the address).
 * To create a complex multi-part filter, simply append an underscore to each of the above, followed by a number (starting at 1) for which step of the filter it is.
 */
-(NSArray*) acceptableParameters { return @[
                                            @"address",
                                            @"filter_on",
                                            @"filter",
                                            @"action",
                                            @"action_value",
                                            @"contains",
                                            @"stop",
                                            @"rank"]; }

-(BOOL) requiresGuid { return YES; }

@end
