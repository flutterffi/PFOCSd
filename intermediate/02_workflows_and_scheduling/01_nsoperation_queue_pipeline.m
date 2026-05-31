#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;

        NSBlockOperation *load = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"load lesson metadata");
        }];

        NSBlockOperation *score = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"score lesson difficulty");
        }];

        NSBlockOperation *render = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"render final lesson summary");
        }];

        [score addDependency:load];
        [render addDependency:score];

        [queue addOperations:@[load, score, render] waitUntilFinished:YES];
    }
    return 0;
}
