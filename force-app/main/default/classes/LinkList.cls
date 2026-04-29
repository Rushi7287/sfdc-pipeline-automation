public class LinkList {

    public class Node {
        Integer data;
        Node next;

        public Node(Integer data){
            this.data = data;
            this.next = null;
        }
    }

    public static void traversalSLL(Node head){
        if(head == null){
            System.debug('Head is null');
            return;
        }

        String result = '';
        Node temp = head;

        while(temp != null){
            result += temp.data + ' -> ';
            temp = temp.next;
        }

        System.debug(result);
    }

    public static Node addAtFirst(Node head, Integer data){
        Node newNode = new Node(data);
        newNode.next = head;
        return newNode;
    }

	public static Node deleteAtFirst(Node head){
		if(head == null) return null;
        return head.next;
    }

	public static Node deleteAtLast(Node head){
		if(head == null || head.next == null) return null;
		Node temp = head;
		Node prev = null;
		while(temp.next != null){
			prev = temp;
			temp = temp.next;
		}
		prev.next = null;
		return head;
	}

	public static Node removeAtIndex(Node head, Integer index){
    
		// invalid cases
		if(head == null || index < 0){
			return head;
		}

		// delete first
		if(index == 0){
			return deleteAtFirst(head);
		}

		Node temp = head;

		// move to (index-1) safely
		for(Integer i = 0; i < index - 1 && temp.next != null; i++){
			temp = temp.next;
		}

		// if next exists, delete it
		if(temp.next != null){
			temp.next = temp.next.next;
		}

		return head;
	}

    public static Node addAtLast(Node head, Integer data){
        Node newNode = new Node(data);

        if(head == null){
            return newNode;
        }

        Node temp = head;
        while(temp.next != null){
            temp = temp.next;
        }

        temp.next = newNode;
        return head;
    }

    public static Node addAtIndex(Node head, Integer data, Integer index){

        if(index == 0){
            return addAtFirst(head, data);
        }

        if(head == null){
            return new Node(data);
        }

        Node temp = head;

        for(Integer i = 0; i < index - 1 && temp.next != null; i++){
            temp = temp.next;
        }

        Node newNode = new Node(data);
        newNode.next = temp.next;
        temp.next = newNode;

        return head;
    }

    public static Integer getLengthOfLL(Node head){
        Integer count = 0;
        Node temp = head;

        while(temp != null){
            count++;
            temp = temp.next;
        }

        return count;
    }
}