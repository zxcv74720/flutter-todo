package com.example.todo_back.controller;

import com.example.todo_back.domain.TaskItem;
import com.example.todo_back.repository.TaskRepository;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/tasks")
public class TaskController {
    private final TaskRepository taskRepository;

    public TaskController(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @GetMapping
    public ResponseEntity<List<TaskItem>> getTasks() {
        List<TaskItem> tasks = taskRepository.findAll();
        return ResponseEntity.ok(tasks);
    }

    @PostMapping("/add")
    public ResponseEntity<TaskItem> addTask(@Valid @RequestBody TaskItem taskItem) {
        TaskItem savedTaskItem = taskRepository.save(taskItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedTaskItem);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateTask(@PathVariable Long id) {
        return taskRepository.findById(id)
                .map(task -> {
                    task.setDone(!task.isDone());
                    taskRepository.save(task);
                    return ResponseEntity.ok("Task is updated");
                })
                .orElse(ResponseEntity.badRequest().body("Task is not exist"));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteTask(@PathVariable Long id) {
        if (taskRepository.existsById(id)) {
            taskRepository.deleteById(id);
            return ResponseEntity.ok("Task is deleted");
        } else {
            return ResponseEntity.badRequest().body("Task is not exist");
        }
    }
}
