//
//  ViewController.m
//  线程状态
//
//  Created by 芦小婷 on 2018/3/20.
//  Copyright © 2018年 芦小婷. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"走");
    
//    [NSThread exit];
//    [self threadDemo];
    [self exitDemo];
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

- (void)threadDemo{
   
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
