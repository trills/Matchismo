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

@property (nonatomic, readwrite) BOOL matchSuccess; //

@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSArray *chosenCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSArray alloc] init];
    return _chosenCards;
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
    int matchScore = 0;
    
    if (!card.isMatched) { // if false (card is matched) ==> card is not matched
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            // we match after picking every card because we need to know if the cards are matching between each other, not just between
            // the latest card and all other cards.
            
            //let's build an array of chosencards
            
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isChosen && !otherCard.isMatched){
                    
                    self.chosenCards = [self.chosenCards arrayByAddingObject:otherCard];
                    
                    matchScore = [card match:self.chosenCards];
                    if (matchScore) {

                        self.matchSuccess = TRUE;
                    }
                    
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            
            
            
            if (self.cardCount>=3){
                self.cardCount=0;
                
                // 1) as long as a match occurred, we should just "disable" all 3 cards
                // 2) if no match occurred, we need to flip all 3 cards back
                for (Card *openCard in self.chosenCards){
                    
                    openCard.matched = self.matchSuccess;
                    openCard.chosen = self.matchSuccess;
                    
                }
                
                card.matched = self.matchSuccess;
                card.chosen = self.matchSuccess;
                
                if (self.matchSuccess){ self.score += matchScore * MATCH_BONUS; }
                else { self.score -= MISMATCH_PENALTY; }
                
                self.matchSuccess = FALSE;
                self.chosenCards = [[NSArray alloc] init];
                
            }
            else {
                card.chosen = YES;
            }
            
        }
        
        
    }
    
}



@end
