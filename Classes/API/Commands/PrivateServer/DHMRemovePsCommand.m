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

#import "DHMRemovePsCommand.h"

@implementation DHMRemovePsCommand

+(NSString*) command { return DHM_PS_REMOVE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove Server", @"Remove Server - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a private server", @"Removes a private server");
        mRunningText = NSLocalizedString(@"Removing server...", @"In-progress text for removing a private server");
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
 * ps : the machine name of the ps you'd like to destroy.
 */
-(NSArray*) acceptableParameters { return @[@"ps"]; }

-(BOOL) requiresGuid { return YES; }

@end
