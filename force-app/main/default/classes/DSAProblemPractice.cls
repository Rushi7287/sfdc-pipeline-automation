public class DSAProblemPractice {
	public static void main(){
		Integer[] intArray = new Integer[3];
		String[] strList = new String[10];
		intArray[0] = 2;
		intArray[1] = 2;
		intArray[2] = 2;
		System.debug('It is working'+intArray.size());
	}

	public static Integer[] selectionSort(Integer[] arr){
		for(Integer index = 0 ; index < arr.size() - 1 ; index ++){ // l - 1 is good
			
			for(Integer index1 = index+1 ; index1 < arr.size() ; index1 ++){
				Integer selectedInt = arr[index];
				
				if(selectedInt > arr[index1]){
					Integer temp = arr[index];
					arr[index] = arr[index1];
					arr[index1] = temp;
				}
			}
		}

		System.debug(arr);
		return arr;
	}

	public static Integer[] bubbleSort(Integer[] arr){
			Integer count = 0;
		for(Integer i = 0 ; i < arr.size() - 1 ; i++){
				Boolean flag = false; 
			for(Integer j = 0  ; j < arr.size() - 1 - i ; j ++ ){
				if(arr[j] > arr[j + 1]){
					Integer temp = arr[j];
					arr[j] = arr[j+1];
					arr[j+1] = temp;
					flag = true;
				}
				
			}
			count++;
			if(!flag){
					System.debug(arr);
					System.debug(count);
					return arr;
				}
		}
		System.debug(arr);
		System.debug(count);
		return arr;
	}

	public static void insertionSort(Integer[] arr){
		for(Integer i = 1 ; i < arr.size() ; i ++ ){
			Integer selected = arr[i];
			Integer j = i - 1; 
			while(j >= 0  &&  arr[j] > selected){
				arr[j+1] = arr[j];
				j--;

			}
			arr[j+1] = selected;
		}
		System.debug(arr);


	}


	public static void mergeSort(Integer[] arr, Integer left, Integer right){
		if(left >= right){ //=>  this condition 
			return ;
		}

		Integer mid = left + (right - left) / 2 ;// => this condition 
		mergeSort(arr, left , mid);
		mergeSort(arr, mid + 1, right);
		mergeMethod(arr, left , mid , right);


	}

	public static void mergeMethod(Integer[] arr, Integer left, Integer mid , Integer right){
		Integer n1 = mid - left + 1;
		Integer n2 = right - mid;
		Integer[] arr1 = new Integer[n1];
		Integer[] arr2 = new Integer[n2];
		for(Integer i = 0 ; i < n1 ; i++){
			arr1[i] = arr[left + i];
		}

		for(Integer j = 0 ; j < n2 ; j++){
			arr2[j] = arr[mid + 1 + j];
		}

		Integer i = 0 ;
		Integer j = 0 ; 
		Integer k = left ; // => this condition 
		while( i < n1 && j < n2){
			if(arr1[i] <= arr2[j]){
				arr[k] = arr1[i];
				i++;
			}else{
				arr[k] = arr2[j];
				j++;
			}
			k++;
		}

		while(i < n1){
			arr[k] = arr1[i];
			k++;
			i++;
		}

		while (j < n2) {
			arr[k] = arr2[j];
			k++;
			j++;
		}

	}

	
}


// DSAProblemPractice.methodName();