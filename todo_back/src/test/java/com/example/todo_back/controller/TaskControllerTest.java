package com.example.todo_back.controller;

import com.example.todo_back.domain.TaskItem;
import com.example.todo_back.repository.TaskRepository;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.mock;

@DisplayName("Task Controller")
class TaskControllerTest {

    @Disabled
    @DisplayName("[GET] 할 일 목록 불러오기")
    @Test
    void getTasks() {
        // Given
        TaskRepository taskRepository = mock(TaskRepository.class);
        TaskController taskController = new TaskController(taskRepository);

        // When
        ResponseEntity responseEntity = taskController.getTasks();

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @DisplayName("[POST] 할 일 추가하기")
    @Test
    void addTask() {
        // Given
        TaskItem taskItem = new TaskItem();
        taskItem.setId(1L);
        taskItem.setTitle("Test Task");
        taskItem.setDone(false);

        TaskRepository taskRepository = mock(TaskRepository.class);
        given(taskRepository.save(any(TaskItem.class))).willReturn(taskItem);
        TaskController taskController = new TaskController(taskRepository);

        // When
        ResponseEntity<TaskItem> responseEntity = taskController.addTask(taskItem);

        // Then
        assertEquals(HttpStatus.CREATED, responseEntity.getStatusCode());
        assertEquals(taskItem, responseEntity.getBody());
    }

    @DisplayName("[PUT] 할 일 상태 업데이트하기 - Task가 존재하는 경우")
    @Test
    void updateTask_TaskExists() {
        // Given
        TaskItem taskItem = new TaskItem();
        taskItem.setId(1L);
        taskItem.setTitle("Test Task");
        taskItem.setDone(false);

        TaskRepository taskRepository = mock(TaskRepository.class);
        given(taskRepository.findById(1L)).willReturn(Optional.of(taskItem));

        TaskController taskController = new TaskController(taskRepository);

        // When
        ResponseEntity<String> responseEntity = taskController.updateTask(1L);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Task is updated", responseEntity.getBody());
        assertEquals(true, taskItem.isDone()); // 상태가 반전되었는지 확인
    }

    @DisplayName("[DELETE] 할 일 삭제하기")
    @Test
    void deleteTask() {
        // Given
        Long taskId = 1L;
        TaskRepository taskRepository = mock(TaskRepository.class);
        given(taskRepository.existsById(taskId)).willReturn(true);
        TaskController taskController = new TaskController(taskRepository);

        // When
        ResponseEntity<String> responseEntity = taskController.deleteTask(taskId);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Task is deleted", responseEntity.getBody());
    }
}
