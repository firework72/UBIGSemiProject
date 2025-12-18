package com.ubig.app.community.service;

import java.util.List;
import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.community.CommentVO;

public interface CommunityService {

    // Board
    List<BoardVO> getBoardList();

    BoardVO getBoardDetail(int boardId);

    int insertBoard(BoardVO board);

    int updateBoard(BoardVO board);

    int deleteBoard(int boardId);

    // Comment
    List<CommentVO> getCommentList(int boardId);

    int insertComment(CommentVO comment);

    int deleteComment(int commentId);
}
