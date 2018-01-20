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

#import "EAIntroPage.h"

@implementation EAIntroPage(PageProperties)

+ (void)setFontForAllTitles:(UIFont *)font withColor:(UIColor *)color withYPosition:(CGFloat)y withPages:(NSArray *)pages {
    for (EAIntroPage* page in pages) {
        if([page isKindOfClass:[EAIntroPage class]]){
            page.titleFont = font;
            page.titleColor = color;
            page.titlePositionY = y;
        }
    }
}

+ (void)setFontForAllDescriptions:(UIFont *)font withColor:(UIColor *)color withYPosition:(CGFloat)y withPages:(NSArray *)pages{
    for (EAIntroPage* page in pages) {
        if([page isKindOfClass:[EAIntroPage class]]){
            page.descFont = font;
            page.descColor = color;
            page.descPositionY = y;
        }
    }
}

@end
