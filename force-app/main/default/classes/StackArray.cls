public class StackArray {
    
    List<Integer> arr;
    Integer top;
    Integer capacity;
    
    public StackArray(Integer size){
        arr = new List<Integer>();
        capacity = size;
        top = -1;
    }
    
    // push
    public void push(Integer data){
        if(isFull()){
            System.debug('Stack Overflow');
            return;
        }
        arr.add(data);
        top++;
    }
    
    // pop
    public Integer pop(){
        if(isEmpty()){
            System.debug('Stack Underflow');
            return null;
        }
        Integer val = arr.remove(top);
        top--;
        return val;
    }
    
    // peek
    public Integer peek(){
        if(isEmpty()){
            return null;
        }
        return arr[top];
    }
    
    // isEmpty
    public Boolean isEmpty(){
        return top == -1;
    }
    
    // isFull
    public Boolean isFull(){
        return top == capacity - 1;
    }
}