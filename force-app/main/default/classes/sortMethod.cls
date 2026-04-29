public class sortMethod {
    
    // Wrapper Class
    public class MyWrapper implements Comparable {
        public String name;
        public Integer score;
        
        public MyWrapper(String name, Integer score){
            this.name = name;
            this.score = score;
        }
        
        // Sorting logic
        public Integer compareTo(Object obj){
            MyWrapper other = (MyWrapper)obj;
            
            // ===== PRIMARY: Name ASC =====
            // Integer nameCompare = this.name.toLowerCase().compareTo(other.name.toLowerCase());
            // if(nameCompare != 0){
            //     return nameCompare;
            // }
            
            // ===== SECONDARY: Score DESC =====
            Integer a = this.score == null ? 0 : this.score;
            Integer b = other.score == null ? 0 : other.score;
            
            if(a == b) return 0;
            return a > b ? 1 : -1;
        }
    }
    
    
    // Method to run
    public static void runDemo(){
        
        List<MyWrapper> data = new List<MyWrapper>();
        
        // 10 Records
        data.add(new MyWrapper('Rahul', 50));
        data.add(new MyWrapper('Amit', 70));
        data.add(new MyWrapper('Rahul', 80));
        data.add(new MyWrapper('Suresh', 40));
        data.add(new MyWrapper('Amit', 60));
        data.add(new MyWrapper('Neha', 90));
        data.add(new MyWrapper('Neha', 30));
        data.add(new MyWrapper('Kiran', 20));
        data.add(new MyWrapper('Kiran', 100));
        data.add(new MyWrapper('Amit', 90));
        
        System.debug('=== Before Sort ===');
        for(MyWrapper w : data){
            System.debug(w.name + ' -> ' + w.score);
        }
        
        data.sort();
        
        System.debug('=== After Sort ===');
        for(MyWrapper w : data){
            System.debug(w.name + ' -> ' + w.score);
        }
    }
}