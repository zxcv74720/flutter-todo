package com.example.todo_back.repository;

import com.example.todo_back.domain.TaskItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public interface TaskRepository extends JpaRepository<TaskItem, Long> {
    List<TaskItem> findByCreatedAtBetween(LocalDateTime startOfDay, LocalDateTime endOfDay);

    default List<TaskItem> findByCreatedAt(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(23, 59, 59);
        return findByCreatedAtBetween(startOfDay, endOfDay);
    }

    List<TaskItem> findByUserInfoId(Long userInfoId);

    default List<TaskItem> findByUserInfoIdAndCreatedAt(Long userInfoId, LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(23, 59, 59);
        List<TaskItem> tasksByCreatedAt = findByCreatedAtBetween(startOfDay, endOfDay);

        return tasksByCreatedAt.stream()
                .filter(task -> task.getUserInfoId().equals(userInfoId))
                .collect(Collectors.toList());
    }

    @Query("SELECT t FROM TaskItem t WHERE t.userInfo.id = :userInfoId AND t.createdAt BETWEEN :startOfDay AND :endOfDay")
    List<TaskItem> findAllByUserInfoIdAndCreatedAtBetween(@Param("userInfoId") Long userInfoId, @Param("startOfDay") LocalDateTime startOfDay, @Param("endOfDay") LocalDateTime endOfDay);
}