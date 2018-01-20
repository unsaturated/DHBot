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

#import "DHMListPsUsageCommand.h"

@implementation DHMListPsUsageCommand

+(NSString*) command { return DHM_PS_LIST_USAGE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Utilization", @"Utilization - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists private server utilization", @"Lists the private server utilization");
        mRunningText = NSLocalizedString(@"Getting utilization...", @"In-progress text for getting the private server utilization");
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
 * Returns valid parameters for command.
 * ps : the name of the ps (get it from list_ps)
 */
-(NSArray*) acceptableParameters
{
    return @[@"ps"];
}

-(BOOL) requiresGuid { return YES; }

@end
