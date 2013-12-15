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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

- (IBAction)RestartGame:(UIButton *)sender {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    
    [self updateUI];
}


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self createDeck]];

    return _game;
}

- (IBAction)ThreeCardGame:(UISwitch *)sender
{
    //UISwitch *status = sender;
    [self.game setMatchThreeOn:sender.on];
    NSLog (@"%@", self.game.matchThreeOn ? @"On" : @"Off");
}


- (IBAction)flipCard:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game addCardCount:1];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"blankcard" : @"sf"]; //adapted from Matt Swern's Flickr photo of the Golden Gate Bridge
}


@end
