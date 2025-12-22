package com.ubig.app.vo.community;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class BoardVO {
    private int boardId;
    private String userId;
    private String category;
    private String title;
    private String content;
    private Date createDate;
    private Date updateDate;
    private int viewCount;
    private String isDeleted;
    private String isPinned; // 'Y' or 'N'
}
