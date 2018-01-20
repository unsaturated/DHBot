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

#import "DHMListSettingsPsCommand.h"

@implementation DHMListSettingsPsCommand

+(NSString*) command { return DHM_PS_LIST_SETTINGS; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Server Settings", @"Server Settings - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists private server settings", @"Lists private server settings");
        mRunningText = NSLocalizedString(@"Getting server settings...", @"In-progress text for getting server settings");
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
 * ps : the name of the ps (get it from list_ps)
 */
-(NSArray*) acceptableParameters { return @[@"ps"]; }

-(BOOL) requiresGuid { return YES; }

@end
