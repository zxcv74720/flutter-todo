package com.example.todo_back.controller;

import com.example.todo_back.domain.TaskItem;
import com.example.todo_back.repository.TaskRepository;
import com.example.todo_back.service.TaskService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping(path = "/tasks")
public class TaskController {
    private final TaskRepository taskRepository;

    @Autowired
    private TaskService taskService;

    public TaskController(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @GetMapping
    public ResponseEntity<List<TaskItem>> getTasks() {
        List<TaskItem> tasks = taskRepository.findAll();
        return ResponseEntity.ok(tasks);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<List<TaskItem>> getTasksByUserInfoId(@PathVariable Long userId) {
        List<TaskItem> tasks = taskRepository.findByUserInfoId(userId);
        return ResponseEntity.ok(tasks);
    }


    @GetMapping("/today/{userId}")
    public ResponseEntity<List<TaskItem>> getTodayTasksByUserInfoId(@PathVariable Long userId) {
        List<TaskItem> tasks = taskService.getTodayTasksByUserInfoId(userId);
        return ResponseEntity.ok(tasks);
    }

    @GetMapping("/yesterday/{userId}")
    public ResponseEntity<List<TaskItem>> getYesterdayTasksByUserInfoId(@PathVariable Long userId) {
        List<TaskItem> tasks = taskService.getYesterdayTasksByUserInfoId(userId);
        return ResponseEntity.ok(tasks);
    }

    @GetMapping("/yesterday")
    public ResponseEntity<List<TaskItem>> getYesterdayTasks() {
        LocalDate yesterday = LocalDate.now().minusDays(1);
        List<TaskItem> tasks = taskRepository.findByCreatedAt(yesterday);
        return ResponseEntity.ok(tasks);
    }

    @PostMapping("/add")
    public ResponseEntity<TaskItem> addTask(@Valid @RequestBody TaskItem taskItem) {
        TaskItem savedTaskItem = taskRepository.save(taskItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedTaskItem);
    }

    @PutMapping("/reAdd/{id}")
    public ResponseEntity<String> reAddYesterdayTask(@PathVariable Long id) {
        return taskRepository.findById(id)
                .map(task -> {
                    task.setCreatedAt(LocalDateTime.now());
                    taskRepository.save(task);
                    return ResponseEntity.ok("Saved the task again");
                })
                .orElse(ResponseEntity.badRequest().body("Task is not exist"));
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
