#import <Foundation/Foundation.h>

@interface PFTaskStore : NSObject
@property (nonatomic, strong) NSMutableArray<NSString *> *tasks;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^changeHandler)(NSString *message);
- (void)addTask:(NSString *)task;
@end

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

static PFTaskStore *makeStore(void) {
    PFTaskStore *store = [[PFTaskStore alloc] init];
    store.name = [NSMutableString stringWithString:@"weekly plan"];
    return store;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PFTaskStore *store = makeStore();

        NSMutableString *mutableInput = [NSMutableString stringWithString:@"draft title"];
        store.name = mutableInput;
        [mutableInput appendString:@" changed outside"];

        NSLog(@"copied property keeps value stable -> %@", store.name);

        __weak PFTaskStore *weakStore = store;
        store.changeHandler = ^(NSString *message) {
            NSLog(@"%@", message);
            NSLog(@"weak reference available -> %@", weakStore.name);
        };

        [store addTask:@"practice ARC rules"];
        [store addTask:@"review block capture"];

        NSString *(^formatter)(NSString *) = ^NSString *(NSString *task) {
            return [NSString stringWithFormat:@"[%@] %@", store.name, task];
        };

        NSLog(@"%@", formatter(@"check retain-cycle patterns"));
    }
    return 0;
}
