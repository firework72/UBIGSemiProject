package com.ubig.app.community.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.community.CommentVO;

@Repository
public class CommunityDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    // Board
    public List<BoardVO> selectBoardList() {
        return sqlSession.selectList("communityMapper.selectBoardList");
    }

    public BoardVO selectBoardDetail(int boardId) {
        return sqlSession.selectOne("communityMapper.selectBoardDetail", boardId);
    }

    public int insertBoard(BoardVO board) {
        return sqlSession.insert("communityMapper.insertBoard", board);
    }

    public int updateBoard(BoardVO board) {
        return sqlSession.update("communityMapper.updateBoard", board);
    }

    public int deleteBoard(int boardId) {
        return sqlSession.delete("communityMapper.deleteBoard", boardId);
    }

    // Comment
    public List<CommentVO> selectCommentList(int boardId) {
        return sqlSession.selectList("communityMapper.selectCommentList", boardId);
    }

    public int insertComment(CommentVO comment) {
        return sqlSession.insert("communityMapper.insertComment", comment);
    }

    public int deleteComment(int commentId) {
        return sqlSession.delete("communityMapper.deleteComment", commentId);
    }
}
