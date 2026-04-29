public class StackLL {
    
    public class Node {
        Integer data;
        Node next;
        
        public Node(Integer data){
            this.data = data;
        }
    }
    
    Node top;
    
    // push
    public void push(Integer data){
        Node newNode = new Node(data);
        newNode.next = top;
        top = newNode;
    }
    
    // pop
    public Integer pop(){
        if(isEmpty()){
            System.debug('Stack Underflow');
            return null;
        }
        Integer val = top.data;
        top = top.next;
        return val;
    }
    
    // peek
    public Integer peek(){
        if(isEmpty()){
            return null;
        }
        return top.data;
    }
    
    // isEmpty
    public Boolean isEmpty(){
        return top == null;
    }
}