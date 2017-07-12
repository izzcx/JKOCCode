//
//  RunTimeViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "RunTimeViewController.h"
#import "Person.h"
#import "RowObject.h"

@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

+ (void)load{
    [super load];
    SEL swizzleSel = NSSelectorFromString(@"beforeViewDidLoad");
    SEL originSel = NSSelectorFromString(@"viewDidLoad");
    Class cls = NSClassFromString(@"RunTimeViewController");
    Method originMethod = class_getInstanceMethod(cls, originSel);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSel);
    //    IMP originIMP = method_getImplementation(originMethod);
    //    IMP swizzleIMP = method_getImplementation(swizzleMethod);
    method_exchangeImplementations(originMethod, swizzleMethod);
    
    SEL testSel = NSSelectorFromString(@"testmethod");
    Method testMethod = class_getClassMethod(cls, testSel);
    
    const char *originType = method_getTypeEncoding(originMethod);
    const char *swizzleType = method_getTypeEncoding(swizzleMethod);
    const char *testType = method_getTypeEncoding(testMethod);
    
    NSLog(@"----method type --- %s -- %s -- %s",originType,swizzleType,testType);
    // SwizzlingMethod(self, originSel, swizzleSel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Runtime";
    NSLog(@"viewDidLoad---");
    
    objc_msgSend((id)objc_getClass("UIButton"), sel_registerName("buttonWithType:"), (UIButtonType)UIButtonTypeCustom);
    
    
    Person *person = [Person new];
    person.name = @"jack";
    person.age = @"12";
    person.address = @"中国";
    
    RowObject *obejct = [[RowObject alloc] init];
    obejct.rowKey = @"age";

    obejct.content = [person valueForKey:obejct.rowKey];
    
    NSLog(@"RowObject----- %@",obejct.content);
    
}

- (void)dowathIdwantdo{
    
 //   ((void(*)(id, SEL, id))objc_msgSend)(self, sel_registerName("buttonWithType:"), @"test");
//    void (*action)(id, SEL, int) = (void (*)(id, SEL, int))objc_msgSend;
//    action(self, @selector(doSomething:), 0);
}

- (int)doSomething:(int) x{
    
    return 0;
}

- (void) doSomethingElse {
  
    JY_Log(@"打印一下");
}

-(void)beforeViewDidLoad{
    NSLog(@"beforeViewDidLoad---");
    [self beforeViewDidLoad];
}

+ (void)testmethod{
    
    
}

void SwizzlingMethod(Class cls,SEL originSEL,SEL swizzledSEL){
    Method originMethod = class_getInstanceMethod(cls, originSEL);
    Method swizzledMethod = nil;
    if (!originMethod) {
        //deal generic method
        originMethod  =  class_getClassMethod(cls, originSEL);
        if (!originMethod) {
            return;
        }
        swizzledMethod = class_getClassMethod(cls, swizzledSEL);
        if (! swizzledMethod) {
            return;
        }
        
    }else{
        //deal instance method
        swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
        if (!swizzledMethod) {
            return;
        }
    }
    
    if (class_addMethod(cls, originSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        //with is own will failure , direct exchange
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        
    }else{
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
    
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
