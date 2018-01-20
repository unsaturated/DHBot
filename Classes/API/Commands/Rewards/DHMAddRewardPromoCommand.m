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

#import "DHMAddRewardPromoCommand.h"

@implementation DHMAddRewardPromoCommand

+(NSString*) command { return DHM_REW_ADD_CODE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add Promo Code", @"Add promomotional/rewards Code - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a promo code", @"Adds a promotional/rewards code");
        mRunningText = NSLocalizedString(@"Adding code...", @"In-progress text for adding a promotional/rewards code");
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
 * code : desired promo code must be 3-16 characters, only letters or numbers, and not be numbers only
 * description   : a text description of the code.  max 32 characters
 * bonus_domregs : the number of free domregs the code will provide (costs $15 per bonus domreg)
 * bonus_ips     : the number of free ips the code will provide (costs $30 per bonus ip)
 * discount_month : the discount off the monthly plan (note: this is no longer available for new plans)
 * discount_1year : the discount off 1-year hosting
 * discount_2year : the discount off 2-year hosting
 */
-(NSArray*) acceptableParameters { return @[
                                            @"code",
                                            @"description",
                                            @"bonus_domregs",
                                            @"bonus_ips",
                                            @"discount_month",
                                            @"discount_1year",
                                            @"discount_2year"]; }

-(BOOL) requiresGuid { return YES; }

@end
