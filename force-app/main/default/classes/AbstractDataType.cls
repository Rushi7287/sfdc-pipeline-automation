public class AbstractDataType{

	public static Integer deleteElementAt(Integer[] arr, Integer index){

		if(index < 0 || index >= arr.size()){
			return arr.size();
		}
		
		for(Integer i = index; i < arr.size() - 1; i++){
			arr[i] = arr[i + 1];
		}
		arr.remove(arr.size() - 1);
		return arr.size();
	}

	public static Integer addElementAt(Integer[] arr, Integer index , Integer data){
		if(index < 0 || index > arr.size()) return arr.size();
		arr.add(null);
		for(Integer i = arr.size()-1; i >= index ;i--){
			arr[i] = arr[i-1];
		}
		arr[index] = data;
		return arr.size();
	}
	
	public static Integer linearSearch(List<Integer> arr, Integer key){
		if(arr == null || arr.size() == 0){
			return -1;
		}
		for(Integer i = 0; i < arr.size(); i++){
			if(arr[i] != null && arr[i].equals(key)){ // .equals better than arr[i] == key
				// arr[i].equals(key) check the content and == check the referance 
				return i;
			}
		}
		return -1;
	}
	
	public static Integer binarySearch(List<Integer> arr, Integer key){
		
		if(arr == null || arr.size() == 0){
			return -1;
		}
		
		Integer low = 0;
		Integer high = arr.size() - 1;
		
		while(low <= high){ // if will use the low < high last condition is miss that's why this 
			
			Integer mid = low + (high - low) / 2; // integer overflow avoid by this insted of ( high + low ) / 2
			// dont forget to update mid value always
			
			if(arr[mid] == key){
				return mid;
			}
			else if(arr[mid] > key){
				high = mid - 1;
			}
			else{
				low = mid + 1;
			}
		}
		
		return -1;
	}
	
	public static void traversalArray(Integer[] arr){
		String result = '';
		for(Integer i = 0; i < arr.size(); i++){
			result += '| ' + arr[i] + ' ';
		}
		result += '|';
		System.debug(result);
	}

	public static void test(List<Integer> arr){
		System.debug(arr[0] == arr[1]);
		System.debug(arr[0].equals(arr[1]));
	}
}