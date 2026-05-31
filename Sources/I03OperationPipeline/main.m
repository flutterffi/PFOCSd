#import <Foundation/Foundation.h>
#import "PFPipelineStep.h"

int main(void) {
    @autoreleasepool {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;

        PFPipelineStep *load = [[PFPipelineStep alloc] initWithName:@"load"];
        PFPipelineStep *score = [[PFPipelineStep alloc] initWithName:@"score"];
        PFPipelineStep *render = [[PFPipelineStep alloc] initWithName:@"render"];

        NSBlockOperation *loadOperation = [load operationWithLogMessage:@"load lesson metadata"];
        NSBlockOperation *scoreOperation = [score operationWithLogMessage:@"score lesson difficulty"];
        NSBlockOperation *renderOperation = [render operationWithLogMessage:@"render final lesson summary"];

        [scoreOperation addDependency:loadOperation];
        [renderOperation addDependency:scoreOperation];

        [queue addOperations:@[loadOperation, scoreOperation, renderOperation] waitUntilFinished:YES];

        // Practice idea: add a fourth step and redesign the dependency graph.
    }
    return 0;
}
