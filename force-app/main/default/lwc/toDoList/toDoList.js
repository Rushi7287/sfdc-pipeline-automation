import { LightningElement, track, wire } from 'lwc';
import getLists from '@salesforce/apex/ToDoController.getLists';
import getTasks from '@salesforce/apex/ToDoController.getTasks';
import createTask from '@salesforce/apex/ToDoController.createTask';
import updateTaskStatus from '@salesforce/apex/ToDoController.updateTaskStatus';
import createList from '@salesforce/apex/ToDoController.createList';

export default class ToDoList extends LightningElement {
    @track lists = [];
    @track tasks = [];
    @track selectedListId;
    @track selectedListName;
    @track newTaskName = '';
    @track newListName = '';

    @wire(getLists)
    wiredLists({ data, error }) {
        if (data) {
            this.lists = data;
        }
    }

    handleListSelect(event) {
        this.selectedListId = event.currentTarget.dataset.id;
        this.selectedListName = this.lists.find(
            list => list.Id === this.selectedListId
        ).Name;

        this.loadTasks();
    }

    loadTasks() {
        getTasks({ listId: this.selectedListId })
            .then(result => {
                this.tasks = result;
            })
            .catch(error => {
                console.error('Error fetching tasks', error);
            });
    }

    handleNewTaskChange(event) {
        this.newTaskName = event.target.value;
    }

    addTask() {
        if (!this.newTaskName || !this.selectedListId) return;

        createTask({ name: this.newTaskName, listId: this.selectedListId })
            .then(() => {
                this.newTaskName = '';
                this.loadTasks();
            })
            .catch(error => {
                console.error('Error adding task', error);
            });
    }

    toggleTaskCompletion(event) {
        const taskId = event.target.dataset.id;
        const isCompleted = event.target.checked;

        updateTaskStatus({ taskId, isCompleted })
            .then(() => {
                this.loadTasks();
            })
            .catch(error => {
                console.error('Error updating task', error);
            });
    }

    handleNewListChange(event) {
        this.newListName = event.target.value;
    }

    createNewList() {
        if (!this.newListName) return;

        createList({ name: this.newListName })
            .then(() => {
                this.newListName = '';
                return getLists();
            })
            .then(result => {
                this.lists = result;
            })
            .catch(error => {
                console.error('Error creating list', error);
            });
    }

    getTaskClass(task) {
        return task.Is_Completed__c ? 'done' : '';
    }
}