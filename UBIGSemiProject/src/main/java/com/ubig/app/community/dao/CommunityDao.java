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
    /*
     * [Step 2: DAO 수정]
     * Mapper에게 '이 카테고리 데이터만 줘'라고 전달하기 위해
     * 매개변수에 category를 추가했습니다.
     */
    public List<BoardVO> selectBoardList(String category) {
        return sqlSession.selectList("communityMapper.selectBoardList", category);
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

    public int deleteBoard(SqlSessionTemplate sqlSession, int boardId) {
        return sqlSession.update("communityMapper.deleteBoard", boardId);
    }

    public int increaseCount(SqlSessionTemplate sqlSession, int boardId) {
        return sqlSession.update("communityMapper.increaseCount", boardId);
    }

    // Comment
    public List<CommentVO> selectCommentList(int boardId) {
        return sqlSession.selectList("communityMapper.selectCommentList", boardId);
    }

    public int insertComment(CommentVO comment) {
        return sqlSession.insert("communityMapper.insertComment", comment);
    }

    public int updateComment(CommentVO comment) {
        return sqlSession.update("communityMapper.updateComment", comment);
    }

    public int deleteComment(int commentId) {
        return sqlSession.delete("communityMapper.deleteComment", commentId);
    }

    // Likes
    public int insertBoardLike(com.ubig.app.vo.community.BoardLikeVO like) {
        return sqlSession.insert("communityMapper.insertBoardLike", like);
    }

    public int deleteBoardLike(com.ubig.app.vo.community.BoardLikeVO like) {
        return sqlSession.delete("communityMapper.deleteBoardLike", like);
    }

    public int checkBoardLike(com.ubig.app.vo.community.BoardLikeVO like) {
        return sqlSession.selectOne("communityMapper.checkBoardLike", like);
    }

    public int countBoardLike(int boardId) {
        return sqlSession.selectOne("communityMapper.countBoardLike", boardId);
    }

    // Comment Likes
    public int insertCommentLike(com.ubig.app.vo.community.CommentLikeVO like) {
        return sqlSession.insert("communityMapper.insertCommentLike", like);
    }

    public int deleteCommentLike(com.ubig.app.vo.community.CommentLikeVO like) {
        return sqlSession.delete("communityMapper.deleteCommentLike", like);
    }

    public int checkCommentLike(com.ubig.app.vo.community.CommentLikeVO like) {
        return sqlSession.selectOne("communityMapper.checkCommentLike", like);
    }

    public int countCommentLike(int commentId) {
        return sqlSession.selectOne("communityMapper.countCommentLike", commentId);
    }
}
