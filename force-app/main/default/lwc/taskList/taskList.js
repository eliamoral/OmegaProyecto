import { LightningElement } from 'lwc';
import getAllTasks from '@salesforce/apex/TaskController.getAllTasks';
import { NavigationMixin } from 'lightning/navigation';
export default class TaskList extends NavigationMixin(LightningElement) {
	tasks;
	error;
	connectedCallback() {
		this.loadTasks();
	}
	loadTasks() {
		getAllTasks()
			.then(result => {
				this.tasks = result;
			})
			.catch(error => {
				this.error = error;
			});
	}
	handleOpenRecordClick(event) {

		const taskId = event.currentTarget.value;
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: taskId,
				objectApiName: 'Task',
				actionName: 'view',
			},
		});
	}
}