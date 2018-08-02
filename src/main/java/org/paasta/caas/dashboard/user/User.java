package org.paasta.caas.dashboard.user;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

/**
 * The type User.
 */
@Setter
@Getter
@ToString
public class User {

    private long id;
    private String userId;
    private String userName;
    private String email;
    private String description;
    private LocalDateTime created;
    private LocalDateTime lastModified;
    private String createdString;
    private String lastModifiedString;
}
