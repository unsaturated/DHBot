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

#import "DHMServiceProgressCommand.h"

@implementation DHMServiceProgressCommand

+(NSString*) command { return DHM_SERVICE_PROG; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Service Progress", @"Service Progress - the command name itself");
        mCommandDesc = NSLocalizedString(@"Shows status of long running command", @"Shows status of a long running command that was executed");
        mRunningText = NSLocalizedString(@"Getting service status...", @"In-progress text for getting status for previous long-running commands");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 0;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns valid parameters for command.
 * token : the token returned from the long running command
 */
-(NSArray*) acceptableParameters
{
    return @[@"token"];
}

-(BOOL) requiresGuid { return YES; }

@end
