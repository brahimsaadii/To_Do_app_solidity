// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TodoList {
    address public owner;
    
    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;

    event TaskCreated(uint256 id, string content, bool completed);
    event TaskUpdated(uint256 id, string content, bool completed);
    event TaskCompleted(uint256 id);
    event TaskDeleted(uint256 id);

    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function addTask(string memory _content) public onlyOwner {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
    }

    function getTask(uint256 _id) public view returns (uint256, string memory, bool) {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task memory task = tasks[_id];
        return (task.id, task.content, task.completed);
    }

    function getTaskByContent(string memory _content) public view returns (uint256, string memory, bool) {
        for (uint256 i = 1; i <= taskCount; i++) {
            string memory taskContent = tasks[i].content;
            if (keccak256(abi.encodePacked(taskContent)) == keccak256(abi.encodePacked(_content))) {
                return (tasks[i].id, taskContent, tasks[i].completed);
            }
        }
        revert("Task not found");
    }

    function markTaskCompleted(uint256 _id) public onlyOwner {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task storage task = tasks[_id];
        require(!task.completed, "Task is already completed");

        task.completed = true;
        emit TaskCompleted(_id);
    }


    function updateTask(uint256 _id, string memory _newContent, bool _newCompleted) public onlyOwner {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task storage task = tasks[_id];
        task.content = _newContent;
        task.completed = _newCompleted;
        emit TaskUpdated(_id, _newContent, _newCompleted);
    }

    function deleteTask(uint256 _id) public onlyOwner {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");

        emit TaskDeleted(_id);

        for (uint256 i = _id + 1; i <= taskCount; i++) {
            tasks[i] = tasks[i + 1];
            updateTaskId(i, i - 1);
        }

        delete tasks[taskCount];
        taskCount--;
    }

    function updateTaskId(uint256 _oldId, uint256 _newId) private onlyOwner {
        require(_oldId > 0 && _oldId <= taskCount, "Invalid old task ID");
        require(_newId > 0 && _newId <= taskCount, "Invalid new task ID");
        require(_oldId != _newId, "New task ID must be different from the old ID");

        Task storage task = tasks[_oldId];

        tasks[_newId] = Task(_newId, task.content, task.completed);

        emit TaskUpdated(_newId, task.content, task.completed);
    }

    function getAllTasks() public view returns (uint256[] memory, string[] memory, bool[] memory) {
        uint256[] memory taskIds = new uint256[](taskCount);
        string[] memory taskContents = new string[](taskCount);
        bool[] memory taskCompletedStatus = new bool[](taskCount);

        for (uint256 i = 1; i <= taskCount; i++) {
            taskIds[i - 1] = tasks[i].id;
            taskContents[i - 1] = tasks[i].content;
            taskCompletedStatus[i - 1] = tasks[i].completed;
        }

        return (taskIds, taskContents, taskCompletedStatus);
    }
}
