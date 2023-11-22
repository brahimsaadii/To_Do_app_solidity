# TodoList Smart Contract Report

## Overview
This report provides an overview and analysis of the TodoList smart contract, a decentralized application (DApp) developed on the Ethereum blockchain using Solidity. The contract facilitates the management of tasks in a to-do list, offering functionalities such as adding, updating, deleting tasks, and retrieving task details.

## Smart Contract Structure
### 1. Task Structure
The Task structure is well-defined with three key attributes:<br>

`id`: A unique identifier for each task.<br>
`content`: A string describing the task.<br>
`completed`: A boolean indicating the task's completion status.<br>

### 2. State Variables
The contract efficiently utilizes state variables:<br>


`owner`: The address of the contract owner.<br>
`tasks`: A mapping to store tasks, where each task is identified by a unique ID.<br>
`taskCount`: A counter for tracking the total number of tasks.<br>

## Functions
### 1. Modifier
**onlyOwner Modifier**<br>
Ensures that certain functions can only be called by the contract owner.

### 2. Task Functions

**addTask**<br>
Allows the contract owner to add tasks to the to-do list.<br>

**getTask**<br>
Retrieves task details based on the provided task ID.<br>

**getTaskByContent**<br>
Retrieves task details based on the task content.<br>

**updateTask**<br>
Allows the owner to update task details, including content and completion status.<br>

**markTaskCompleted**<br>
Allows the owner to mark a task as completed.<br>

**deleteTask**<br>
Deletes a task by shifting tasks and reducing taskCount, with an update of subsequent task IDs.<br>

**updateTaskId**<br>
Updates the ID of a task, facilitating the smooth deletion and shifting of tasks.<br>

**getAllTasks**<br>
Retrieves details of all tasks in the to-do list.<br>


### Resources

[1] https://www.dappuniversity.com/articles/blockchain-app-tutorial#listTasks <br>

[2] https://medium.com/unitechie/build-todo-application-in-react-and-solidity-538ef2f1f54f
