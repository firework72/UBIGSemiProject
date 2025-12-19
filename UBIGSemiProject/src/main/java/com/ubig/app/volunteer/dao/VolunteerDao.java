package com.ubig.app.volunteer.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.volunteer.ActivitieVO;

@Repository
public class VolunteerDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<ActivitieVO> selectActivityList() {
		// 매퍼의 namespace(volunteerMapper)와 id(selectActivityList)를 연결
		return sqlSession.selectList("volunteerMapper.selectActivityList");

	}

	public int insertActivity(ActivitieVO a) {
		return sqlSession.insert("volunteerMapper.insertActivity", a);
	}

	// 3. 상세 조회
	public ActivitieVO selectActivityOne(int actId) {
		return sqlSession.selectOne("volunteerMapper.selectActivityOne", actId);
	}

}
