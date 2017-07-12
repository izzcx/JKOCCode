//
//  JKQRCodeCreateObject.m
//  JKOCCode
//
//  Created by silence on 2017/3/7.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JKQRCodeCreateObject.h"

@implementation JKQRCodeCreateObject

+ (UIImage *)createQRCodeImageWithString:(NSString *)codeString{
    
    NSError *error = nil;
    ZXEncodeHints *hints = [ZXEncodeHints hints];
    hints.errorCorrectionLevel = [ZXQRCodeErrorCorrectionLevel errorCorrectionLevelH];
    hints.encoding =  NSUTF8StringEncoding;// 加上这两句，可以用中文了
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    
    ZXBitMatrix* result = [writer encode:codeString
                                  format:kBarcodeFormatQRCode
                                   width:300
                                  height:300
                                   hints:hints
                                   error:&error];
    UIImage * qrCodeImage = nil;
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        qrCodeImage = [UIImage imageWithCGImage:image];
        UIImage *subIamge = [UIImage imageNamed:@"jkoccode.jpeg"];
       // qrCodeImage = [UIImage imageInsertedImage:qrCodeImage insertImage:subIamge radius:5];
       
    } else {
        NSString *errorMessage = [error localizedDescription];
        JY_Log(@"%@",errorMessage);
    }
    
    return qrCodeImage;
}





@end
