public class ActivitySelection {
    public class Activity {
        public Integer start;
        public Integer end1;
        public Activity(Integer s, Integer e) {
            start = s;
            end1 = e;
        }
    }

    public class ActivityComparator implements Comparator<Activity> {
        public Integer compare(Activity a, Activity b) {
            return a.end1 - b.end1;
        }
    }

    public static Integer maxActivities(List<Activity> arr) {
        if (arr == null || arr.isEmpty()) return 0;
        
        arr.sort(new ActivityComparator());
        Integer count = 1;
        Integer lastEnd = arr[0].end1;
        for (Integer i = 1; i < arr.size(); i++) {
            if (arr[i].start >= lastEnd) {
                count++;
                lastEnd = arr[i].end1;
            }
        }
        return count;
    }
}