//
//  ViewController.m
//  Day21XMPP
//
//  Created by tarena on 15-4-10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "XMPPFramework.h"
@interface ViewController ()<XMPPStreamDelegate>
@property (nonatomic, strong)XMPPStream *xmppStream;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.xmppStream = [[XMPPStream alloc]init];
//    设置delegate
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    设置服务器地址
//    172.60.5.100   124.207.192.18
    [self.xmppStream setHostName:@"124.207.192.18"];
//    设置端口
    [self.xmppStream setHostPort:5222];
//    设置当前用户
    NSString *name = [NSString stringWithFormat:@"%@@tarena.com",@"1412liuguobin"];
    XMPPJID *jid = [XMPPJID jidWithString:name];
    [self.xmppStream setMyJID:jid];
//    连接服务器
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
    
}

-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"已经连接");
    //登录授权
    [self.xmppStream authenticateWithPassword:@"aaaaaaaa" error:nil];
    
    
}
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"断开连接");
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登录成功");
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"登录失败");
    //注册
    [self.xmppStream registerWithPassword:@"aaaaaaaa" error:nil];
}

-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功！");
    [self.xmppStream authenticateWithPassword:@"aaaaaaaa" error:nil];
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败");
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
