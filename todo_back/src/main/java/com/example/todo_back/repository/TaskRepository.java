package com.example.todo_back.repository;

import com.example.todo_back.domain.TaskItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface TaskRepository extends JpaRepository<TaskItem, Long> {
    List<TaskItem> findByCreatedAtBetween(LocalDateTime startOfDay, LocalDateTime endOfDay);

    default List<TaskItem> findByCreatedAt(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(23, 59, 59);
        return findByCreatedAtBetween(startOfDay, endOfDay);
    }
}
