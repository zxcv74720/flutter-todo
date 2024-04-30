package com.example.todo_back.controller;

import com.example.todo_back.domain.TaskItem;
import com.example.todo_back.domain.UserInfo;
import com.example.todo_back.repository.TaskRepository;
import com.example.todo_back.repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/login")
public class LoginController {
    private final UserRepository userRepository;

    public LoginController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @PostMapping("/sign")
    public ResponseEntity<UserInfo> addUserInfo(@Valid @RequestBody UserInfo userInfo) {
        UserInfo savedUserInfo = userRepository.save(userInfo);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedUserInfo);
    }
}
