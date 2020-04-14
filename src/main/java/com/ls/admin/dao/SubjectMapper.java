package com.ls.admin.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * @author langxiaohua
 * date 2020-04-14
 */
@Repository
public interface SubjectMapper {

    //查找所有题目
    List<HashMap> selectSubject(@Param("pages") int pages, @Param("limit") int limit);
    //查找所有题目数量
    int selectSubjectCount();

    //查找所有题目模糊查找
//    List<HashMap> selectSubjectByName(@Param("subjectName") String subjectName,@Param("pages") int pages, @Param("limit") int limit);
    List<HashMap> selectSubjectByName(HashMap parme);
    //查找所有题目模糊查找数量
    int selectSubjectByNameCount(@Param("subjectName") String subjectName);

    String selectInsertId();
    //插入选项
    int insertAnswer(@Param("optionOne") String optionOne,@Param("content") String content);
    //插入题目
    int insertSubject(@Param("aId") String aId,@Param("bId") String bId,@Param("cId") String cId,
                      @Param("dId") String dId,@Param("trueOption") String trueOption,@Param("subjectName") String subjectName);

    //修改选项
    int updateAnswer(HashMap parme);
    //修改题目
    int updateSubject(HashMap parme);
}
