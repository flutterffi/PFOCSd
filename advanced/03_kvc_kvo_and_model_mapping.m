#import <Foundation/Foundation.h>

@interface PFProfile : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger streakDays;
@property (nonatomic, strong) NSMutableArray<NSString *> *focusTopics;
@end

@implementation PFProfile

- (instancetype)init {
    self = [super init];
    if (self) {
        _focusTopics = [NSMutableArray array];
    }
    return self;
}

@end

@interface PFProfileObserver : NSObject
@end

@implementation PFProfileObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
    NSLog(@"KVO change on %@ -> %@", keyPath, change[NSKeyValueChangeNewKey]);
}

@end

static PFProfile *profileFromDictionary(NSDictionary<NSString *, id> *payload) {
    PFProfile *profile = [[PFProfile alloc] init];
    [profile setValuesForKeysWithDictionary:payload];
    return profile;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary<NSString *, id> *payload = @{
            @"name": @"Plato",
            @"streakDays": @12,
            @"focusTopics": [@[@"runtime", @"memory", @"concurrency"] mutableCopy]
        };

        PFProfile *profile = profileFromDictionary(payload);
        PFProfileObserver *observer = [[PFProfileObserver alloc] init];

        [profile addObserver:observer
                  forKeyPath:@"streakDays"
                     options:NSKeyValueObservingOptionNew
                     context:nil];

        NSLog(@"profile name via KVC -> %@", [profile valueForKey:@"name"]);
        NSLog(@"first topic via key path -> %@", [profile valueForKeyPath:@"focusTopics.@firstObject"]);

        profile.streakDays = 13;
        [[profile mutableArrayValueForKey:@"focusTopics"] addObject:@"api design"];

        NSLog(@"topics after mutation -> %@", profile.focusTopics);

        [profile removeObserver:observer forKeyPath:@"streakDays"];
    }
    return 0;
}
