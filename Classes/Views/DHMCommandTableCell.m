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

#import "DHMCommandTableCell.h"
#import "DHMController.h"

@implementation DHMCommandTableCell
{
    // The preferred cell accessory, which can be set by the view-controller
    UITableViewCellAccessoryType _preferredCellAccessory;
    UIColor* _pointsColorSufficient;
    UIColor* _pointsColorInsufficient;
    BOOL _hasSufficientPointsToExecute;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _preferredCellAccessory = UITableViewCellAccessoryDisclosureIndicator;
        _pointsColorSufficient = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.3f alpha:1.0f];
        _pointsColorInsufficient = [UIColor colorWithHue:0.0f saturation:1.0f brightness:1.0f alpha:1.0f];
        _hasSufficientPointsToExecute = NO;
        
        CGSize size = self.contentView.frame.size;
        
        CGFloat endCellPadding = 30.0f;
        
        // Command Name
        CGFloat textX = 25.0f;
        CGFloat textY = 5.0f;
        CGFloat textHeight = 21.0f;
        CGFloat textWidth = size.width - endCellPadding - textX;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(textX, textY, textWidth, textHeight)];
        [self.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [self.textLabel setTextAlignment:NSTextAlignmentLeft];
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.textLabel];
        
        // Command Description
        CGFloat detailX = 25.0f;
        CGFloat detailY = textY + textHeight;
        CGFloat detailHeight = 14.0f;
        CGFloat detailWidth = size.width - endCellPadding - detailX;
        self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailX, detailY, detailWidth, detailHeight)];
        [self.detailTextLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.detailTextLabel setTextAlignment:NSTextAlignmentLeft];
        [self.detailTextLabel setTextColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:self.detailTextLabel];
        
        // Note (availability)
        CGFloat noteHeight = 20.0f;
        CGFloat noteWidth = 75.0f;
        CGFloat noteX = size.width - noteWidth - 8.0f;
        CGFloat noteY = size.height/2.0f - noteHeight/2.0f;
        self.noteTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(noteX, noteY, noteWidth, noteHeight)];
        [self.noteTextLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.noteTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.noteTextLabel setBackgroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.9f alpha:0.8f]];
        [self.noteTextLabel.layer setCornerRadius:5.0f];
        [self.noteTextLabel setAlpha:0.8f];
        // Clipping is required when setting cornerRadius
        [self.noteTextLabel setClipsToBounds:YES];
        UIColor* noteColor = [[DHMController sharedInstance] mainWindow].tintColor;
        [self.noteTextLabel setTextColor:noteColor];
        [self.contentView addSubview:self.noteTextLabel];
        
        // Points
        CGFloat pointsHeight = 18.0f;
        CGFloat pointsWidth = pointsHeight;
        CGFloat pointsX = size.width - pointsWidth - endCellPadding;
        CGFloat pointsY = size.height/2.0f - pointsHeight/2.0f;
        self.pointsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(pointsX, pointsY, pointsWidth, pointsHeight)];
        [self.pointsTextLabel setFont:[UIFont systemFontOfSize:11.5f]];
        [self.pointsTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.pointsTextLabel setBackgroundColor:_pointsColorSufficient];
        [self.pointsTextLabel.layer setCornerRadius:9.0f];
        // Clipping is required when setting cornerRadius
        [self.pointsTextLabel setClipsToBounds:YES];
        [self.pointsTextLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.pointsTextLabel];
        [self.pointsTextLabel setHidden:YES];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@synthesize textLabel;

@synthesize detailTextLabel;

@synthesize noteTextLabel;

@synthesize pointsTextLabel;

@synthesize command;

-(void)setupCellWithCommand:(DHMBaseCommand*)cmd
{
    [self setupCellWithCommand:cmd accessory:_preferredCellAccessory];
}

-(void)setupCellWithCommand:(DHMBaseCommand *)cmd accessory:(UITableViewCellAccessoryType)indicator
{
    // Store weak reference to command
    self.command = cmd;
    _preferredCellAccessory = indicator;
    
    if(!cmd.enabled)
    {
        // Disable the command
        [self updateCellAsDisabledForApp];
    }
    else
    {
        _hasSufficientPointsToExecute = YES;
        [self updateCellWithSufficientPoints:YES];
        [self.pointsTextLabel setHidden:YES];
    }
}

/**
 Updates cell to disable the command as it applies to the entire application.
 */
-(void) updateCellAsDisabledForApp
{
    [self.pointsTextLabel setHidden:YES];
    [self.textLabel setEnabled:NO];
    [self.detailTextLabel setEnabled:NO];
    
    // Set-up the noteTextLabel presentation, including color
    [self.noteTextLabel setHidden:NO];
    [self.noteTextLabel setText:self.command.disabledReason];
    [self setUserInteractionEnabled:NO];
    [self setAccessoryType:UITableViewCellAccessoryNone];
    
    [self.textLabel setText:self.command.commandName];
    [self.detailTextLabel setText:self.command.commandDesc];
    
    // Accessibility
    [self setAccessibilityLabel:self.command.commandName];
    
    // Disabled commands always have sufficient points
    _hasSufficientPointsToExecute = YES;
}

/**
 Updates cell to enable or disable based upon the number of available points.
 @param sufficientPoints whether points are sufficient to execute the command
 @return YES if the cell UI was updated and requires a refresh
 */
-(void) updateCellWithSufficientPoints:(BOOL)sufficientPoints
{
//    BOOL shouldRefreshCell = (_hasSufficientPointsToExecute != sufficientPoints) || (!_cellDidSetup);
//    
//    if(!shouldRefreshCell)
//        return NO;
    
    if(sufficientPoints)
    {
        [self.pointsTextLabel setHidden:NO];
        [self.textLabel setEnabled:YES];
        [self.detailTextLabel setEnabled:YES];
        [self.noteTextLabel setHidden:YES];
        [self setUserInteractionEnabled:YES];
        [self.pointsTextLabel setEnabled:YES];
        [self.pointsTextLabel setBackgroundColor:_pointsColorSufficient];
        NSString* pts = [NSString stringWithFormat:@"%lu", (unsigned long)self.command.pointCost];
        [self.pointsTextLabel setText:pts];
        
        // The indicator...indicates the type of user interaction allowed
        [self setAccessoryType:_preferredCellAccessory];
        
        switch (_preferredCellAccessory)
        {
            case UITableViewCellAccessoryNone:
                [self setUserInteractionEnabled:NO];
                break;
            default:
                [self setUserInteractionEnabled:YES];
                break;
        }
    }
    else
    {
        [self.pointsTextLabel setHidden:NO];
        [self.textLabel setEnabled:NO];
        [self.detailTextLabel setEnabled:NO];
        [self.noteTextLabel setHidden:YES];
        [self setUserInteractionEnabled:NO];
        [self.pointsTextLabel setBackgroundColor:_pointsColorInsufficient];
        NSString* pts = [NSString stringWithFormat:@"%lu", (unsigned long)self.command.pointCost];
        [self.pointsTextLabel setText:pts];
        [self setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Accessibility
    [self.textLabel setText:self.command.commandName];
    [self.detailTextLabel setText:self.command.commandDesc];
    
    [self setAccessibilityLabel:self.command.commandName];
    [self setAccessibilityHint:[NSString stringWithFormat:@"%@ for %lu points.", self.command.commandDesc, (unsigned long)self.command.pointCost]];
    
    _hasSufficientPointsToExecute = sufficientPoints;
    
//    return shouldRefreshCell;
}

- (void)updateWithNewAvailablePoints:(NSUInteger)pointsAvailable
{
    // Check if the command is valid
    if(self.command)
    {        
        if(self.command.pointCost <= pointsAvailable)
        {
            // Points cost is less than equal to available points - Enable :-)
            [self updateCellWithSufficientPoints:YES];
        }
        else if(self.command.pointCost > pointsAvailable)
        {
            // Point cost is greater than the available points - Disable :-(
            [self updateCellWithSufficientPoints:NO];
        }
    }
}

@end
