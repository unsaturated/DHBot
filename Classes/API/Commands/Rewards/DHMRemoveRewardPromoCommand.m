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

#import "DHMRemoveRewardPromoCommand.h"

@implementation DHMRemoveRewardPromoCommand

+(NSString*) command { return DHM_REW_REMOVE_CODE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Remove Promo Code", @"Remove Promomotional/Rewards Code - the command name itself");
        mCommandDesc = NSLocalizedString(@"Removes a promo code", @"Adds a promotional/rewards code");
        mRunningText = NSLocalizedString(@"Removing code...", @"In-progress text for removing a promotional/rewards code");
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
 * code : desired promo code must be 3-16 characters, only letters or numbers, and not be numbers only
 */
-(NSArray*) acceptableParameters { return @[@"code"]; }

-(BOOL) requiresGuid { return YES; }

@end
