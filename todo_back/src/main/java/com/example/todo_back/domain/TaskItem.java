package com.example.todo_back.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@EntityListeners(AuditingEntityListener.class)
public class TaskItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @NotNull(message = "title is required")
    private String title;
    private boolean done;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @Column(nullable = false, updatable = false)
    @NotNull(message = "dueTime is required")
    private LocalDateTime dueTime;

    @CreatedDate
    @Column(nullable = false)
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_info_id", referencedColumnName = "id")
    private UserInfo userInfo;

    @Column(name = "user_info_id", insertable = false, updatable = false)
    private Long userInfoId;

    public Long getUserInfoId() {
        return userInfoId;
    }
}
