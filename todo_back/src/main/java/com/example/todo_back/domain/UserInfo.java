package com.example.todo_back.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class UserInfo {
    @Id
    private Long id;

    private String profileNickname;

    private String profileImage;

    private String accountEmail;
}
