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

@interface EAIntroPage (PageProperties)

/**
 Sets the title attributes to the same values for an array of EAIntroPage objects.
 @param font Font for the page's title
 @param color Color of the page's title font
 @param y Vertical location of page's title
 @param pages Array of pages to update
 */
+ (void)setFontForAllTitles:(UIFont*)font withColor:(UIColor*)color withYPosition:(CGFloat)y withPages:(NSArray*)pages;

/**
 Sets the description attributes to the same values for an array of EAIntroPage objects.
 @param font Font for the page's description
 @param color Color of the page's description font
 @param y Vertical location of page's description
 @param pages Array of pages to update
 */
+ (void)setFontForAllDescriptions:(UIFont*)font withColor:(UIColor*)color withYPosition:(CGFloat)y withPages:(NSArray*)pages;

@end
