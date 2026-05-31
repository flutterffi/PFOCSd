#import "PFTaskStore.h"

@implementation PFTaskStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _tasks = [NSMutableArray array];
    }
    return self;
}

- (void)addTask:(NSString *)task {
    [self.tasks addObject:task];
    if (self.changeHandler != nil) {
        self.changeHandler([NSString stringWithFormat:@"%@ now tracks %lu task(s)",
                            self.name,
                            (unsigned long)self.tasks.count]);
    }
}

@end

PFTaskStore *PFMakeTaskStore(void) {
    PFTaskStore *store = [[PFTaskStore alloc] init];
    store.name = [NSMutableString stringWithString:@"weekly plan"];
    return store;
}
