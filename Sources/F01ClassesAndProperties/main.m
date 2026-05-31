#import <Foundation/Foundation.h>
#import "PFStudyCard.h"

int main(void) {
    @autoreleasepool {
        PFStudyCard *card = [[PFStudyCard alloc] initWithTitle:@"classes and properties"
                                                    difficulty:2];
        NSLog(@"%@", [card summary]);
    }
    return 0;
}
