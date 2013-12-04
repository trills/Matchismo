//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jenny Tsai on 12/2/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) Deck *sampleDeck;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (Deck *)sampleDeck
{
    if (!_sampleDeck) _sampleDeck = [self createDeck];
    return _sampleDeck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}



- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    

    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}


- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    PlayingCard *c = self.sampleDeck.drawRandomCard;
    NSString *jt = [NSString stringWithFormat:@"%d%@", c.rank, c.suit];
    
    [sender setTitle:jt forState:UIControlStateSelected];
    
    //UIControlStateSelected
    //NSString *ab = sender.currentTitle;
    
    //self.flipCount = self.flipCount+1
    self.flipCount++;
}

@end
