package com.example.todo_back.repository;

import com.example.todo_back.domain.TaskItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TaskRepository extends JpaRepository<TaskItem, Long> {
}
