package com.example.todo_back.service;

import com.example.todo_back.domain.TaskItem;
import com.example.todo_back.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TaskServiceImpl implements TaskService {
    @Autowired
    private TaskRepository taskRepository;

    @Override
    public List<TaskItem> getTodayTasksByUserInfoId(Long userInfoId) {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.atTime(23, 59, 59);
        return taskRepository.findAllByUserInfoIdAndCreatedAtBetween(userInfoId, startOfDay, endOfDay);
    }

    @Override
    public List<TaskItem> getYesterdayTasksByUserInfoId(Long userInfoId) {
        LocalDate yesterday = LocalDate.now().minusDays(1);
        LocalDateTime startOfDay = yesterday.atStartOfDay();
        LocalDateTime endOfDay = yesterday.atTime(23, 59, 59);
        return taskRepository.findAllByUserInfoIdAndCreatedAtBetween(userInfoId, startOfDay, endOfDay);
    }
}
