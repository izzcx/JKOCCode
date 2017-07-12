//
//  QRScanViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/9.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "QRScanViewController.h"
#import "ScanZoneView.h"

#define SCANWH 258.0
#define SCANY  165.0
#define SCANX  58.0

@interface QRScanViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) ScanZoneView *scanZoneView;
@property (nonatomic, assign) CGRect scanRect;

@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanRect = CGRectMake(SCANX, SCANY, SCANWH, SCANWH);
    [self configureAVCapureInOut];
    [self.view addSubview:self.scanZoneView];
    [self startScanQRCode];
}

- (ScanZoneView *)scanZoneView{
    if (!_scanZoneView) {
        _scanZoneView = [[ScanZoneView alloc] initWithFrame:self.view.bounds
                                                  scanFrame:self.scanRect];
    }
    return _scanZoneView;
}

- (AVCaptureSession *)captureSession{
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
    }
    return _captureSession;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    return _previewLayer;
}

//配置扫描的AV输入输出环境
- (void)configureAVCapureInOut{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:(id)self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    
    // 这个地方需要灵活一些
    CGFloat scanx = self.scanRect.origin.x/SCREENWIDTH;
    CGFloat scany = self.scanRect.origin.y/SCREENHEIGHT;
    CGFloat scanWidth = self.scanRect.size.width/SCREENWIDTH;
    CGFloat scanHeight = self.scanRect.size.height/SCREENHEIGHT;

    output.rectOfInterest = CGRectMake(scanx, scany, scanWidth, scanHeight);
    
    // 5、初始化链接对象（会话对象）
    // 高质量采集率
    //session.sessionPreset = AVCaptureSessionPreset1920x1080; // 如果二维码图片过小、或者模糊请使用这句代码，注释下面那句代码
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 5.1 添加会话输入
    [self.captureSession addInput:input];
    
    // 5.2 添加会话输出
    [self.captureSession addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
                                   //, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

//开始扫描
- (void)startScanQRCode{
    if (!self.captureSession.isRunning || self.captureSession.isInterrupted ) {
        [self.captureSession startRunning];
    }
}

//停止扫描
- (void)stopScanQRCode{
    if (self.captureSession.isRunning) {
        [self.captureSession stopRunning];
    }
}


// 调用代理方法，会频繁的扫描
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 0、扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    
    // 1、如果扫描完成，停止会话
    [self stopScanQRCode];
    
    // 2、删除预览图层
   // [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"metadataObjects = %@", metadataObjects);
        if ([obj.stringValue hasPrefix:@"http"]) {
            
        } else { // 扫描结果为条形码

        }
    }
}


#pragma mark - - - 扫描提示声
/** 播放音效文件 */
- (void)playSoundEffect:(NSString *)name{
    // 获取音效
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    NSLog(@"播放完成...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
