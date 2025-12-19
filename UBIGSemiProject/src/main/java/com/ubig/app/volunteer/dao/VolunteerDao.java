package com.ubig.app.volunteer.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.volunteer.ActivityVO;

@Repository
public class VolunteerDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<ActivityVO> selectActivityList() {
		// 매퍼의 namespace(volunteerMapper)와 id(selectActivityList)를 연결
		return sqlSession.selectList("volunteerMapper.selectActivityList");

	}

	public int insertActivity(ActivityVO a) {
		return sqlSession.insert("volunteerMapper.insertActivity", a);
	}

	// 3. 상세 조회
	public ActivityVO selectActivityOne(int actId) {
		return sqlSession.selectOne("volunteerMapper.selectActivityOne", actId);
	}
	
	// 4. 삭제
		public int deleteActivity(int actId) {
			return sqlSession.delete("volunteerMapper.deleteActivity", actId);
		}
		
		
	// 5. 수정
	public int updateActivity(ActivityVO a) {
			return sqlSession.update("volunteerMapper.updateActivity", a);
	}


}
