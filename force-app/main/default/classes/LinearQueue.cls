public class LinearQueue {
    
    List<Integer> arr;
    Integer front;
    Integer rear;
    Integer capacity;
    
    public LinearQueue(Integer size){
        arr = new List<Integer>();
        capacity = size;
        front = 0;
        rear = -1;
    }
    
    // enqueue
    public void enqueue(Integer data){
        if(isFull()){
            System.debug('Queue Overflow');
            return;
        }
        arr.add(data);
        rear++;
    }
    
    // dequeue
    public Integer dequeue(){
        if(isEmpty()){
            System.debug('Queue Underflow');
            return null;
        }
        Integer val = arr[front];
        front++;
        return val;
    }
    
    // peek
    public Integer peek(){
        if(isEmpty()) return null;
        return arr[front];
    }
    
    public Boolean isEmpty(){
        return front > rear;
    }
    
    public Boolean isFull(){
        return rear == capacity - 1;
    }
}