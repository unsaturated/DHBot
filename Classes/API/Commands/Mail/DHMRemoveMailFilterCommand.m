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

#import "DHMRemoveMailFilterCommand.h"

@implementation DHMRemoveMailFilterCommand

+(NSString*) command { return DHM_MAIL_REMOVE_FILTER; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove Mail Filter", @"Remove Mail Filter - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a mail filter", @"Removes an e-mail filter");
        mRunningText = NSLocalizedString(@"Removing filter...", @"In-progress text for removing an e-mail filter");
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
 * address : the full email address from which you want to remove the filter.
 * filter_on : subject, from, to, cc, body, reply-to, headers.
 * filter : what to filter for (case sensitive).
 * action : move,forward,delete,add_subject,forward_shell.
 * action_value : the parameter for the action (note: optional if action is delete).
 * contains : yes or no.
 * stop : yes or no.
 * rank : the rank of the filter, lower means executed first.
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
