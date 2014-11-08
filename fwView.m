//
//  fwView.m
//  Russia Online
//
//  Created by 刘 吕琴 on 13-12-21.
//  Copyright (c) 2013年 Jiayi. All rights reserved.
//

#import "fwView.h"
#import "MainTabarController.h"
@interface fwView ()

@end

@implementation fwView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//      self.view.backgroundColor=[UIColor redColor];
   
    hideTabbar
    
      [self.navigationItem setNewTitle:@"服务条例"];
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight+49)];
    webView.backgroundColor=[UIColor clearColor];
        webView.scrollView.bounces=YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
        webView.frame=CGRectMake(0, 0, 320, DeviceHeight+49);
        
        
        
    }

   
    [self.view addSubview:webView];
    NSString*str1=@"一、特别提示";
    NSString *htmlString1=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str1];
    
    
    NSString*str2=@"  1. 为获得www.Russia-Online.cn （以下简称“俄罗斯旅游中文网”)提供基于移动设备的互联网相关服务，服务使用人(以下称“用户”)必须同意本协议的全部条款。如果用户在安装后使用本软件即表示用户完全接受本协议项下的全部条款。   ";
    NSString *htmlString2=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str2]];
    NSString*str3=@"二、服务内容";
    NSString *htmlString3=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str3];
    NSString*str4=@"1. 俄罗斯旅游中文网服务的具体内容由俄罗斯旅游中文网根据实际情况提供，例如旅游攻略信息服务、酒店预定服务、位置查询服务等。俄罗斯旅游中文网保留随时变更、中断或终止部分或全部服务的权利。\n\n    2. 俄罗斯旅游中文网仅提供相关的网络服务，除此之外与相关网络服务有关的设备(如移动终端与接入互联网有关的装置)及所需的费用(如为接入互联网而支付的电话费及上网费)均应由用户自行负担。";
    NSString *htmlString4=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",str4];

    NSString*str5=@"三、使用规则";
    NSString *htmlString5=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str5];
        NSString*str6=@" 1. 用户在申请使用俄罗斯旅游中文网服务时，必须向俄罗斯旅游中文网提供准确的个人资料，如个人资料有任何变动，必须及时更新。\n\n    2. 用户注册成功后，用户应当对以其用户帐号进行的所有活动和事件负法律责任。\n\n    . 用户必须同意接受俄罗斯旅游中文网通过电子邮件或其他方式向用户发送广告或其他相关商业信息。\n\n    4. 用户在使用俄罗斯旅游中文网服务过程中，必须遵循以下原则：\n\n    a. 遵守中华人民共和国相关法律法规，包括但不限于《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》、《最高人民法院关于审理涉及计算机网络著作权纠纷案件适用法律若干问题的解释(法释[2004]1号)》、《互联网著作权行政保护办法》和《信息网络传播权保护条例》等有关计算机互联网规定和知识产权的法律和法规、实施办法；\n\n    b. 用户承诺对其上传或者发表于俄罗斯旅游中文网的所有信息(即属于《中华人民共和国著作权法》规定的作品，包括但不限于文字、图片、音乐、电影、表演和录音录像制品和电脑程序等)均享有完整的知识产权，或者已经得到相关权利人的合法授权;如用户违反本条规定造成俄罗斯旅游中文网被第三人索赔的，用户同意全额补偿俄罗斯旅游中文网(包括但不限于各种赔偿费用和律师费)；\n\n    c. 当第三方认为用户上传或者发表于俄罗斯旅游中文网的信息侵犯其权利，并根据《信息网络传播权保护条例》或者相关法律规定向俄罗斯旅游中文网发送权利通知书时，用户同意俄罗斯旅游中文网可以自行判断决定删除涉嫌侵权的用户上传或者发表于俄罗斯旅游中文网的信息，除非收到符合相关法律规定的书面说明，俄罗斯旅游中文网将不会自动恢复上述删除的信息；\n\n    d. 不得为任何非法目的而使用网络服务系统；\n\n    e. 遵守所有与网络服务有关的网络协议、规定和程序；\n\n    f. 不得利用俄罗斯旅游中文网服务进行任何可能对互联网的正常运转造成不利影响的行为；\n\n    g. 不得利用俄罗斯旅游中文网服务传输任何骚扰性的、中伤他人的、辱骂性的、恐吓性的、庸俗淫秽的或其他任何非法的信息资料；\n\n    h. 不得利用俄罗斯旅游中文网服务进行任何不利于俄罗斯旅游中文网的行为；\n\n    i. 如发现任何非法使用用户帐号或帐号出现安全漏洞的情况，应立即通告俄罗斯旅游中文网网站方。";
    NSString *htmlString6=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str6]];
    NSString*str7=@"四、内容所有权";
    NSString *htmlString7=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str7];
    NSString*str8=@"1. 用户在俄罗斯旅游中文网上发布的信息内容由用户及俄罗斯旅游中文网共同所有，任何其它组织或个人未经用户本人援权同意，不得擅自复制、转载、擅改其内容。\n2. 用户通过发布在俄罗斯旅游中文网上的内容包括但不限于图片、文字、音频、视频及操作日志等，俄罗斯旅游中文网有权在本站及合作者网站上使用。";
      NSString *htmlString8=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str8]];
    NSString*str9=@"五、隐私保护";
    NSString *htmlString9=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str9];
    NSString*str10=@" 　　1. 保护用户隐私是俄罗斯旅游中文网的重点原则，俄罗斯旅游中文网保证不对外公开或向第三方提供用户注册资料及用户在使用服务时存储在俄罗斯旅游中文网的非公开内容，但下列情况除外：\na. 事先获得用户的明确授权;\nb. 根据有关的法律法规要求;\nc. 按照相关政府主管部门的要求;\nd. 为维护社会公众的利益;\ne. 为维护俄罗斯旅游中文网的合法权益。\n2. 俄罗斯旅游中文网可能会与第三方合作向用户提供相关的服务，在此情况下，如该第三方同意承担与俄罗斯旅游中文网同等的保护用户隐私的责任，则俄罗斯旅游中文网可将用户的注册资料等提供给该第三方。\n3. 在不透露单个用户隐私资料的前提下，俄罗斯旅游中文网有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。";
    NSString *htmlString10=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str10]];
    NSString*str11=@"六、免责声明";
    NSString *htmlString11=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str11];
    NSString*str12=@"   1. 用户明确同意其使用俄罗斯旅游中文网服务所存在的风险将完全由其自己承担；因其使用俄罗斯旅游中文网服务而产生的一切后果也由其自己承担，俄罗斯旅游中文网对用户不承担任何责任。\n\n    ** 举例说明：俄罗斯旅游中文网尽可能地保持所提供资讯的有效性，但俄罗斯旅游中文网不对用户在使用俄罗斯旅游中文网服务过程中造成的直接或间接损失负责，包括但不限于信息错误、旅程延误等。\n\n    2. 俄罗斯旅游中文网不保证服务一定能满足用户的要求，也不保证服务不会中断，对服务的及时性、安全性、准确性也都不作保证。";
    NSString *htmlString12=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str12]];
    NSString*str13=@"七、服务变更、中断或终止";
    NSString *htmlString13=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str13];
    NSString*str14=@"  1. 如因系统维护或升级的需要而需暂停网络服务，俄罗斯旅游中文网将尽可能事先在重要页面进行通告。\n\n    2. 如发生下列任何一种情形，俄罗斯旅游中文网有权随时中断或终止向用户提供服务而无需通知用户：\n\n    a. 用户提供的个人资料不真实；\n\n    b. 用户违反本协议中规定的使用规则。\n\n    3. 除前款所述情形外，俄罗斯旅游中文网同时保留在不事先通知用户的情况下随时中断或终止部分或全部服务的权利，对于所有服务的中断或终止而造成的任何损失，俄罗斯旅游中文网无需对用户或任何第三方承担任何责任。";
    NSString *htmlString14=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str14]];
    NSString*str15=@"八、违约赔偿";
    NSString *htmlString15=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad1\">%@</div>",str15];
    NSString*str16=@" 1.  1. 用户同意保障和维护俄罗斯旅游中文网及其他用户的利益，如因用户违反有关法律、法规或本协议项下的任何条款而给俄罗斯旅游中文网或任何其他第三人造成损失，用户同意承担由此造成的损害赔偿责任。";
    NSString *htmlString16=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str16]];
    NSString*str17=@"九、修改协议";
    NSString *htmlString17=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str17];
    NSString*str18=@"   1. 俄罗斯旅游中文网将可能不时的修改本协议的有关条款，一旦条款内容发生变动，俄罗斯旅游中文网将会在相关的页面提示修改内容。\n\n    2. 如果不同意俄罗斯旅游中文网对服务条款所做的修改，用户有权停止使用俄罗斯旅游中文网服务。如果用户继续使用服务，则视为用户接受服务条款的变动。";
    NSString *htmlString18=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str18]];
    NSString*str19=@"十、法律管辖";
    NSString *htmlString19=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str19];
    NSString*str20=@"  1. 本协议的订立、执行和解释及争议的解决均应适用中国法律。\n\n    2. 如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向俄罗斯旅游中文网所在地的人民法院提起诉讼。";
    NSString *htmlString20=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str20]];
    NSString*str21=@"十一、通知和送达";
    NSString *htmlString21=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str21];
    NSString*str22=@"  1. 本协议项下所有的通知均可通过重要页面公告、电子邮件或常规的信件传送等方式进行；该等通知于发送之日视为已送达收件人。";
    NSString *htmlString22=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str22]];
    NSString*str23=@"十二、其他规定";
    NSString *htmlString23=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str23];
    NSString*str24=@"   1. 本协议构成双方对本协议之约定事项及其他有关事宜的完整协议，除本协议规定的之外，未赋予本协议各方其他权利。\n\n    2. 如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。\n\n    3. 本协议中的标题仅为方便而设，在解释本协议时应被忽略。";
    NSString *htmlString24=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str24]];
    NSString*str25=@"十三、本协议解释权归俄罗斯旅游中文网所有。";
    NSString *htmlString25=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str25];
    NSString *htmlStrAll;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
        htmlStrAll=[[NSString alloc] initWithFormat:@"<html><head><title></title></head><link rel=\"stylesheet\" href=\"web.css\" type=\"text/css\"/><body>%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@<br><br><br><br><br><br></body></html>",htmlString1,htmlString2,htmlString3,htmlString4,htmlString5,htmlString6,htmlString7,htmlString8,htmlString9,htmlString10,htmlString11,htmlString12,htmlString13,htmlString14,htmlString15,htmlString16,htmlString17,htmlString18,htmlString19,htmlString20,htmlString21,htmlString22,htmlString23,htmlString24,htmlString25];

        
        
        
    }
    else
    {

    htmlStrAll=[[NSString alloc] initWithFormat:@"<html><head><title></title></head><link rel=\"stylesheet\" href=\"web.css\" type=\"text/css\"/><body>%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@<br><br><br><br></body></html>",htmlString1,htmlString2,htmlString3,htmlString4,htmlString5,htmlString6,htmlString7,htmlString8,htmlString9,htmlString10,htmlString11,htmlString12,htmlString13,htmlString14,htmlString15,htmlString16,htmlString17,htmlString18,htmlString19,htmlString20,htmlString21,htmlString22,htmlString23,htmlString24,htmlString25];
    }
    //    NSString*str3=@"<#string#>"
    
    NSString *path=[[NSBundle mainBundle] bundlePath];
    NSURL *baseURL=[NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlStrAll baseURL:baseURL];

    UIScrollView*scrlloView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight+44)];
    scrlloView.contentSize=CGSizeMake(320, 4135-30-20-10-10+70);
    scrlloView.bounces=NO;
//    [self.view addSubview:scrlloView];
    
    
   

    // Do any additional setup after loading the view from its nib.
}

backButton
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
 
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
