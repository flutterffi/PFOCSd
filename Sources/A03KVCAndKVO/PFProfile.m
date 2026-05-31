#import "PFProfile.h"

@implementation PFProfile

- (instancetype)init {
    self = [super init];
    if (self) {
        _focusTopics = [NSMutableArray array];
    }
    return self;
}

@end

@implementation PFProfileObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
    NSLog(@"KVO change on %@ -> %@", keyPath, change[NSKeyValueChangeNewKey]);
}

@end

PFProfile *PFProfileFromDictionary(NSDictionary<NSString *, id> *payload) {
    PFProfile *profile = [[PFProfile alloc] init];
    [profile setValuesForKeysWithDictionary:payload];
    return profile;
}
