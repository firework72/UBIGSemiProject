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
public class BoardAttachmentVO {
    private int fileId;
    private int boardId;
    private String refType;
    private String refId;
    private String originalName;
    private String savedName;
    private String filePath;
    private int fileSize;
    private Date createDate;
}
