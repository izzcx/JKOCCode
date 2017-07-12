
//
//  GCDViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"GCD";
    // Do any additional setup after loading the view.
    
    //barrier
//    [self barrierFunction];
    
    [self dispatchBarrierfuncation];
    
    //group
    
    //after
    
    //notify
    
    //time
    
    //
    
//    [self syncConcurrent];
}

- (void)barrierFunction{
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    NSLog(@"disp2");
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
    
    NSLog(@"disp5stsart");
    dispatch_barrier_sync(concurrentQueue, ^{
        NSLog(@"dispath-5");
    });
    NSLog(@"disp5end");
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-7");
    });
    
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-8");
    });
    
    //dispatch_barrier_async 和 dispatch_barrier_sync 的不同在于一个是异步一个是同步
    //dispatch_barrier_async 它的异步特性体现在将任务插入队列的过程，它的等待特性体现在任务真正执行的过程
    //dispatch_barrier_sync 它的同步特性体现在将任务插入队列的过程，它的等待特性体现在把任务插入队列的的过程
}

-(void)syncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"---start---");
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
}


/*
 dispatch_barrier_async 作用是在并行队列中，等待前面两个操作并行操作完成，这里是并行输出
 dispatch-1，dispatch-2
 然后执行
 dispatch_barrier_async中的操作，(现在就只会执行这一个操作)执行完成后，即输出
 "dispatch-barrier，
 最后该并行队列恢复原有执行状态，继续并行执行
 dispatch-3,dispatch-4
 */

- (void)dispatchBarrierfuncation{
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
