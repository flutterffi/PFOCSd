#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *tasks = @[@"review ARC", @"study blocks", @"practice protocols"];
        NSMutableArray<NSString *> *formatted = [NSMutableArray array];

        [tasks enumerateObjectsUsingBlock:^(NSString *task, NSUInteger idx, BOOL *stop) {
            [formatted addObject:[NSString stringWithFormat:@"%lu. %@", (unsigned long)(idx + 1), task]];
        }];

        NSPredicate *filter = [NSPredicate predicateWithBlock:^BOOL(NSString *task, NSDictionary<NSString *, id> *bindings) {
            return [task containsString:@"practice"] || [task containsString:@"study"];
        }];

        NSLog(@"formatted -> %@", formatted);
        NSLog(@"focused -> %@", [tasks filteredArrayUsingPredicate:filter]);
    }
    return 0;
}
