#include<iostream>
#include<set>
#include<algorithm>
#include<vector>

using namespace std;

///使用A*算法求解数码问题

class node
{  
    public:
        vector<int> Sequence;
        static vector<int> target_Sequence;
        node* Parent = nullptr;  /*父节点的指针*/
        vector<node*> Progeny;   /*子节点们的指针*/
        int layer;      /*层数，定义从0层开始*/
        int f_x;        /*估价函数*/

        // 构造函数参数改为const引用，成员变量用初始化列表初始化
        node(const vector<int>& target_Sequence_input, const vector<int>& Sequence_input, int layer_input)
        {
            layer=layer_input;
            target_Sequence = target_Sequence_input; // 静态成员赋值
            Sequence=Sequence_input;
            int g_x = layer;
            int h_x = 0;
            for (int i = 0; i < target_Sequence.size(); i++)
            {
                if (target_Sequence[i] != Sequence[i])
                    h_x += 1;
            }
            f_x = g_x + h_x; // 正确赋值给成员变量
        }

        node(const vector<int>& target_Sequence_input, const vector<int>& Sequence_input, node* Parent_input, int layer_input)
        {
            Parent=Parent_input;
            layer=layer_input;
            target_Sequence = target_Sequence_input;
            Sequence=Sequence_input;
            int g_x = layer;
            int h_x = 0;
            for (int i = 0; i < target_Sequence.size(); i++)
            {
                if (target_Sequence[i] != Sequence[i])
                    h_x += 1;
            }
            f_x = g_x + h_x;
        }

        /*vector<int> check_Sequence() const
        { return Sequence; }*/

        // operator==应为const成员函数
        bool operator==(const node& another_node) const
        {return Sequence == another_node.Sequence;}
            
        // set<node>需要operator<重载
        bool operator<(const node& another_node) const
        {return Sequence < another_node.Sequence;}

        node& operator=(const node& another)
        {
            Sequence=another.Sequence;
            Parent=another.Parent;
            Progeny=another.Progeny;
            layer=another.layer;
            f_x=another.f_x;
            return(*this);
        }
            
        /*寻找子节点*/

        vector<node*> select_Progeny()
        {
            vector <int> Sequence_modify;
            vector<node> Progenys, Progenys_port;
            vector<node *> Progenys_pointer; 
            int i, j;
            for (i = 0; i < Sequence.size(); i++)
            {
                if (Sequence[i] == 0)
                    break;
            }
            Progenys_port = yield_Progenys(i);
            Progenys.insert(Progenys.end(), Progenys_port.begin(), Progenys_port.end());

            for (j = i + 1; j < Sequence.size(); j++)
            {
                if (Sequence[j] == 0)
                    break;
            }
            Progenys_port = yield_Progenys(j);
            Progenys.insert(Progenys.end(), Progenys_port.begin(), Progenys_port.end());

            /*去重*/
            set<node> Progenys_modify(Progenys.begin(), Progenys.end());
            Progenys.assign(Progenys_modify.begin(), Progenys_modify.end());

            for (i = 0; i < Progenys.size(); i++)
                Progenys_pointer.push_back(new node(Progenys[i]));
            
            Progeny=Progenys_pointer;
            return(Progenys_pointer);
        }


        vector<node> yield_Progenys(int blank)
        {
            ///分为四个情况，①上下边界、②左右边界、③内部节点、④四个角的节点
            ///两个空位，需要重复两次
            vector <int> Sequence_modify;
            vector <node> Progenys;
            if (blank>=0 && blank<=3)
            {
                switch (blank)
                {
                case 0:      /*左上角的情况*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[0]=Sequence[1];
                    Sequence_modify[1]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[0]=Sequence[4];
                    Sequence_modify[4]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);
                    break;
                }
                case 3:        /*右上角的情况*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[3]=Sequence[2];
                    Sequence_modify[2]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[3]=Sequence[7];
                    Sequence_modify[7]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);
                    break;
                }
                default:   /*上边界*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+4];
                    Sequence_modify[blank+4]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-1];
                    Sequence_modify[blank-1]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+1];
                    Sequence_modify[blank+1]=0;
                    node Progeny_3(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_3);
                    break;
                }
                    
                }
            }
            else if(blank>=12 && blank<=15)
            {
                switch (blank)
                {
                case 12:   /*左下角*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[12]=Sequence[13];
                    Sequence_modify[13]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[12]=Sequence[8];
                    Sequence_modify[8]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);
                    break;
                }
                case 15:   /*右下角*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[15]=Sequence[14];
                    Sequence_modify[14]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[15]=Sequence[11];
                    Sequence_modify[11]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);
                    break;
                }
                
                default:   /*下边界*/
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-4];
                    Sequence_modify[blank-4]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-1];
                    Sequence_modify[blank-1]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+1];
                    Sequence_modify[blank+1]=0;
                    node Progeny_3(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_3);
                    break;
                }
                }
            }
            else
            {
                switch (blank%4)
                {
                case 0:
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-4];
                    Sequence_modify[blank-4]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+4];
                    Sequence_modify[blank+4]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+1];
                    Sequence_modify[blank+1]=0;
                    node Progeny_3(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_3);
                    break;
                }
                case 3:
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-4];
                    Sequence_modify[blank-4]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+4];
                    Sequence_modify[blank+4]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-1];
                    Sequence_modify[blank-1]=0;
                    node Progeny_3(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_3);
                    break;
                }
                
                default:
                {
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-4];
                    Sequence_modify[blank-4]=0;
                    node Progeny_1(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_1);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+4];
                    Sequence_modify[blank+4]=0;
                    node Progeny_2(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_2);

                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank-1];
                    Sequence_modify[blank-1]=0;
                    node Progeny_3(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_3);
                    
                    Sequence_modify=Sequence;
                    Sequence_modify[blank]=Sequence[blank+1];
                    Sequence_modify[blank+1]=0;
                    node Progeny_4(target_Sequence,Sequence_modify,this,layer+1);
                    Progenys.push_back(Progeny_4);
                    break;
                }
                    
                }
            }
            /*删去与父节点相同的节点*/
            for(int i=0;i<Progenys.size();i++)
            {
                if(Progenys[i].Sequence==Sequence)
                {
                    Progenys.erase(Progenys.begin()+i); /*这个无所谓*/
                    i--;/*有问题可以改成i=0*/
                }
            }
            return(Progenys);
        }
};

class A_star_algorithm
{
    public:
    vector<node*> open;
    vector<node*> close;
    A_star_algorithm(vector<int> initial_Sequence)
    {
        node initial_node(node::target_Sequence,initial_Sequence,0);
        open.push_back(new node(initial_node));   /*初始节点，父节点为空*/
    }

    node* find_path()
    {
        int i,j,k=0,num=1;
        vector<node*> Progeny;
        vector<node> Progeny_node;
        while(open.size()>0)
        {
            close.push_back(open[0]);
            open.erase(open.begin());
            if(close[close.size()-1]->Sequence==node::target_Sequence)
            {
                printf("success search\n");
                return(close[close.size()-1]);
            }
            Progeny=close[close.size()-1]->select_Progeny();
            if(Progeny.size()!=0)
            {
                for (i=0;i<Progeny.size();i++)
                {
                    /*查重更新open表和close表*/
                    /*先搜索open表*/

                    for(j=0;j<open.size();j++)
                    {
                        if(*Progeny[i]==*open[j])
                        {
                            if(Progeny[i]->f_x<open[j]->f_x)
                                open[j]=Progeny[i];
                            k=1;
                        }
                    }

                    /*再搜索close表*/
                    for(j=0;j<close.size();j++)
                    {
                        if(*Progeny[i]==*close[j])
                        {
                            if(Progeny[i]->f_x<close[j]->f_x)
                                close[j]=Progeny[i];
                            k=1;
                        }
                    }
                    
                    if (k==1)
                    {
                        Progeny.erase(Progeny.begin()+i);
                        i--;
                        k=0;
                    }
                        
                }
            }
            if(Progeny.size()!=0)
            {
                open.insert(open.end(),Progeny.begin(),Progeny.end());

                /*按照估价函数值来升序排序*/
                sort(open.begin(), open.end(), [](const node* a, const node* b) {return a->f_x < b->f_x;});
            }
            //cout<<num<<"\t    open size="<<open.size()<<endl;
            //num++;
        }
        printf("fail search\n");
        return(nullptr);
    }


};

// 静态成员变量定义
vector<int> node::target_Sequence;

bool check_sequence(vector<int> Sequence)  /*检查输入的合法性*/
{
    /*先排序*/
    sort(Sequence.begin(),Sequence.end());
    if(Sequence[0]!=0 || Sequence[1]!=0)
        return false;

    /*再去重*/
    set<int> s(Sequence.begin(),Sequence.end());
    Sequence.assign(s.begin(),s.end());

    if (Sequence.size()!=15)
        return false;

    for(int i=0;i<Sequence.size();i++)
    {
        if (Sequence[i]!=i)
            return false;
    }

    return true;

}

void show_sequence(node n)
{
    for(int i=0;i<16;i++)
    {
        cout<<n.Sequence[i]<<'\t';
        if(i%4==3)
            cout<<endl;
    }
    cout<<endl<<endl;
}

void clear_node(node* n)
{
    int i;
    if (n->Progeny.size()!=0)
    {
        for(i=0;i<n->Progeny.size();i++)
            clear_node(n->Progeny[i]);
        n->Progeny.clear();
    }
    delete n;
}

int main()
{
    int i,num;
    vector<int> initial_Sequence;
    vector<node*> complete_Sequence;
    cout<<"Input the initial sequence\n";
    for(i=0;i<16;i++)
    {
        cin>>num;
        initial_Sequence.push_back(num);    ///0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 0

    }
    cout<<"\n\n";
    if(check_sequence(initial_Sequence));  
    else
    {
        printf("Illegal input\n");
        return 0;
    }

    cout<<"Input the target Sequence\n";
    for(i=0;i<16;i++)
    {
        cin>>num;                           ///0 5 3 7 1 4 9 2 12 6 14 10 13 8 11 0
        node::target_Sequence.push_back(num);
    }
    if(check_sequence(node::target_Sequence));
    else
    {
        printf("Illegal input\n");
        return 0;
    }

    A_star_algorithm A(initial_Sequence);

    complete_Sequence.push_back(A.find_path());
    if(complete_Sequence[0]!=nullptr)
    {
        while(complete_Sequence[0]->Parent!=nullptr)
            complete_Sequence.insert(complete_Sequence.begin(),complete_Sequence[0]->Parent);
            
        cout<<endl;
        for(i=0;i<complete_Sequence.size();i++)
        {
            printf("step %d:\n",i+1);
            show_sequence(*complete_Sequence[i]);
        }
            
        clear_node(complete_Sequence[0]);
        
    }


    return 0;
}