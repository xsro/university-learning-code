#状态节点
class Node:
    levelLimit=4
    def __init__(self,target,parent='origin'):
        self.target=target
        self.parent=parent
        if(parent=='origin'):
            self.level=0
        else:
            self.level=parent.level+1

    def next(self):
        #假如超过限制就返回空列表
        if self.level>self.levelLimit:
            return []
        
        n=Node(self.target,self)
        return [n]

    def success(self):
        return self.level==3

    def tri_recursion(self):
        if self.success():
            print(self.toChain())
        else :
            ns=self.next()
            for n in ns:
                n.tri_recursion()

    def toString(self):
        return self.target

    def toChain(self):
        if(self.parent!='origin'):
            return self.toChain()+'-->'+self.toString()
        else :
            return self.toString()
one=Node([1,0,1])
one.tri_recursion()
print(one.target)

