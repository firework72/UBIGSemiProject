package com.ubig.app.vo.adoption;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdoptionMainListVO {
    // Post Data
    private int postNo; // 게시물 번호
    private String postTitle; // 제목
    private Date postUpdateDate; // 수정일
    private int views; // 조회수

    // Animal Data
    private int animalNo; // 동물 번호 (Link)
    private String photoUrl; // 사진 경로
    private String animalName; // 동물 이름 (확장성 고려)
    private String adoptionStatus; // 입양 상태
}
