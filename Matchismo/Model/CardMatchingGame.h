//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jenny Tsai on 12/5/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)addCardCount:(NSUInteger)addition;
- (void)setMatchThreeOn:(BOOL)matchThreeon;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSUInteger cardCount;
@property (nonatomic, readonly) BOOL matchThreeOn;

@end
