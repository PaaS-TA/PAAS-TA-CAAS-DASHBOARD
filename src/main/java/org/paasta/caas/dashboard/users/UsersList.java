package org.paasta.caas.dashboard.users;

import lombok.Data;

import java.util.List;

@Data
public class UsersList {
    private String resultCode;
    private String resultMessage;

    private List<Users> items;
}
