public class CircularQueue {
    
    Integer[] arr;
    Integer front;
    Integer rear;
    Integer capacity;
    
    public CircularQueue(Integer size){
        arr = new Integer[size];
        capacity = size;
        front = -1;
        rear = -1;
    }
    
    // enqueue
    public void enqueue(Integer data){
        
        if(isFull()){
            System.debug('Queue Overflow');
            return;
        }
        
        if(isEmpty()){
            front = rear = 0;
        } else {
            rear = Math.mod((rear + 1), capacity);
        }
        
        arr[rear] = data;
    }
    
    // dequeue
    public Integer dequeue(){
        
        if(isEmpty()){
            System.debug('Queue Underflow');
            return null;
        }
        
        Integer val = arr[front];
        
        if(front == rear){
            front = rear = -1;
        } else {
            front = Math.mod((front + 1), capacity);
        }
        
        return val;
    }
    
    // peek
    public Integer peek(){
        if(isEmpty()) return null;
        return arr[front];
    }
    
    public Boolean isEmpty(){
        return front == -1;
    }
    
    public Boolean isFull(){
        return Math.mod((rear + 1) ,capacity) == front;
    }
}