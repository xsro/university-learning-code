#include<stdio.h>
#include<time.h>
#include<stdlib.h>
#include<string.h>
#include<conio.h>
//�궨��
#define N_seat 3 
#define N_station 6 
#define N_rail 10
#define N_rec 12
#define N_user 10
#define YEAR   2019
#define N_password 20
#define N_train 1000
//����ṹ��
typedef struct User  //�û������Ա��Ϣ 
{
	char name[20];//�˺��� 
	char password[N_password];//���� 
	char realname[20];//��ʵ���� 
	int number;//���֤�� 
	int identity;  //��ݣ�ʹ��1��ʾ��ͨ�û���2��ʾ����Ա��3��ʾVIP 0��ʾ�Ƿ��û� ,4��ʾ�οͣ� 
}User; 
typedef struct time  //����ʱ�� �ṹ�� 
{
	int year;
	int month;
	int day;
	int hour;
	int minute;
}Time;
typedef struct station//�洢վ����Ϣ 
{
	char name[40];//վ������ 
	int a;//�г���վʱ�� 
	int b;//�г��뿪վ���ʱ�� 
	int price[N_seat]; //����������λ�ļ۸� 
}Station;
typedef struct rail
{
	char type;//���� 
    int  number;//��·��� 
    int n_station;//������վ������ 
	int n_seat;//֧�ֵ���λ�������� 
	struct station sta[N_station];//վ����Ϣ 
	int tt;//��Ʊ�� 
}Rail;
typedef struct train{
	int no; //���б�� 
	char type;//���� 
	int number;//·�߱�� 
	int t;//ʼ��ʱ�� 
	int bt;//�Ѿ�������Ʊ�� 
	int tt;//��Ʊ�� 
//	int ticket[N_seat];
//	int total[N_seat];
}Train;
typedef struct record//��¼�˳���Ϣ�Ľṹ�� 
{
	char name[40];//�˿͵����֤������ 
	int No;//��· 
	int station1;//����վ 
	int station2; //����վ�� 
	int t1;//�𳵵��������ʱ�� 
	int t2;	//�𳵵���Ŀ�ĵ�ʱ�� 
	char sta1[20];
	char sta2[20];
}Rec;
//�ṹ�崦���� 
Time timeGet(int i)//iΪ0ʱ��ȡ��ǰʱ�䣬Ϊ1ʱ�Ӽ��̻�ȡʱ�� ,2�������������� ,3��ȡ��ǰ������ ��4������ʱ�� 
{
	Time a;
	time_t timep; 
	struct tm *p;
	time (&timep);  
    p=gmtime(&timep);
	if(i==0)
	{
	 a.minute=p->tm_min;
	 a.hour=8+p->tm_hour;
	 a.month=1+p->tm_mon;
	 a.year=1900+p->tm_year;
	 a.day=p->tm_mday;	
	}
	 if(i==1)
	 {
	 	printf("\t�밴��x��x��x�� xʱx�ֵ���ʽ�����Ӧ������\n\t");scanf("%d%d%d%d%d",&a.year,&a.month,&a.day,&a.hour,&a.minute);
	 }
	 if(i==2) 
	 {
	 	a.minute=0;a.hour=0;
		printf("\t�밴��x��x��x�� ����ʽ�����Ӧ������\n\t");
		scanf("%d%d%d",&a.year,&a.month,&a.day);
	 }
	 if(i==3)
	 {
	 	a.minute=0;a.hour=0;
	 	a.month=1+p->tm_mon;
		a.year=1900+p->tm_year;
		a.day=p->tm_mday;	
	 }
	 if(i==4)
	 {
	 	a.year=YEAR;a.month=1;
	 	printf("\t�밴��x�� xʱx�ֵ���ʽ�����Ӧ������\n\t");scanf("%d%d%d",&a.day,&a.hour,&a.minute);
	 }
	 return a;
}
int time2min(Time t)
{
	long m;
	int i,d=0,a,ai,b[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
	a=t.year;
	if((a%4==0&&a%100!=0)||(a%400==0)) b[2]=29;
	for (i=YEAR;i<t.year;i++)
	{
			if((i%4==0&&i%100!=0)||(i%400==0)) d+=366;
			else d+=365;
	}
	for(i=1;i<t.month;i++) d+=b[i];
	m=((d-1+t.day)*24+t.hour)*60+t.minute;
	return m; 
}
Time time_min2(int m)//min=(((y*365+m*30)+d)*24+h)*60+min
{
	Time a;
	int d,b=0,c=0;
	int i,j,md[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
	a.minute=m%60;
	a.hour=m/60%24;
	d=m/60/24;
	for(j=0;;j++)
	{
		i=YEAR+j;
		if((i%4==0&&i%100!=0)||(i%400==0)) b=366;
		else b=365;
		if(c<=d&&c+b>=d)break;
		c+=b;
	}
	a.year=i;
	if((i%4==0&&i%100!=0)||(i%400==0))md[2]=29;
	d-=c;//��һ���е������� 
	c=0;b=0;
	for(j=1;j<=12;j++)
	{
		b=md[j];
		if(c<=d&&c+b>d)break;
		c+=b;
	}
	a.month=j;
	a.day=d+1-c;
	return a;	
}
int autotrain(Rail r,int sum,Train t[],int info[])//�Զ����� 
{
	int m;Train tr;int i,j,k;
	m=info[3];k=info[3]-1;
	for(i=m;i<m+sum;i++)
	{
		tr.type=r.type;
		tr.number=r.number;
		tr.no=k+1;
		tr.t=time2min(timeGet(3))+(i-m)*1440;
		tr.tt=r.tt;
		tr.bt=0;
		for(j=0;j<m;j++)
		{
			if(t[j].type==tr.type&&t[j].number==tr.number&&t[j].t==tr.t)break;
		}
		if(j==m)t[++k]=tr;
	}
	info[3]=k;
	return k;
}
void timePrint(Time a)
{
	if(a.minute==0)printf("%d��%d��%d�� %d:00\t",a.year,a.month,a.day,a.hour);//���ʱ�� 
	else if(a.minute<10)printf("%d��%d��%d�� %d:0%d\t",a.year,a.month,a.day,a.hour,a.minute);
	else printf("%d��%d��%d�� %d:%d\t",a.year,a.month,a.day,a.hour,a.minute);
}
void timePrint2(Time a)
{
	if(a.day==1)
	{
		if(a.minute==0)printf("���� %d:00\t",a.hour);//���ʱ�� 
		else if(a.minute<10)printf("���� %d:0%d\t",a.hour,a.minute);
		else printf("���� %d:%d\t",a.hour,a.minute);
	 } 
	 else
	 {
	 	if(a.minute==0)printf("��%d�� %d:00\t",a.day,a.hour);//���ʱ�� 
		else if(a.minute<10)printf("��%d�� %d:0%d\t",a.day,a.hour,a.minute);
		else printf("��%d�� %d:%d\t",a.day,a.hour,a.minute);
	 }
	 return;	
}
void print_rail(Rail a,int from,int to)
{
	int i;int y[3]={0,0,0};
	if(from==0&&to==0)
	{
		printf("--------------------------------------------------------------------------------------------------\n");
		printf("%c%d\t",a.type,a.number );
		printf("%s����%s\n",a.sta[0].name,a.sta[a.n_station-1].name);
		printf("\n  ��ͣ��Ϣ��\n");
		printf("\tվ��\t��վʱ��\t\t��վʱ��\n");
		for (i=0;i<a.n_station;i++)
		{
			
			printf("\t%d %s\t",i+1,a.sta[i].name);
			timePrint2(time_min2(a.sta[i].a)) ;
			timePrint2(time_min2(a.sta[i].a+a.sta[i].b)) ;
			printf("��ͣ%d ����\n",a.sta[i].b);
		//	printf("һ�ȣ�%d���ȣ�%dվƱ��%d\n",y[0],y[1],y[2]);
		}	
	}
	if(from<to&&to<=a.n_station)
	{
		for(i=from;i<=to;i++)
		{
			y[0]+=a.sta[i].price[0];
			y[1]+=a.sta[i].price[1];
			y[2]+=a.sta[i].price[2];
		}
		printf("%c%d | ",a.type,a.number);
		timePrint2(time_min2(a.sta[from].a));printf("����%s\t",a.sta[to].name); 
		timePrint2(time_min2(a.sta[from].a));printf("����%s\t",a.sta[to].name); 
		printf("һ�ȣ�%d���ȣ�%dվƱ��%d",y[0],y[1],y[2]);
		printf("\n");
	}	
	return ;
}
int print_user(User a)
{
	printf("%s\t%s\t%s\t%d\t%d\n",a.name,a.password,a.realname,a.number,a.identity);
}
void print_rec(Rec a)
{
	printf("�û�%s������%d�Ż𳵵ĳ�Ʊ\t",a.name,a.No );
	timePrint(time_min2(a.t1));
	printf("����%d��վ%s\t",a.station1,a.sta1);
	timePrint(time_min2(a.t2)); 
	printf("����%d��վ%s\n",a.station2,a.sta2); 
}
void print_train(Train t)
{
	printf("%d\t%c%d�г�",t.no,t.type,t.number);
	timePrint(time_min2(t.t));
	printf("���� ��Ʊ%d\n",t.tt-t.bt);
	return;
}
void Filewrite(Rail a[],User b[],Rec c[],Train d[],int info[])
{
	FILE*fp;
	{
			fp=fopen(".\\�����ļ�\\rail.dat","wb");//д������Ϣ 
			if(fp==NULL)
			{
				printf("load rail.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fwrite(a,sizeof(Rail),info[0],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\user.dat","wb");//д���û���Ϣ 
			if(fp==NULL)
			{
				printf("open user.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fwrite(b,sizeof(User),info[1],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\rec.dat","wb");//д���¼��Ϣ 
			if(fp==NULL)
			{
				printf("open rec.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fwrite(c,sizeof(Rec),info[2],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\train.dat","wb");//д��ʱ�̱���Ϣ 
			if(fp==NULL)
			{
				printf("open train.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fwrite(d,sizeof(train),info[3],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\info.txt","w");//д���¼ 
			if(fp==NULL)
			{
				printf("write info.txt ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fprintf(fp,"%d %d %d %d",info[0],info[1],info[2],info[3]);
			fclose(fp);
		}	
}
void readdata(Rail a[],User b[],Rec c[],Train d[],int info[])
{
	FILE*fp;
	{
			fp=fopen(".\\�����ļ�\\info.txt","r");//��ȡ��Ҫ��Ϣ 
			if(fp==NULL)
			{
				printf("write info.txt ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fscanf(fp,"%d %d %d %d",&info[0],&info[1],&info[2],&info[3]);
			fclose(fp);
			
			fp=fopen(".\\�����ļ�\\rail.dat","rb");//��ȡ�����Ϣ 
			if(fp==NULL)
			{
				printf("load rail.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fread(a,sizeof(Rail),info[0],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\user.dat","rb");//��ȡ�û���Ϣ 
			if(fp==NULL)
			{
				printf("load user.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fread(b,sizeof(User),info[1],fp);
			fclose(fp);
			fp=fopen(".\\�����ļ�\\rec.dat","rb") ;//��ȡ��¼��Ϣ 
			if(fp==NULL)
			{
				printf("load rec.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fread(c,sizeof(Rec),info[2],fp);
			fp=fopen(".\\�����ļ�\\train.dat","rb");//��ȡʱ�̱���Ϣ 
			if(fp==NULL)
			{
				printf("open train.dat ERROR!\n");
				printf("��������˳�����\n");
				exit(1);
			}
			fread(d,sizeof(train),info[3],fp);
			fclose(fp);
		}	
}

int menu(int i) 
{	int s;
	switch(i)
	{
		case 1://��ӭ���� 
			{
				time_t timer=time(NULL);
				printf("��ӭ��������˹С������,ף���������");printf("\t\t\t\t%s",ctime(&timer));
				printf("----------------------------------------------------------------------------------------------------");
				break;
			 } 
			 case 2://����Աѡ����� 
			 	{
				 	printf("MENU|");
				 	printf("0����������һ��\t");
				 	printf("1������ѯ������Ϣ\t");
					printf("2������ѯ��������\t") ;
					printf("3��������ϵͳ����\t") ;
					printf("\n");
					scanf("%d",&s);
					break;
				 }
				 case 3://��ѯ�˵� 
				 {
				 	    printf("MENU��ѯ�˵�|");
				 		printf("0   ������ѯ\t");
				 		printf("1   ����վ���ѯ\t");
						printf("2   ���ճ��β�ѯ \t");  
						printf("3   ȫ��������Ϣ\t");
						printf("����������ѡ��:\n");
						scanf("%d",&s);
						break;}
						case 4://�û���½��ĵ�һ������ 
							{
								printf("\nMENU|��ѯ������ϢΪ����1\t��ѯƱ����Ϣ����2 \t���ء���3\n"); 
								scanf("%d",&s);
								break;
							}
							case 5://�û�������Ʊ�Ľ��� 
								{
									
									printf("MENU��������|0�����˳�\t1������Ʊ\t");
									printf("2������ǩ\n");
									printf("��ѡ�����\n");
									scanf("%d",&s);
									break;
								}
								case 6:
									{
										printf("\n���Ƿ���Ҫ�����ó�Ʊ\t1��������\t0��������Ҫ\n");
    									scanf("%d",&s);break; 
									}
									case 7:
									{
										printf("MENU��������|1������ӳ�����Ϣ\t2�����޸ĳ�����Ϣ\t3����ɾ��������Ϣ\t4�������ӿ�����Ϣ\n");
										scanf("%d",&s);break;
									 } 
									 case 8:
									 	{
									 		printf("�Ƿ�ע��VIP�����������ԱȨ�� |1 ע��VIP 2 �������ԱȨ�� ����������Ϊ������\n");
									 		scanf("%d",&s);break;
										 }
										 case 9:
										 	{
										 		printf("MENU ��ѯ������Ϣ||0����������һ�� 1������ѯ������Ϣ 2������ѯ��Ʊ��Ϣ 3������ѯ�û���Ϣ 4--��ѯ������� 9�����رճ���\n ");//4 info
										 		scanf("%d",&s);break;
											 }
											 case 10:
											 	{
											 			printf("\n\n\n\nn\n\n\n\n\n\n\t\t\t\t\t�Ƿ�ʹ��Ԥ������\n\t\t\t1����ʹ��\n\t\t\t2������ʹ��\n");
														scanf("%d",&s);
												 }
    		
	}
	return s;
}
void originate(int inf[])
{	int select;FILE *fp;int i;
	int info[4]={4,5,2,0};
	Rail a[4]=	{   
		{'D',5526,5,3,{{"�Ͼ�",0,10,{0,0,0}},{"����",40,5,{30,20,10}},{"̩��",60,5,{30,20,10}},{"����",120,3,{30,20,10}},{"��ͨ",150,10,{30,20,10}}}} ,    
		{'D',5521,5,3,{{"�Ͼ�",500,10,{0,0,0}},{"��",540,5,{30,20,10}},{"����",560,5,{30,20,10}},{"����",620,3,{30,20,10}},{"����",720,3,{30,20,10}}}}, 
		{'D',5522,5,3,{{"�Ͼ�",100,10,{0,0,0}},{"����",140,5,{30,20,10}},{"����",160,5,{30,20,10}},{"����",220,3,{30,20,10}},{"����",320,3,{30,20,10}}}} , 
		{'D',5524,5,3,{{"�Ͼ�",100,10,{0,0,0}},{"����",140,5,{30,20,10}},{"̩��",160,5,{30,20,10}},{"����",220,3,{30,20,10}},{"��ͨ",220,3,{30,20,10}}}} 	};
	User b[5]={{"1","1","1",1,1},{"2","2","2",2,2},{"3","3","3",3,3},{"susan Jocob","123456","susan Jocob",2,2},{"���л�","123456","���л�",3,3}};
	Rec c[2]={{"1",1,1,2},{"2",2,1,3}};
	Train d[1000];
	for (i=0;i<info[0];i++)autotrain(a[i],20,d,info);
	select=menu(10);
	do{
		if(select==1)
		{
			Filewrite(a,b,c,d,info);	
			inf[0]=info[0];
			inf[1]=info[1];
			inf[2]=info[2];
			inf[3]=info[3];
		} 
		else if(select==2)
		{
			printf("�뽫�ļ������������Ŀ¼\n�ļ�������\n\tinfo.txt\n\t rail.dat\t user.dat\n\t rec.dat\n train.dat\n");
			getchar();getchar();
		}
		else {
			puts("����������");
		}
	} while(select!=1&&select!=2);
	return;
}

//��½ģ�� 
User Register(User us[],int*nU)//ע�ắ�� 
	{
		User u;char ch;char yourkey[20],admin[20]="NJUPT",VIP[20]="njupt";
		int a,b,s;char str[20],str2[N_password],str3[20],str4[20];int j;
		printf("�Ƿ�ѡ��ע�᣿\n");
		printf("�˳�������0 ע��������1 \n");
		scanf("%d",&a);
		if (a==1) 
		{
		printf("��ʼע��!\n");
		printf("\t�������������֤����:");
		scanf("%d",&u.number);
		printf("\t������������ʵ����");
		scanf("%s",str2);
		strcpy(u.realname,str2);
		printf("\t�����������ڵ�¼���û���");
		scanf("%s",str4);
		strcpy(u.name,str4);	 
		printf("\t��������������:");
		scanf("%s",str3);
		strcpy(u.password,str3);
		u.identity=1;
		s=menu(8); 
		if(s==1||s==2)
		{
			printf("�����������Կ,�����һ����������ȷ\n");
			char yourkey[20];
	    	j=0;
	        while((ch=getch())!='\r')
				{
					putchar('*');
					yourkey[j]=ch;
					j++;					
				}
				yourkey[j]='\0';
	    
	   	 	if(!strcmp(yourkey,admin))
	   	 	{
	    	printf("�Ѿ���ȡ����ԱȨ��\n");
	    	u.identity=2;
			}
			else if(!strcmp(yourkey,VIP))
			{
			printf("�Ѿ���ȡ���Ȩ��\n");
	    	u.identity=3;
			}
			else 
			{
				printf("Ȩ�޻�ȡʧ��\n\n") ; 
			} }
		}
	    if (a==0)
	    exit(1);
	    if(a==2) 
	    {
	    	u.identity=4;
		}
		printf("ȷ����Ϣ\n") ;
		getchar();
		us[*nU]=u;
		*nU=*nU+1;
		print_user(us[*nU-1]);
	return u;
}
User login(User user[],int*p)//��½���� 
{
	int i,j,k,num;char inName[20];User u;
	int l=1;char ch; 
	 {
	system("cls");menu(1);
	printf("\n\t���Ƿ�ע����˺ţ�(�� �� �� �����������ݽ���Ϊ���ο���ݵ�½)\n");
	char judge[5];
	scanf("%s",judge);
	system("cls");
	if(strcmp("��",judge)==0)
	{
	    Register(user,p);
	}
	if(strcmp("��",judge)==0||strcmp("��",judge)==0) 
	{ 
	num=*p;
	getchar();
	printf("��ʼ��¼!\n");
	printf("���������û���:");
	scanf("%s",inName);
	for(i=0;i<num;i++)
	{
		if(strcmp(user[i].name,inName)==0)
		{
			break;
		}
	}
	if(i==num)
	{
		printf("δ�ҵ������û���!\n");
		Register(user,p);
	}
	else
	{
		getchar();
		printf("\n����������,����������������Ļ���:");
		for(k=0;k<3;k++)
		{
			char yourkey[20];
	    	j=0;
	        while((ch=getch())!='\r')
				{
					putchar('*');
					yourkey[j]=ch;
					j++;					
				}
				yourkey[j]='\0';
			l=strcmp(yourkey,user[i].password);
			if(l==0) {
			u=user[i];
			break;
			} 
			
			else
			{
				printf("�������������!\n");
			}
		}
		if(k==3)
		{
			printf("��¼ʧ��!\n");
			u.identity=0;//�Ƿ��û� 
		}
	}}
	else{
		u.identity=4;//�ο� 
	} 
}
return u;
}
Rail query(Train t[],Rail ra[],int info[])                //��ѯ���κ���
{
	int choice;int ij=0,cho,flag=1;int bookornot; //flag 1ԭ����ֵ 2deleced�Ѿ���ֵ 
	Rail selected;
	int n=info[0];
	char a[10],b[10];
	int i,j,k=1,l,s;
	int s1,s2;
	Rail se[N_rail];
	do
	{
		choice=menu(3);
		if(choice==3)				         	//ȫ����ѯ--- flag=0;	
		{
			for (i=0;i<info[0];i++)print_rail(ra[i],0,0);
			flag=0;						
		}
		if(choice==1)							  //��վ���ѯ	flag=2;	
		{
				
				printf("\t���������ĳ����غ�Ŀ�ĵ�,֧��ͨ���*ģ����ѯ\n\t");
				scanf("%s",a);printf("\t��\n\t");scanf("%s",b);printf("\n ");
				printf("\t��ѯ�����\n");
				for (i=0;i<info[0];i++)
					{
						for (j=0;j<ra[i].n_station;j++)	
						{
							if(!strcmp(ra[i].sta[j].name,a)||!strcmp(a,"*"))
							{
								
									for(l=0;l<ra[i].n_station;l++)
									{
										if(!strcmp(ra[i].sta[l].name,b)||!strcmp(b,"*"))
										{
											if(l>j&&strcmp(ra[i].sta[j].name,ra[i].sta[l].name))
											{
											//printf(" ��%d�� %c%d | ",k,ra[i].type,ra[i].number);
											//timePrint2(time_min2(ra[i].sta[j].a));printf("����%s\t",ra[i].sta[j].name); 
											//timePrint2(time_min2(ra[i].sta[l].a));printf("����%s\t",ra[i].sta[l].name); 
											//printf("\n");
											printf("No.%d ",k);
											print_rail(ra[i],j,l);
											se[k-1]=ra[i];
											k++;	
											}
											
										}
									}	
							}
						}	
					}
					if(k==1)
					{
						selected.number=0;
						printf("\t����Ϣ\n"); 
					}
					else
					{
					printf("��ѡ������Ҫ�鿴�ĳ�Ʊ\n");
					scanf("%d",&s) ;
					print_rail(se[s-1],0,0) ;
					selected= se[s-1];
				}			 
		}
		if(choice==2)						     	//����·��Ų�ѯ   flag=2;	
		{
			int choice3=0,bookornot;
			char yourtype;
			int yournumber;
			int judge2=0;int ij;
			printf("�������г���·�ߺ�(��:D5526��5526):");
			scanf("%d",&yournumber);
			getchar() ;
			for(;choice3<n;choice3++)
			{
				if(yournumber==(ra+choice3)->number/*&&yourtype==ra[choice3].type*/)
				{
					ra[ij++]=ra[choice3];
					printf("��%d��\n",ij);print_rail(ra[choice3],0,0);
				}
				else
				{
					judge2++;
				}
			}getchar();
				if(judge2==n)
			{
				printf("û����ҪѰ�ҵĳ���\n");
				selected.number=0; 
			}
			else if(ij==1) 
			{
				selected=ra[0];
			}
			else{
				printf("ѡ����Ҫ���г�\n");
				scanf("%d",&cho);
				selected=ra[cho-1];
			}
			}
		if(choice==0)   break;                      //������һ��
	}while(choice);
	return selected;
}
int query_all(Rail rail[],User user[],Rec record[],Train train[],int info[])//����Ա��ѯ ��ѯ��λ���
{
	int s;int i;
	do{
		printf("\n����%d��������� %d���û����� %d��Ʊ������ %d�������������\n",info[0],info[1],info[2],info[3]);
	
	s=menu(9);
	switch(s)
	{
			case 1:printf("·����Ϣ\n");for (i=0;i<info[0];i++)print_rail(rail[i],0,0);break;
			case 3:printf("�û���Ϣ\n");for (i=0;i<info[1];i++)print_user(user[i]);break;
			case 2:printf("Ʊ����Ϣ\n");for (i=0;i<info[2];i++)print_rec(record[i]);break;
			case 4:printf("������Ϣ\n");for (i=1;i<info[3];i++)print_train(train[i]);break;
	}
	if(s==0) break;
}while(s!=0);
	return s;
}
int operate(Rail ra[],Train t[],int info[])
{
	int se;Rail r;int i;char str[20];int a, j;int s1,s2;
	se=menu(7);Station sta;
	switch(se)
	{
		case 1:
			{
				printf("�����복�εı���Լ�������վ������\t�磺D5526 5\n");
				r.type=getchar();
				scanf("%c",&r.type);
				scanf("%d %d",&r.number,&r.n_station);
				for (i=0;i<r.n_station;i++)
				{
					printf("�������%d��վ�㣺\n",i+1);
					printf("\tվ������");scanf("%s",&str);strcpy(r.sta[i].name,str);
					printf("����ʱ��\t") ;r.sta[i].a=time2min(timeGet(4));
					printf("��ͣʱ�䣨���ӣ�\t");scanf("%d",&r.sta[i].b);
					r.n_seat=3;
					if(i!=0){
						printf("��ֱ�����һ�� ���� ��վƱƱ��\t");
						for(j=0;j<r.n_seat;j++)
						scanf("%d",r.sta[i].price+i);
					}	
				}
				ra[info[0]]=r;
					info[0]++;
					printf("�Ƿ�Ϊ�Ѿ���ӵĳ����Զ��ӽ��쿪ʼ���࣬�������Զ��������������������0\n");
					scanf("%d",&a) ;
					autotrain(r,a,t,info);
					break; 
			}
			case 2:
			{
				printf("�������޸ĵĳ��α����D5521��5521\n");
				scanf("%d",&a);
				for(i=0;i<info[0];i++)
				{
					if(ra[i].number==a)break;
				}
				if(i==info[0])printf("δ�ҵ��ó���\n");
				else
				{
					print_rail(ra[i],0,0) ;
					printf("����������վ��(1)������վ��(2)�������޸�վ��(3)��������������ɾ�������\n");
					printf("��ѡ����Ҫ�Ĳ���");scanf("%d",&s1);
					printf("��ѡ�������վ��");scanf("%d",&s2); 
					switch(s1)
					{
						case 1:
							{
								printf("\t��Ҫ��ӵ�վ������");scanf("%s",&str);strcpy(sta.name,str);
								printf("����ʱ��\t") ;sta.a=time2min(timeGet(4));
								printf("��ͣʱ�䣨���ӣ�\t");scanf("%d",&sta.b);
								printf("��ֱ�����һ�� ���� ��վƱƱ��\t");
								for(j=0;j<r.n_seat;j++)
								scanf("%d",sta.price+i);
								for(j=ra[i].n_station;j>s2;j--)	
								{
									ra[i].sta[j]=ra[i].sta[j-1];
								}
								ra[i].sta[s2]=sta;
								ra[i].n_station++; 
								break;
							}
						case 2:
							{
								for(j=s2;j<ra[i].n_station-1;j++)	
								{
									ra[i].sta[j]=ra[i].sta[j+1];
								}
								ra[i].n_station--;
								break;
							}
						case 3:
							{
								printf("\t��Ҫ���վ������");scanf("%s",&str);strcpy(sta.name,str);
								printf("����ʱ��\t") ;sta.a=time2min(timeGet(4));
								printf("��ͣʱ�䣨���ӣ�\t");scanf("%d",&sta.b);
								printf("��ֱ�����һ�� ���� ��վƱƱ��\t");
								for(j=0;j<r.n_seat;j++)
								scanf("%d",sta.price+i);
								ra[i].sta[s2-1]=sta;
								break;
							}
					}
				}
				break;
			 } 
			 case 3:
			 	{
			 		printf("������ɾ���ĳ��α����D5521��5521\n");
					scanf("%d",&a);
			 		for(i=0;i<info[0];i++)
					{
						if(ra[i].number==a)break;
					}
					if(i==info[0])printf("δ�ҵ��ó���\n");
					else
					{
						for(j=i;j<info[0]-1;j++) 
						{
							ra[j]=ra[j+1];
						}
						info[0]--;
					}
					break;
				 }
				 case 4:
				 {
				 	
				  } 
	}
}
//�û�ģ����Ӻ���
int timeconflict(Rec u,Rec re[],int info[])//a,b c,d 
{
	int i,j=0;
	for(i=0;i<info[2];i++)
	{
		if(!strcmp(re[i].name,u.name))
		{
		 	if(u.t1>re[i].t2||u.t2<re[i].t1)
		 		j=0;
		 		else j=1;
		}
	}
	return j;
}
int query_user(User u,Rec r[],int info[])//��ѯ�û���Ʊ��� 
{
	int j=0,s,s1;int i,n,k=0;int a[N_rec];Rec t;int changeit=0;
	n=info[2];
	printf("���Ķ�����Ϣ����\n");
	for (i=0;i<n;i++)
	{
		if(!strcmp(r[i].name,u.name))
		{
			printf("No.%d ",++k);
		    print_rec(r[i]);puts("");
			a[k-1]=i;	
		 } 
	}
	if(k==0) printf("Ŀǰ�޶�Ʊ��Ϣ\n");
	else{
	s=menu(5);
	if(s==1)
	{
	do{
		printf("��ѡ����Ʊ�ı��\n");
		scanf("%d",&s1);
		}while(s1>k||s1<=0);
		print_rec(r[a[s1-1]]);
		printf("�Ƿ�ȷ����Ʊ  1����ȷ��\n");
		scanf("%d",&j);
		if(j==1) {
			for(i=a[s1-1];i<n-1;i++)
			{
				r[i]=r[i+1];
			}
			info[2]--;
		}

	}
	if(s==2)
	{
	do{
		printf("��ѡ���ǩ�ı��\n");
		scanf("%d",&s1);
		}while(s1>k||s1<=0);
		print_rec(r[a[s1]]);
		printf("�Ƿ�ȷ�ϸ�ǩ������Ʊ  1����ȷ��\n");
		scanf("%d",&j);
		if(j==1) {
			for(i=a[s1];i<n-1;i++)
			{
				r[i]=r[i+1];
			}
			info[2]--;
		}
		changeit=1;
		printf("\n�Զ������ѯҳ�棬�����Ը�ǩ��������Ʊ\n");
	}
	}
	return changeit;
}
int book(Rail r,User u,Rail ra[],Train t[],Rec re[],int info[])
 {
 	Rec rcd;Train tr;Time tim;int flag=0;
	int s1,s2;int y,m,d;int i;
	if(r.number!=0)
	{
		system("cls");
	 	printf("��ȷ�ϰ����Ϣ\n");
	 	print_rail(r,0,0);
	 	printf("�������ϳ����³���վ��\t\t������վ���Ӧ���\n");
	 	scanf("%d %d",&s1,&s2);
		while(s1>=s2||s2>r.n_station){
		 	printf("������������������"); 
	 		scanf("%d %d",&s1,&s2);
		 }
		 printf("�����Ϣ���£�\n\t");
		 print_rail(r,s1-1,s2-1);
		 do{
			 printf("����������Ҫ�˳���ʱ��\t����x��x��x���е�������Ӧ�����ÿո��������\n") ;
			 scanf("%d%d%d",&y,&m,&d) ;
			 for(i=0;i<info[3];i++)
			 {
			 	tim=time_min2(t[i].t);
			 	if(tim.year==y&&tim.month==m&&tim.day==d)break;
			 }
			 if(i!=info[3])
			 {
			 	printf("������г���ƱΪ%d\n",t[i].tt-t[i].bt);
			 	strcpy(rcd.name,u.name);
			 	rcd.No=t[i].no;
			 	rcd.station1=s1;
			 	rcd.station2=s2;
			 	rcd.t1=t[i].t-r.sta[1].a+r.sta[s1-1].a;
			 	rcd.t2=t[i].t-r.sta[1].a+r.sta[s2-1].a;
			 	strcpy(rcd.sta1,r.sta[s1-1].name);
				strcpy(rcd.sta2,r.sta[s2-1].name);
				if(t[i].t-r.sta[1].a+r.sta[s1].a-30<=time2min(timeGet(0)) ) {flag=1;printf("������ǰ��Сʱ��Ʊ,����������\n");}
				else if(u.identity==4) printf("�οͣ����¼\n");
				else if(timeconflict(rcd,re,info)){flag=1;printf("���Ѿ���������ó�Ʊʱ���ͻ�ĳ�Ʊ,����������\n");}
				else if(t[i].tt<=t[i].bt){printf("��Ʊ����\n");flag=1;	}
				else{
				re[info[2]]=rcd;
				info[2]+=1;
				printf("��Ʊ�ɹ�");
				flag=0; }
			}
			 else
			 {
			 	printf("��������س��ε��г�,����������\n");
			 	flag=1;
				 }	
		 }while(flag);
		
	}
 	return 0;
 }
//�Ƿ����û�������Աģ�� 
void unlaw()
{
	printf("���������Ƿ��û���������\n����������ǿ���˳���������\n"); 
	exit(0) ;
}
int ptyh(User u,rail a[],User b[],Rec c[],Train d[],int info[])
{
  	Rail ra;int s;int bookornot; int changeornot;
 //��ݣ�ʹ��1��ʾ��ͨ�û���3��ʾVIP 0��ʾ�Ƿ��û� ,4��ʾ�οͣ� 
  	system("cls");
  	printf("��ӭ");
  	if(u.identity==4)printf("�ο�");
	else{
	  	if(u.identity==3) printf("VIP");
	  	printf("�û�%s",u.name);
	  }
	 printf("��½ϵͳ��ף����;���\t\t\t\t") ; 
	 timePrint(timeGet(0));
	 puts("");
	 do{
    if(u.identity==1||u.identity==3)
    {
    	do{
    	s=menu(4);
    	if(s==1) changeornot=query_user(u,c,info);
        if(s==2|| changeornot==1)
		{
    		ra=query(d,a,info);
    		if(ra.number!=0)
    		{	
    		if(menu(6)==1)
    		book(ra,u,a,d,c,info);
			}
		}
	}while(s!=3);
	}
  	if(u.identity==4)query(d,a,info);
  }while(s!=3);
  s=1;
  	return s;
  }
int glry(User u,rail a[],User b[],Rec c[],Train d[],int info[])//0����������һ��\t");	printf("1������ѯ�����Ϣ\t");	printf("2������ѯ��������\t") ;	printf("3��������ϵͳ����\t")
 {
 	int temp;int s=0;
 	system("cls");
 	printf("��ӭ����Ա%s����ϵͳ\n",u.name);
	do{
		
		temp=menu(2);
		switch(temp)
		{
			case 1:query(d,a,info);break;                           //��β�ѯ ��ͨ��ѯ 
			case 2:s=query_all(a,b,c,d,info) ;break;               		 //��ѯ ȫ�� 
			case 3:operate(a,d,info);break;                                 //���� 
		}
	}while(temp!=0&&s!=9);
 	return 1;
  } 
                 																											#define MAIN
#ifdef MAIN
int main()
{
	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	menu(1);//��ӭ���� 
	originate(info);//��ʼ��
	readdata(rail,user,record,train,info);
	int a;
	do{ 
    us=login(user,info+1);//��½���� 
	system("cls");
	switch(us.identity)//��ݣ�ʹ��1��ʾ��ͨ�û���2��ʾ����Ա��3��ʾVIP 0��ʾ�Ƿ��û� ,4��ʾ�οͣ� 
	{
		case 0: unlaw();break;a=0;//�Ƿ��û����˳�ϵͳ 
		case 1:
		case 3:
		case 4:	
			    a=ptyh(us,rail,user,record,train,info);break;//��ͨ�û�������VIP���οͣ�ʹ��ģ�� 
		case 2: a=glry(us,rail,user,record,train,info);break;//������Աʹ��ģ�� 
	}
	}while(a==1) ; 
	Filewrite(rail,user,record,train,info);
	return 0;
}
#endif
#ifdef TIME 
int main()//����ʱ�䴦���� 
{
	int i;int b;Time c;
	i=61200;
	for(i=0;i<=100000000;i+=1440)
	{
		c=time_min2(i);
		b=time2min(c);
		timePrint(c);printf("\t%d\t%d\n",i,b);
		if(b!=i){break;
		}
	}
	return 0;
}
#endif
#ifdef FILE
int main()//�����ļ����� 
{

{
	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	menu(1);//��ӭ���� 
	originate(info);//��ʼ��
	readdata(rail,user,record,train,info);
	printf("\n����%d %d %d %d\n",info[0],info[1],info[2],info[3]);
	printf("·����Ϣ\n");for (i=0;i<info[0];i++)print_rail(rail[i],0,0);
	printf("�û���Ϣ\n");for (i=0;i<info[1];i++)print_user(user[i]);
	printf("Ʊ����Ϣ\n");for (i=0;i<info[2];i++)print_rec(record[i]);
	printf("������Ϣ\n");for (i=1;i<info[3];i++)print_train(train[i]);
 } 
 } 
 #endif 
                                                                                                                                 //#define YHMK
 #ifdef YHMK
 int main()//������Աģ�� 
 {
 	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	  us=login(user,info+1);//��½���� 
	menu(1);//��ӭ���� 
	originate(info); 
	readdata(rail,user,record,train,info);
	glry(user[1],rail,user,record,train,info);
  ptyh(user[0],rail,user,record,train,info);
 }
 #endif 
