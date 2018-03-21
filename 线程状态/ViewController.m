//
//  ViewController.m
//  线程状态
//
//  Created by 芦小婷 on 2018/3/20.
//  Copyright © 2018年 芦小婷. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,assign)int tickets;

/** 锁  */
@property(nonatomic,strong)NSObject * lockObjc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lockObjc = [NSObject new];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"走");
    
//    [NSThread exit];
//    [self threadDemo];
//    [self exitDemo];
//    [self threadDemo1];
    self.tickets = 20;
    NSThread *t1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicks) object:nil];
    t1.name = @"售票员 A";
    [t1 start];
    
    NSThread *t2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicks) object:nil];
    t2.name = @"售票员 B";
    [t2 start];
}

- (void)saleTicks{
    while (YES) {
        
        [NSThread sleepForTimeInterval:1.0];
        //互斥锁 -保证锁内的代码，同一时间，只有一条线程执行
        //互斥锁它的范围,应该尽量小,锁范围越大,效率越低!
        //参数:就是能够加锁的任意 NSOjbect 对象
        //局部变量: 每个线程单独拥有的,无法锁住!!
        //注意: 锁一定要是所有线程共享的对象!!
        //        NSObject * lockObj = [[NSObject alloc]init];
        @synchronized(self.lockObjc)
        {
            //1，判断是否有票
            if (self.tickets > 0)
            {
                //如国有就卖出一张
                self.tickets--;
                
                NSLog(@"剩下%d涨票  %@",self.tickets,[NSThread currentThread]);
                
            }else
            {
                //3.如果没有了，提示用户
                NSLog(@"卖完了！%@",[NSThread currentThread]);
                break;
            }
        }
        
        
    }
}




- (void)threadDemo1{
    NSThread *t = [[NSThread alloc]initWithTarget:self selector:@selector(test) object:nil];
    //优先级 从0.0 -- 1.0 默认值 0.5
    t.threadPriority = 0.1;
    
    /**
     优先级 只是保证CPU调度的可能性会高！
     多线程的目的：将耗时操作放在后台，不阻塞UI线程
     */
}

- (void)test{
    for (int i = 0; i < 20; i++) {
        NSLog(@"%@ %d",[NSThread currentThread],i);
    }
}



- (void)exitDemo
{
    [self performSelectorInBackground:@selector(startMainThreda) withObject:nil];
    
    ////注意：exit会杀掉主线程，但是APP不会挂掉！
    [NSThread exit];
}

- (void)startMainThreda
{
    [NSThread sleepForTimeInterval:1.0];
    //开启主线程
    [[NSThread mainThread]start];
}

-(void)threadDemo{
   
    //创建线程
    NSThread *t = [[NSThread alloc]initWithTarget:self selector:@selector(theadStatue) object:nil];
    
    //线程就绪状态(CPU翻牌)
    [t start];
}

- (void)theadStatue{
    
    //阻塞，当运行满足某个条件，会让线程“睡一会”
    // 提示：sleep方法是类方法，会直接休眠当前线程!!
//    NSLog(@"睡一会儿");
//    [NSThread sleepForTimeInterval:2.0];//(睡的是t线程，因为t线程在alloc)
//    for (int i = 0; i < 20; i++)
//    {
//        NSLog(@"%@   %d",[NSThread currentThread],i);
//    }
    
    
    for (int i = 0; i < 20; i++)
    {
        if (i == 8)
        {
            NSLog(@"睡一会儿");
            [NSThread sleepForTimeInterval:2.0];//(睡的是t线程，因为t线程在alloc)
        }
        NSLog(@"%@   %d",[NSThread currentThread],i);
   //当线程满足某一个条件时，可以强行终止的
        //exit类方法，可以终止当前线程
        if (i == 15) {
            //一旦强制终止线程，后续的所有的代码都不会被执行
            // 注意：在终止线程执行，应该释放之前分配的对象
            [NSThread exit];
        }
    
    }
    
    NSLog(@"能来吗？");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
