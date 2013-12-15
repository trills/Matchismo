//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jenny Tsai on 12/5/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSUInteger cardCount; // # of cards in our hand
@property (nonatomic, readwrite) BOOL matchThreeOn; // match three cards instead of two

@property (nonatomic, strong) NSMutableArray *cards; // of Card


@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)cardCount
{
    if (!_cardCount) { _cardCount=0; }
    return _cardCount;
}

- (void)addCardCount:(NSUInteger)addition
{
    self.cardCount+=addition;
}


- (void)setMatchThreeOn:(BOOL)matchThreeOn
{
    _matchThreeOn = matchThreeOn;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];

    if (self) {
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }

    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) { // if false (card is matched) ==> card is not matched
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isChosen && !otherCard.isMatched){
  
                    PlayingCard *poc = (PlayingCard *)otherCard;
                    NSLog (@"cardCount=%d", self.cardCount);
                    NSLog (@"card content=%d%@", poc.rank, poc.suit);

                    
                    if (self.cardCount>=3){
                        self.cardCount=0;
                        
                        for (Card *openCard in self.cards){
                            if (openCard.isChosen && !openCard.isMatched){
                                openCard.matched = YES;
                                card.matched = YES;
                            }
                        }
                        
                        card.chosen = YES;
                        break;
                    }
                    
                    

           /*       int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        //otherCard.chosen = NO;
                        
                        if (self.cardCount>=3){
                            self.cardCount=0;
                            
                            for (Card *openCard in self.cards){
                                if (openCard.isChosen && !openCard.isMatched){
                                    openCard.Chosen = NO;
                                }
                            }
                            
                            card.chosen = YES;
                            break;
                        }
                        
                    } */
                    
                                    }
            }            
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    
    
    }
    
}


@end
