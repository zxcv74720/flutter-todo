package com.example.todo_back.service;

import com.example.todo_back.domain.TaskItem;

import java.util.List;

public interface TaskService {
    List<TaskItem> getTodayTasksByUserInfoId(Long userInfoId);

    List<TaskItem> getYesterdayTasksByUserInfoId(Long userInfoId);
}