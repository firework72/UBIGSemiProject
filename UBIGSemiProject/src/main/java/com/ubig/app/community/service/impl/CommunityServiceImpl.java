package com.ubig.app.community.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ubig.app.community.dao.CommunityDao;
import com.ubig.app.community.service.CommunityService;
import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.community.CommentVO;

@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    private CommunityDao communityDao;

    @Override
    public List<BoardVO> getBoardList() {
        return communityDao.selectBoardList();
    }

    @Override
    public BoardVO getBoardDetail(int boardId) {
        return communityDao.selectBoardDetail(boardId);
    }

    @Override
    public int insertBoard(BoardVO board) {
        return communityDao.insertBoard(board);
    }

    @Override
    public int updateBoard(BoardVO board) {
        return communityDao.updateBoard(board);
    }

    @Override
    public int deleteBoard(int boardId) {
        return communityDao.deleteBoard(boardId);
    }

    @Override
    public List<CommentVO> getCommentList(int boardId) {
        return communityDao.selectCommentList(boardId);
    }

    @Override
    public int insertComment(CommentVO comment) {
        return communityDao.insertComment(comment);
    }

    @Override
    public int deleteComment(int commentId) {
        return communityDao.deleteComment(commentId);
    }
}
